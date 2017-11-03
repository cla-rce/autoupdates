return if !platform?('ubuntu')

default['autoupdates']['apt']['exclude'] = []

# See https://github.com/chef-cookbooks/apt for info on attributes used by the
# 'apt' cookbook.
# See https://github.com/mvo5/unattended-upgrades for info on settings for the
# 'unattended-upgrades' OS package.

default['apt']['unattended_upgrades']['enable'] = node['autoupdates']['enable']
default['apt']['unattended_upgrades']['allowed_origins'] = [
  '${distro_id}:${distro_codename}',
  '${distro_id}:${distro_codename}-security',
  '${distro_id}:${distro_codename}-updates',
  '${distro_id}:${distro_codename}-backports'
]
default['apt']['unattended_upgrades']['package_blacklist'] = node['autoupdates']['apt']['exclude']
default['apt']['unattended_upgrades']['auto_fix_interrupted_dpkg'] = true
default['apt']['unattended_upgrades']['minimal_steps'] = true
default['apt']['unattended_upgrades']['remove_unused_dependencies'] = true
default['apt']['unattended_upgrades']['random_sleep'] = 900
