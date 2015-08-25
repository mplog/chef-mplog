#
# Cookbook Name:: mplog
# Attributes:: default
#

default[:mplog][:log_dir] = "/var/log/mplog"
default[:mplog][:script_dir] = "/etc/mplog"
default[:mplog][:logrotate][:dateformat] = "-%Y%m%d"
default[:mplog][:logrotate][:rotate] = 5
default[:mplog][:period] = 60
default[:mplog][:td_agent][:use] = true
default[:mplog][:td_agent][:td_agent_gem] = '/usr/lib/fluent/ruby/bin/fluent-gem'
default[:mplog][:td_agent][:plugin_dir] = '/usr/lib/fluent/ruby/lib/ruby/gems/1.9.1/gems'
default[:mplog][:td_agent][:plugins] = [{"name" => "loggly", "version" => "0.0.6"}]
default[:mplog][:loggly][:token] = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
default[:mplog][:aws][:access_key] = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
default[:mplog][:aws][:secret_key] = 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
default[:mplog][:aws][:s3_bucket] = 'sample-bucket'