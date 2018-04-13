require_relative './spec_helper'

case os[:family]
when 'ubuntu'
  describe file('/etc/apt/apt.conf.d/20auto-upgrades') do
    its(:content) { should match /^APT::Periodic::Unattended-Upgrade "0";$/ }
  end

when 'redhat'
  describe service('yum-cron') do
    it { should_not be_enabled }
    it { should_not be_running }
  end

end

describe command('crontab -l') do
  its(:stdout) { should_not match /# Chef Name: autoupdates reboot/ }
end
