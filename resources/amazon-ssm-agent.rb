# To learn more about Custom Resources, see https://docs.chef.io/custom_resources.html
resource_name :ssm_agent

actions :install, :remove
default_action :install

pkg_path = node['ssm_agent']['pkg']['path']

action :install do

  # Download package
  remote_file 'aws-ssm-agent' do
    path pkg_path   # path to the file where it will be created
    source node['ssm_agent']['pkg']['url']
    owner 'root'
    group 'root'
    mode 0644
  end

  # install ssm-agent
  # foodcritic FC109
  package 'amazon-ssm-agent' do
    source pkg_path
    provider value_for_platform_family(
  # https://www.rubydoc.info/github/opscode/chef/Chef/Provider/Package
         ['centos','redhat','amazon'] => Chef::Provider::Package::Yum,
         'suse' => Chef::Provider::Package::Zypper,
         ['debian','ubuntu'] => Chef::Provider::Package::Dpkg
    )
  end

  # start the service
  service node['ssm_agent']['svc']['name'] do
    provider value_for_platform(
    ['centos','redhat','amazon'] => { '>= 7.0' => Chef::Provider::Service::Systemd },
    'ubuntu' => { '>= 16.00' => Chef::Provider::Service::Systemd },
    'default' => Chef::Provider::Service::Upstart
  )
  # https://www.rubydoc.info/github/opscode/chef/Chef/Provider/Service#
    action value_for_platform(
      ['centos','redhat'] => { '< 7.0' => [:start] },
       'amazon' => {'>= 2018.03' => [:start]},
      'default' => [:enable, :start]
)
  end
end

 # remove downloaded files
action :remove do
  file pkg_path do
    action :delete
    only_if { ::File.exist? pkg_path }
  end

# stop service
  service node['ssm_agent']['svc']['name'] do
    provider value_for_platform(
    ['centos','rhel','amazon'] => { '>= 7.0' => Chef::Provider::Service::Systemd },
    'ubuntu' => { '>= 16.00' => Chef::Provider::Service::Systemd },
    'default' => Chef::Provider::Service::Upstart
  )
  # https://www.rubydoc.info/github/opscode/chef/Chef/Provider/Service#
    action [:disable, :stop]
  end

# remove agent
package 'amazon-ssm-agent' do
  action value_for_platform(
    ['ubuntu','debian'] => {
      'default' => :purge
    },
    'default' => :remove
    )
end

end
