 # resource for install/remove ssm-agent
ssm_agent 'amazon-ssm-agent' do
  action node['ssm_agent']['pkg']['action']
end
