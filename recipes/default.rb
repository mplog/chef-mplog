#
# Cookbook Name:: mplog
# Recipe:: default
#

script_path = "#{node[:mplog][:script_dir]}/mplog.rb"

# gem install
gem_package "mysql" do
  action :install
end
gem_package "daemons" do
  action :install
end

# mkdir log_dir
directory node[:mplog][:log_dir] do
  action    :create
  owner     "root"
  group     "root"
  mode      0755
  recursive true
end

# mkdir script_dir
directory node[:mplog][:script_dir] do
  action    :create
  owner     "root"
  group     "root"
  mode      0755
  recursive true
end

# script file
template script_path do
  mode   '0644'
  owner  'root'
  group  'root'
  source 'mplog.rb.erb'
end

# logrotate
template "/etc/logrotate.d/mplog" do
  backup false
  source "logrotate.erb"
  owner  "root"
  group  "root"
  mode   0644
end

# td-agent
if node[:mplog][:td_agent][:use]
  template "/etc/td-agent/conf.d/mplog.conf" do
    mode "0644"
    source "td-agent.conf.erb"
  end
  
  node[:mplog][:td_agent][:plugins].each do |plugin|
    execute "install-plugin" do
      command "#{node[:mplog][:td_agent][:td_agent_gem]} install fluent-plugin-#{plugin.name} -v #{plugin.version}" 
      action :run
      not_if { File.exist?("#{node[:mplog][:td_agent][:plugin_dir]}/fluent-plugin-#{plugin.name}-#{plugin.version}") }
    end
  end
  
  service "td-agent" do
    action :restart
  end
end

include_recipe "mplog::restart"
