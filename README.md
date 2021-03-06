chef-mplog
=======================
- MySQL show full processlist logging Cookbook.
- Logging MySQL processlist.

Use Case
---------------
![mplog usecase](http://68.media.tumblr.com/ecac2ab4dcb98f7122e3be589c0d180d/tumblr_inline_ntmreaQFob1s8qrai_500.png)

1. Execute this recipe from OpsWorks to EC2.
2. Every 1 minute, Result of "show full processlist" will be outputted in JSON format.
3. Outputted log is sent to S3 and Loggly using fluentd.
4. Sent logs in S3 is notified by an event to Lambda.
5. Case beyond threshold, Lambda will notification to Slack.

Attributes of Cookbook
---------------
* `[:mplog][:log_dir]` - default /var/log/mplog
* `[:mplog][:script_dir]` - default /etc/mplog
* `[:mplog][:logrotate][:dateformat]` - default -%Y%m%d
* `[:mplog][:logrotate][:rotate]` - default 5
* `[:mplog][:period]` - execution interval default 60(sec)
* `[:mplog][:td_agent][:use]` - use td-agent default true
* `[:mplog][:td_agent][:td_agent_gem]` - td-agent gem file path
* `[:mplog][:td_agent][:plugin_dir]` - td-agent plugin dir path
* `[:mplog][:td_agent][:plugins]` - Example `default[:mplog][:td_agent][:plugins] = [{"name" => "loggly", "version" => "0.0.6"}]`
* `[:mplog][:loggly][:token]` - Loggly customer token
* `[:mplog][:aws][:access_key]` - AWS access key
* `[:mplog][:aws][:secret_key]` - AWS secret key
* `[:mplog][:aws][:s3_bucket]` - put to AWS S3 bucket


Custom JSON example
---------------
```json
{ 
  "opsworks": {
    "data_bags": {
      "mplog": {
        "mysql": { 
          "hostname": "localhost",
          "database": "foo_db",
          "username": "root-user",
          "password": "root-pass"
        }
      }
    }
  }
}
```
