#
# Cookbook Name:: autoupdates
# Recipe:: yum-cron
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

package 'yum-cron'

# It isn't necessary to restart the yum-cron service after updating its
# config file(s) because yum-cron parses its config every time it runs.

case node['platform_version'].to_i
when 6
  template '/etc/sysconfig/yum-cron' do
    source 'yum-cron.erb'
    owner 'root'
    group 'root'
    mode '0644'
  end

else
  template '/etc/yum/yum-cron.conf' do
    source 'yum-cron.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables :params => node['yum-cron']['daily'].to_hash
  end

  template '/etc/yum/yum-cron-hourly.conf' do
    source 'yum-cron.conf.erb'
    owner 'root'
    group 'root'
    mode '0644'
    variables :params => node['yum-cron']['hourly'].to_hash
  end

  file '/etc/cron.hourly/0yum-hourly.cron' do
    if node['yum-cron']['hourly']['enable']
      mode '0755'
    else
      mode '0644'
    end
  end
end

service 'yum-cron' do
  action [:enable, :start]
end
