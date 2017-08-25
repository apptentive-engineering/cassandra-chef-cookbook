require 'spec_helper'

describe file('/usr/share/cassandra/lib/TimeWindowCompactionStrategy-2.2.5.jar') do
  it { should be_file }
  it { should be_owned_by 'vagrant' }
  it { should be_grouped_into 'vagrant' }
  it { should be_mode 755 }
end
