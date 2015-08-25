#
# Cookbook Name:: mplog
# Recipe:: stop
#

script_path = "#{node[:mplog][:script_dir]}/mplog.rb"

bash "mplog restart" do
  user  "root"
  group "root"
  code <<-EOF
  ruby #{script_path} stop
  EOF
end