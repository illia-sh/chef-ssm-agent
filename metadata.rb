name 'ssm-agent'
maintainer ''
maintainer_email 'illia.shpak@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures aws ssm agent'
long_description 'Installs/Configures ssm-agent'
version '0.1.0'
chef_version '>= 12.0'

issues_url 'https://github.com/illia-sh/chef-ssm-agent/issues'
source_url 'https://github.com/illia-sh/chef-ssm-agent.git'

%w(amazon centos redhat ubuntu).each do |os|
  supports os
end
