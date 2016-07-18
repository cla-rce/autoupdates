require_relative './spec_helper'

case os[:family]
when 'ubuntu'
  describe package('unattended-upgrades') do
    it { should be_installed }
  end

  describe file('/etc/apt/apt.conf.d/20auto-upgrades') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }
    its(:content) { should match /^APT::Periodic::Unattended-Upgrade "1";$/ }
  end

  describe file('/etc/apt/apt.conf.d/50unattended-upgrades') do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }
    its(:content) { should match /^Unattended-Upgrade::Allowed-Origins {\n\s+"\${distro_id}:\${distro_codename}";$/ }
  end

  script_line = 'if [ -f /var/run/reboot-required ]; then'
  crontab_path = '/var/spool/cron/crontabs/root'

when 'redhat'
  case os[:release].to_i
  when 5
    describe package('yum-updatesd') do
      it { should be_installed }
    end

    describe service('yum-updatesd') do
      it { should be_enabled }
      it { should be_running }
    end

    describe file('/etc/yum/yum-updatesd.conf') do
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      it { should be_mode 644 }
      its(:content) { should match /^run_interval = 600$/ }
    end

  when 6
    describe package('yum-cron') do
      it { should be_installed }
    end

    describe service('yum-cron') do
      it { should be_enabled }
    end

    describe file('/etc/sysconfig/yum-cron') do
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      it { should be_mode 644 }
      its(:content) { should match /^CHECK_ONLY="no"$/ }
    end

  # v7+
  else
    describe package('yum-cron') do
      it { should be_installed }
    end

    describe service('yum-cron') do
      it { should be_enabled }
    end

    describe file('/etc/yum/yum-cron.conf') do
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      it { should be_mode 644 }
      its(:content) { should match /^apply_updates = yes$/ }
      its(:content) { should match /^output_width = 80$/ }
    end

    describe file('/etc/yum/yum-cron-hourly.conf') do
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      it { should be_mode 644 }
      its(:content) { should match /^apply_updates = no$/ }
      its(:content) { should match /^output_width = 80$/ }
    end

  end

  script_line = '   [ "$NEWEST_KERNEL_INSTALLTIME" -lt "$BOOTTIME" ]; then'
  crontab_path = '/var/spool/cron/root'
end

describe file('/usr/local/sbin/autoupdates-reboot-if-needed.sh') do
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
  it { should be_mode 755 }
  its(:content) { should match /^#{Regexp.escape(script_line)}$/ }
end

describe file(crontab_path) do
  cron_line = Regexp.escape("0 5 * * 6 [ `date '+%m'` -ne `date -d '-1 week' '+%m'` ] && /usr/local/sbin/autoupdates-reboot-if-needed.sh >/dev/null 2>&1")
  its(:content) { should match /^#{cron_line}$/ }
end
