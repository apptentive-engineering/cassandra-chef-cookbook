require 'spec_helper'

describe package('git') do
  it { should be_installed }
end

describe file('/tmp/twcs-repo') do
  it { should be_directory }
end

describe file('/usr/local/maven') do
  it { should be_symlink }
end

describe file('/usr/share/cassandra/lib') do
  it { should be_directory }
end

describe file('/usr/share/cassandra/lib/TimeWindowCompactionStrategy-2.2.5.jar') do
  it { should be_file }
  it { should be_owned_by 'vagrant' }
  it { should be_grouped_into 'vagrant' }
end
