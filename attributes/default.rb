default['autoupdates']['enable'] = false
default['autoupdates']['autoreboot']['enable'] = false

default['autoupdates']['autoreboot']['random_wait'] = 30
default['autoupdates']['autoreboot']['reboot_delay'] = 0
# [first|1|second|2|third|3|fourth|4|last]
default['autoupdates']['autoreboot']['week_of_month'] = 'first'
default['autoupdates']['autoreboot']['minute'] = '0'
default['autoupdates']['autoreboot']['hour'] = '5'
default['autoupdates']['autoreboot']['day_of_month'] = '*'
default['autoupdates']['autoreboot']['month'] = '*'
# Sunday = 0|7, Monday = 1, Tuesday = 2, ...
default['autoupdates']['autoreboot']['day_of_week'] = '6'
