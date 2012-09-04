def load_current_resource
  new_resource.ip_address new_resource.name unless new_resource.ip_address
  if(new_resource.comment && !new_resource.comment.start_with?('#'))
    new_resource.comment "# #{new_resource.comment}"
  end
  node[:hosts_file][:maps] ||= {}
end

action :create do
  ruby_block "hosts_file create[#{new_resource.name}]" do
    block do
      node[:hosts_file][:maps][new_resource.ip_address] = %w(hostname aliases comment).map{|item|
        Array(new_resource.send(item))
      }.inject(&:+).join(' ')
      new_resource.updated_by_last_action(true)
    end
    only_if do
      node[:hosts_file][:maps][new_resource.ip_address].nil? ||
      node[:hosts_file][:maps][new_resource.ip_address] != %w(hostname aliases comment).map{|item|
        Array(new_resource.send(item))
      }.inject(&:+).join(' ')
    end
  end
end

action :delete do
  ruby_block "hosts_file delete[#{new_resource.ip_address}]" do
    block do
      node[:hosts_file][:maps].delete(new_resource.ip_address)
      new_resource.updated_by_last_action(true)
    end
    not_if do
      node[:hosts_file][:maps][new_resource.ip_address].nil?
    end
  end
end
