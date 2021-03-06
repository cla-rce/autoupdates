#
# Cookbook Name:: autoupdates_test
# Recipe:: disable
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

guard_file = "#{Chef::Config.file_cache_path}/autoupdates_test_disable_phase1_done"

if File.exist?(guard_file)
  include_recipe 'autoupdates_test::disable_phase2'
  return
end

node.default['autoupdates']['enable'] = true
node.default['autoupdates']['autoreboot']['enable'] = true

include_recipe 'autoupdates'
include_recipe 'autoupdates::autoreboot'

file guard_file do
  content ''
end

ruby_block 'end phase 1' do
  # We're abusing the defined exit codes here, but with those exit codes
  # now being enforced (see https://docs.chef.io/deprecations_exit_code.html),
  # we don't have much choice.
  block do
    exit(3)
  end
end
