case node[:hosts_file][:define_self]
when 'ip_address'
  hosts_file_entry '127.0.0.1' do
    hostname 'localhost'
  end
  hosts_file_entry node.ipaddress do
    hostname node.fqdn
    aliases node.hostname
  end
when 'localhost_only'
  hosts_file_entry '127.0.0.1' do
    hostname 'localhost'
  end
else
  hosts_file_entry '127.0.0.1' do
    hostname 'localhost'
    aliases [node.fqdn, node.hostname]
  end
end

template "managed_hosts_file" do
  source 'hosts.erb'
  path node[:hosts_file][:path]
  mode 0644
  action :nothing
end

ruby_block "hosts_file_notifier" do
  block do
    true
  end
  notifies :create, resources(:template => "managed_hosts_file"), :delayed
end
