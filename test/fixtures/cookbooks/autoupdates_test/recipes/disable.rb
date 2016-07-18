#
# Cookbook Name:: autoupdates_test
# Recipe:: disabled
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

node.default['autoupdates']['enable'] = true
node.default['autoupdates']['autoreboot']['enable'] = true
include_recipe 'autoupdates'
include_recipe 'autoupdates::autoreboot'

# Would be nice to somehow force a converge here, because a delayed :restart
# from autoupdates::yum-updatesd runs after a delayed :stop from
# autoupdates::disable. This triggers a converge, but doesn't remove the
# resources from the run_context:
#Chef::Runner.new(run_context).converge
#
# The signficance of all of this is that we have to run chef-client twice
# to get the expected results on yum-updatesd systems (CentOS/RHEL 5).

node.default['autoupdates']['enable'] = false
include_recipe 'autoupdates::disable'
