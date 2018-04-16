case os[:family]
when 'debian'
  describe package('unattended-upgrades') do
    it { should be_installed }
  end

  describe package('debian-goodies') do
    it { should be_installed }
  end

  describe file('/etc/apt/apt.conf.d/20auto-upgrades') do
    its(:owner) { should eq 'root' }
    its(:group) { should eq 'root' }
    its(:mode) { should eq 0644 }
    its(:content) { should match /^APT::Periodic::Unattended-Upgrade "1";$/ }
  end

  describe file('/etc/apt/apt.conf.d/50unattended-upgrades') do
    its(:owner) { should eq 'root' }
    its(:group) { should eq 'root' }
    its(:mode) { should eq 0644 }
    its(:content) { should match /^Unattended-Upgrade::Allowed-Origins {\n\s+"\${distro_id}:\${distro_codename}";$/ }
  end

  describe file('/etc/apt/apt.conf.d/10dpkg-options') do
    its(:owner) { should eq 'root' }
    its(:group) { should eq 'root' }
    its(:mode) { should eq 0644 }
    its(:content) { should match /"--force-confdef";.*"--force-confold";/ }
  end

  script_line = 'if [ -f /var/run/reboot-required ]; then'

when 'redhat'
  case os[:release].to_i
  when 6
    describe package('yum-cron') do
      it { should be_installed }
    end

    describe service('yum-cron') do
      it { should be_enabled }
    end

    describe file('/etc/sysconfig/yum-cron') do
      its(:owner) { should eq 'root' }
      its(:group) { should eq 'root' }
      its(:mode) { should eq 0644 }
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
      its(:owner) { should eq 'root' }
      its(:group) { should eq 'root' }
      its(:mode) { should eq 0644 }
      its(:content) { should match /^apply_updates = yes$/ }
      its(:content) { should match /^output_width = 80$/ }
    end

    describe file('/etc/yum/yum-cron-hourly.conf') do
      its(:owner) { should eq 'root' }
      its(:group) { should eq 'root' }
      its(:mode) { should eq 0644 }
      its(:content) { should match /^apply_updates = no$/ }
      its(:content) { should match /^output_width = 80$/ }
    end

    describe file('/etc/cron.hourly/0yum-hourly.cron') do
      its(:owner) { should eq 'root' }
      its(:group) { should eq 'root' }
      its(:mode) { should eq 0644 }
    end

  end

  script_line = '   [ "$NEWEST_KERNEL_INSTALLTIME" -lt "$BOOTTIME" ]; then'
end

describe file('/usr/local/sbin/autoupdates-reboot-if-needed.sh') do
  its(:owner) { should eq 'root' }
  its(:group) { should eq 'root' }
  its(:mode) { should eq 0755 }
  its(:content) { should match /^#{Regexp.escape(script_line)}$/ }
end

describe command('crontab -l') do
  cron_line = "0 5 * * 6 [ `date '+\\%m'` -ne `date -d '-1 week' '+\\%m'` ] && /usr/local/sbin/autoupdates-reboot-if-needed.sh >/dev/null 2>&1"
  its(:stdout) { should match /^#{Regexp.escape(cron_line)}$/ }
end
