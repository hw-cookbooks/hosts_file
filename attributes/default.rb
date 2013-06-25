default[:hosts_file][:path] = '/etc/hosts'
default[:hosts_file][:custom_entries] = {}

default[:hosts_file][:fqdn] = node[:fqdn]
default[:hosts_file][:hostname] = node[:hostname]
default[:hosts_file][:public_ips] = 'hostname' # or other value to set both hostname and fqdn
