#
# Cookbook:: ssm-agent
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.


if platform?('windows')
  include_recipe 'ssm-agent::windows' # todo
else
  include_recipe 'ssm-agent::linux'
end
