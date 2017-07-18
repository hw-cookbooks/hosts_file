name 'hosts_file'
maintainer 'Heavy Water Operations, LLC.'
maintainer_email 'helpdesk@heavywater.io'
license 'Apache-2.0'
description 'Provides managed hosts file'
source_url        'https://github.com/hw-cookbooks/hosts_file'
issues_url        'https://github.com/hw-cookbooks/hosts_file/issues'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.2.2'
chef_version '>= 12.1' if respond_to?(:chef_version)
%w(ubuntu debian redhat centos scientific oracle amazon).each do |os|
  supports os
end