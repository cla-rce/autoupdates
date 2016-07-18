#
# Cookbook Name:: autoupdates
# Recipe:: autoreboot
#
# Copyright 2016, Peter Walz, (C) Regents of the University of Minnesota
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

return if !(node['autoupdates']['enable'] && node['autoupdates']['autoreboot']['enable'])

case node['platform']
when 'ubuntu'
  return if node['platform_version'].to_f < 12.04

  # update-notifier-common might not be included on some minimal installations,
  # and we need it to ensure that reboot notifications are issued (even if
  # we're not rebooting automatically). It does catch kernel updates.
  #
  # debian-goodies includes the 'checkrestart' script, which, like the
  # 'needs-restarting' script for CentOS/RHEL, gives us an idea of whether we
  # need to reboot. Also like 'needs-restarting', it misses the case where only
  # the kernel has been updated.
  package ['update-notifier-common', 'debian-goodies']

when 'centos', 'redhat'
  case node['platform_version'].to_i
  when 5
    # For CentOS/RHEL 5, there do not seem to be any system-provided utilities
    # for determining whether the system needs to be rebooted.
  else
    # yum-utils includes the 'needs-restarting' script, which gives us an
    # idea of whether the system needs to be rebooted due to recently-installed
    # updates. It's not perfect, however - it bases its recommendation on
    # whether any currently-running process has files open that belong to
    # a package, and if so, whether the process is older than the last-updated
    # time for that package. One annoying case that it will miss is when only
    # the kernel has been udpated.
    package 'yum-utils'
  end

end

directory '/usr/local/sbin' do
  owner 'root'
  group 'root'
  mode '0755'
end

template '/usr/local/sbin/autoupdates-reboot-if-needed.sh' do
  source 'autoupdates-reboot-if-needed.sh.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

case node['autoupdates']['autoreboot']['week_of_month']
when /^(1|first)/i
  week_test = "[ `date '+\%m'` -ne `date -d '-1 week' '+\%m'` ] &&"
when /^(2|second)/i
  week_test = "[ `date '+\%m'` -eq `date -d '-1 week' '+\%m'` ] &&"
when /^(3|third)/i
  week_test = "[ `date '+\%m'` -eq `date -d '-2 week' '+\%m'` ] &&"
when /^(4|fourth)/i
  week_test = "[ `date '+\%m'` -eq `date -d '-3 week' '+\%m'` ] &&"
when /^last/i
  week_test = "[ `date '+\%m'` -ne `date -d '+1 week' '+\%m'` ] &&"
else
  week_test = ''
end

cron 'autoupdates reboot' do
  # Would rather set MAILTO='' instead of using output redirection, but a bug
  # in Chef prevents us from doing so (see https://github.com/chef/chef/pull/311
  # and https://github.com/chef/chef/issues/4900 ).
  command "#{week_test} /usr/local/sbin/autoupdates-reboot-if-needed.sh >/dev/null 2>&1"
  user 'root'
  minute node['autoupdates']['autoreboot']['minute']
  hour node['autoupdates']['autoreboot']['hour']
  day node['autoupdates']['autoreboot']['day_of_month']
  month node['autoupdates']['autoreboot']['month']
  weekday node['autoupdates']['autoreboot']['day_of_week']
end
