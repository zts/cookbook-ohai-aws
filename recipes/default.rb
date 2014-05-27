#
# Cookbook Name:: ohai-aws
# Recipe:: default
#
# Copyright (C) 2013 Zachary Stevens
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "xml::ruby"
chef_gem "aws-sdk"

# Do this by hand to avoid reloading ohai.
remote_directory "/etc/chef/ohai_plugins" do
  source 'ohai_plugins'
  mode '0755'
  recursive true
  purge false
  action :create
end
