# Override the default (7) set in attributes/default
force_default['java']['jdk_version'] = 8

default['cassandra']['twcs']['base_version'] = node['cassandra']['version'].split('.')[0...-1].join('.')
default['cassandra']['twcs']['src_path'] = '/tmp/twcs-repo'
default['cassandra']['twcs']['repo_url'] = 'https://github.com/jeffjirsa/twcs.git'
default['cassandra']['twcs']['revision'] = "cassandra-#{node['cassandra']['twcs']['base_version']}"
default['cassandra']['twcs']['target_lib_path'] = '/usr/share/cassandra/lib'