return if !['centos', 'redhat'].include?(node['platform'])

default['autoupdates']['yum']['exclude'] = []

case node['platform_version'].to_i
when 5
  default['yum-updatesd']['run_interval'] = 86400
  default['yum-updatesd']['updaterefresh'] = 600
  default['yum-updatesd']['emit_via'] = 'syslog'
  default['yum-updatesd']['do_update'] = 'yes'
  default['yum-updatesd']['do_download'] = 'yes'
  default['yum-updatesd']['do_download_deps'] = 'yes'
  default['yum-updatesd']['dbus_listener'] = 'no'
  default['yum-updatesd']['email_to'] = 'root@localhost'
  default['yum-updatesd']['email_from'] = 'yum-updatesd@localhost'
  default['yum-updatesd']['smtp_server'] = 'localhost:25'
  default['yum-updatesd']['syslog_facility'] = 'DAEMON'
  default['yum-updatesd']['syslog_level'] = 'WARN'

when 6
  default['yum-cron']['yum_parameter'] = []
  default['yum-cron']['check_only'] = 'no'
  default['yum-cron']['check_first'] = 'no'
  default['yum-cron']['download_only'] = 'no'
  default['yum-cron']['error_level'] = 0
  default['yum-cron']['debug_level'] = 0
  default['yum-cron']['randomwait'] = 60
  default['yum-cron']['mailto'] = 'root'
  default['yum-cron']['systemname'] = nil
  default['yum-cron']['days_of_week'] = '0123456'
  default['yum-cron']['cleanday'] = '0'
  default['yum-cron']['service_waits'] = 'yes'
  default['yum-cron']['service_wait_time'] = 300

else
  default['yum-cron']['daily']['update_cmd'] = 'default'
  default['yum-cron']['daily']['update_messages'] = 'yes'
  default['yum-cron']['daily']['download_updates'] = 'yes'
  default['yum-cron']['daily']['apply_updates'] = 'yes'
  default['yum-cron']['daily']['random_sleep'] = 60
  default['yum-cron']['daily']['system_name'] = 'None'
  default['yum-cron']['daily']['emit_via'] = 'stdio'
  default['yum-cron']['daily']['output_width'] = 80
  default['yum-cron']['daily']['email_from'] = 'root@localhost'
  default['yum-cron']['daily']['email_to'] = 'root'
  default['yum-cron']['daily']['email_host'] = 'localhost'
  default['yum-cron']['daily']['group_list'] = 'None'
  default['yum-cron']['daily']['group_package_types'] = ['mandatory', 'default']
  default['yum-cron']['daily']['debuglevel'] = '-2'
  default['yum-cron']['daily']['skip_broken'] = 'False'
  default['yum-cron']['daily']['mdpolicy'] = 'group:main'
  default['yum-cron']['daily']['assumeyes'] = 'False'

  default['yum-cron']['hourly']['update_cmd'] = 'default'
  default['yum-cron']['hourly']['update_messages'] = 'no'
  default['yum-cron']['hourly']['download_updates'] = 'no'
  default['yum-cron']['hourly']['apply_updates'] = 'no'
  default['yum-cron']['hourly']['random_sleep'] = 15
  default['yum-cron']['hourly']['system_name'] = 'None'
  default['yum-cron']['hourly']['emit_via'] = 'stdio'
  default['yum-cron']['hourly']['output_width'] = 80
  default['yum-cron']['hourly']['email_from'] = 'root@localhost'
  default['yum-cron']['hourly']['email_to'] = 'root'
  default['yum-cron']['hourly']['email_host'] = 'localhost'
  default['yum-cron']['hourly']['group_list'] = 'None'
  default['yum-cron']['hourly']['group_package_types'] = ['mandatory', 'default']
  default['yum-cron']['hourly']['debuglevel'] = '-2'
  default['yum-cron']['hourly']['skip_broken'] = 'False'
  default['yum-cron']['hourly']['mdpolicy'] = 'group:main'
  default['yum-cron']['hourly']['assumeyes'] = 'False'

end
