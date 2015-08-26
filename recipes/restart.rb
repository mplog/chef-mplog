#
# Cookbook Name:: chef-mplog
# Recipe:: restart
#

script_path = "#{node[:mplog][:script_dir]}/mplog.rb"

i = data_bag_item("mplog", "mysql")
Chef::Log.info "mplog data_bag hostname: #{i['hostname']}"
Chef::Log.info "mplog data_bag username: #{i['username']}"
Chef::Log.info "mplog data_bag password: #{i['password']}"
Chef::Log.info "mplog data_bag database: #{i['database']}"
if i['hostname'].empty? || i['username'].empty? || i['password'].empty? || i['database'].empty?
  Chef::Log.error "mplog data_bag params is not enough."
  exit 1
end

bash "mplog restart" do
  user  "root"
  group "root"
  code <<-EOF
  export MPLOG_HOST="#{i['hostname']}"
  export MPLOG_USER="#{i['username']}"
  export MPLOG_PASS="#{i['password']}"
  export MPLOG_DB="#{i['database']}"
  ruby #{script_path} stop
  ruby #{script_path} start
  EOF
end