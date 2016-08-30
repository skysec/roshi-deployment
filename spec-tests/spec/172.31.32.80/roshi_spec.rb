require 'spec_helper'

describe service('nginx')  do
  it { should be_enabled }
  it { should be_running }
end

describe port(80) do
  it { should be_listening }
end

describe service('redis-server') do
  it { should be_enabled }
  it { should be_running }
end

describe port(6379) do
  it { should be_listening } 
end

describe service('roshi') do
  it { should be_enabled }
  it { should be_running }
end

describe port('6302') do
  it { should be_listening }
end

describe "nginx is supervised" do
  describe service('nginx') do
    let(:pre_command) { 'killall -9 nginx' }
    it { should be_running }
  end
end

describe "redis-server is supervised" do
  describe service('redis-server') do
    let(:pre_command) { 'killall -9 redis-server' }
    it { should be_running }
  end
end

describe "roshi-server is supervised" do
  describe service('roshi') do
    let(:pre_command) { 'killall -9 roshi-server' }
    it { should be_running }
  end
end

describe "firewall should have a drop policy fof input packets" do
  describe iptables do
    it { should have_rule('-P INPUT DROP') }
  end
end

describe "firewall should allow SSH from everywhere" do
  describe iptables do
    it { should have_rule('-p tcp -m tcp --dport 22 -j ACCEPT').with_table('filter').with_chain('ufw-user-input') }
  end
end

describe "firewall should allow HTTP only for network 172.31.32.0/24" do
  describe iptables do
    it { should have_rule('-s 172.31.32.0/24 -p tcp -m tcp --dport 80 -j ACCEPT').with_table('filter').with_chain('ufw-user-input') }
  end
end

