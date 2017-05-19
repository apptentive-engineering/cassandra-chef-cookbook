#
# Cookbook Name:: cassandra-dse
# Recipe:: twcs
#
# Copyright 2017 Apptentive, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

cassandra = node['cassandra']
twcs = cassandra['twcs']

include_recipe 'git::default'

directory twcs['src_path'] do
  recursive true
end

git twcs['src_path'] do
  repository twcs['repo_url']
  revision twcs['revision']
  action :sync
end

include_recipe 'java' if cassandra['install_java']

include_recipe 'maven::default'

bash 'compile TWCS plugin' do
  cwd twcs['src_path']
  code 'mvn compile && mvn package'
  environment ({ "JAVA_HOME" => node[:java][:java_home] })
end

directory twcs['target_lib_path'] do
  recursive true
  user cassandra['user']
  group cassandra['group']
  mode 0755
end

ruby_block 'install TWCS' do
  block do
    find_jar_glob = File::join(twcs['src_path'], 'target', "TimeWindowCompactionStrategy-#{cassandra['base_version']}*.jar")
    compiled_jar = Dir.glob(find_jar_glob).first
    jar_target = File::join(twcs['target_lib_path'], File::basename(compiled_jar))

    FileUtils.mv(compiled_jar, jar_target)
    FileUtils.chown(cassandra['user'], cassandra['group'], jar_target)
  end
end