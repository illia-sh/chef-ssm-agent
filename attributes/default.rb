default['ssm_agent']['svc']['name'] = 'amazon-ssm-agent'
default['ssm_agent']['pkg']['version'] = 'latest'
default['ssm_agent']['pkg']['action'] = 'install' # or [install or remove]

package = value_for_platform_family(
    ['rhel','centos','amazon','suse'] => 'amazon-ssm-agent.rpm',
                              'debian' => 'amazon-ssm-agent.deb',
                              'windows' => 'AmazonSSMAgent.msi'
                            )

# source for ssm_agent
default['ssm_agent']['pkg']['path'] = ::File.join(Chef::Config['file_cache_path'],package)
default['ssm_agent']['pkg']['url'] = format('https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/%s/%s/%s',default['ssm_agent']['pkg']['version'],
  value_for_platform_family(
    ['rhel','suse','amazon','centos'] => 'linux_amd64',
    'debian' => 'debian_amd64',
    'windows' => 'windows_amd64'),
    package)
