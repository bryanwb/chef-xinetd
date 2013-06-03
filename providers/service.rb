action :add do

  resource = template "/etc/xinetd.d/#{new_resource.app_name}" do
    cookbook 'xinetd'
    source 'xinetd_service.erb'
    mode '0644'
    variables(
      :app_name => new_resource.app_name,
      :port => new_resource.port,
      :server => new_resource.server
    )
    notifies :restart, "service[xinetd]"
    action :nothing
  end

  ruby_block "Record xinetd service: #{new_resource.app_name}" do
    block do
      node.default['xinetd'][new_resource.app_name]["port"]   = new_resource.port
      node.default['xinetd'][new_resource.app_name]["server"] = new_resource.server
      node.save
    end
    action :create
    notifies :create, "template[/etc/services]", :delayed
  end

  template "/etc/services" do
    cookbook 'xinetd'
    source "services.erb"
    mode '0644'
    action :nothing
    notifies :restart, "service[xinetd]"
  end

  resource.run_action(:create)
  new_resource.updated_by_last_action(true) if resource.updated_by_last_action?
end
