include_recipe 'hosts_file'

node[:hosts_file][:custom_entries].each do |ip, hosts|
  host_ar = Array(hosts).dup
  hn = host_ar.shift
  als = host_ar
  hosts_file_entry ip do
    hostname hn
    aliases als unless als.empty?
    comment "Provided via hosts_file custom entry"
  end
end
