#
# Cookbook:: iis
# Resource:: install
#
# Copyright:: 2018-2019, Chef Software, Inc.
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

unified_mode true

include IISCookbook::Helper

property :source, String
property :additional_components, Array, default: []

action :install do
  features_to_install = ['IIS-WebServerRole'].concat new_resource.additional_components

  windows_feature 'Install IIS and additional components' do
    feature_name features_to_install
    action :install
    all !IISCookbook::Helper.older_than_windows2012?
    source new_resource.source unless new_resource.source.nil?
  end
end
