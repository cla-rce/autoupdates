#
# Cookbook Name:: autoupdates
# Recipe:: disable
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

if node['autoupdates']['enable']
  Chef::Log.warn("autoupdates::disable: returning because node['autoupdates']['enable'] is true")
  return
end

case node['platform']
when 'ubuntu'
  include_recipe 'apt::unattended-upgrades'

when 'centos', 'redhat'
  case node['platform_version'].to_i
  when 5
    service 'yum-updatesd' do
      action [:disable, :stop]
    end
  else
    service 'yum-cron' do
      action [:disable, :stop]
    end
  end

end
