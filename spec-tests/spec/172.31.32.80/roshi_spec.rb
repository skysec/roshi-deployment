require 'spec_helper'

describe package('nginx')  do
  it { should be_installed }
end

describe port(80) do
  it { should be_listening }
end

describe package('redis-server') do
  it { should be_installed }
end

describe port(6379) do
  it { should be_listening } 
end

describe package('roshi-server') do
  it { should be_installed }
end

describe port('6302') do
  it { should be_listening }
end
