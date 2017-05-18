#
# Cookbook Name:: cassandra-dse
# Recipe:: claim_dirs
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

# Grab all the directories defined by the cookbook
dirs = node['cassandra']['data_dir'].dup
%w( commitlog saved_caches ).each do |dir|
  dir += '_dir'
  dirs << node['cassandra'][dir] if (node['cassandra'].has_key?(dir) && !dirs.include?(node['cassandra'][dir]))
end

# Grab the directories defined within cassandra.yaml
%w( commitlog hints saved_caches ).each do |dir|
  dir += '_directory'
  dirs << node['cassandra']['config'][dir] if (node['cassandra']['config'].has_key?(dir) && !dirs.include?(node['cassandra']['config'][dir]))
end

# Skip the directories that are children of the root directory
# (they already get chowned)
dirs.delete_if do |dir|
  root_dir = node['cassandra']['root_dir']
  dir[0...root_dir.size] == root_dir && (dir.size == root_dir.size || dir[root_dir.size] == ?/)
end

dirs.each do |dir|
  directory dir do
    user node['cassandra']['user']
    group node['cassandra']['group']
  end
end
