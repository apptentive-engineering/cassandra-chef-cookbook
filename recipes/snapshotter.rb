#
# Cookbook Name:: cassandra-dse
# Recipe:: snapshotter
#
# Copyright 2018 Apptentive, Inc.
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

package 'lzop'
package 'pv'

execute 'install cassandra_snapshotter' do
  command 'pip install cassandra_snapshotter==1.0.0'
  not_if 'pip list 2>/dev/null | grep -q "cassandra-snapshotter (1.0.0)"'
end

execute 'install setuptools' do
  command 'pip install setuptools==44.0.0'
  not_if 'pip list 2>/dev/null | grep -q "setuptools (44.0.0)"'
end

execute 'install fabric' do
  command 'pip install fabric==1.14.0'
  not_if 'pip list 2>/dev/null | grep -q "Fabric (1.14.0)"'
end

