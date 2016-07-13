require_relative './spec_helper'

case os[:family]
when 'ubuntu'
  describe file('/etc/apt/apt.conf.d/20auto-upgrades') do
    its(:content) { should match /^APT::Periodic::Unattended-Upgrade "0";$/ }
  end

when 'redhat'
  case os[:release].to_i
  when 5
    describe service('yum-updatesd') do
      it { should_not be_enabled }
      it { should_not be_running }
    end

  # v6+
  else
    describe service('yum-cron') do
      it { should_not be_enabled }
      it { should_not be_running }
    end
  end

end
