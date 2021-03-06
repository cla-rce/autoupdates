#
# Cookbook Name:: autoupdates
# Recipe:: default
#
# Copyright 2018, Peter Walz, (C) Regents of the University of Minnesota
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

return if !node['autoupdates']['enable']

case node['platform']
when 'ubuntu'
  return if node['platform_version'].to_f < 12.04
  include_recipe 'apt'
  include_recipe 'apt::unattended-upgrades'

when 'centos', 'redhat'
  case node['platform_version'].to_i
  when 5
    include_recipe 'autoupdates::yum-updatesd'
  else
    include_recipe 'autoupdates::yum-cron'
  end

end
