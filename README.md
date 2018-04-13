# autoupdates Cookbook

**NOTE:** This cookbook takes a permissive approach to automatically installing
updates - by default, it doesn't blacklist any package or repo. That being said,
there are enough attributes available that you should be able to scale back its
scope to suit your needs.

## Requirements

### Platforms

- Ubuntu 12.04+
- CentOS 5+
- RHEL 5+

### Chef

- Chef 12.1+ (because its `package` resource accepts an array of package names)

### Cookbooks

- [apt](https://supermarket.chef.io/cookbooks/apt) 2.5.0+
- [cron_wom](https://github.com/cla-rce/cron_wom)

## Usage

Set the `['autoupdates']['enable']` attribute to `true`, and include
`autoupdates` (or `autoupdates::default`) in your node's run list.

If you'd like your node to automatically reboot when needed by an update,
set `['autoupdates']['autoreboot']['enable']` to `true`, pick a different
reboot time if the default time doesn't meet your needs, and include
`autoupdates::autoreboot` in your node's run list.

## Recipes

### default

Installs and configures an appropriate automatic update service -
`unattended-upgrades` for `apt`, and `yum-cron` or `yum-updatesd` for `yum`.

### disable

Disables automatic updates by disabling and shutting down the appropriate
service and removing scheduled automatic reboots (if applicable). Packages and
config files are not removed.

### yum-updatesd

Installs and configures the `yum-updatesd` package (CentOS/RHEL 5).
Shouldn't need to be used directly - it is called (when appropriate) from
`autoupdates::default`.

### yum-cron

Installs and configures the `yum-cron` package (CentOS/RHEL 6+).
Shouldn't need to be used directly - it is called (when appropriate) from
`autoupdates::default`.

## Attributes

- `['autoupdates']['enable']` - Should automatic updates be enabled? (defaults
  to `false`)
- `['autoupdates']['apt']['exclude']` - Array of package names to exclude from
  automatic updates when using `apt`. Wildcards are accepted - e.g. 'libc6\*'
- `['autoupdates']['yum']['exclude']` - Array of package names to exclude from
  automatic updates when using `yum`. Wildcards are accepted - e.g. 'glibc\*'

There are a number of attributes specific to `yum-updatesd` and `yum-cron` that
this cookbook makes available. Descriptions of each attribute are available
in the templated config files for those packages.

When using `autoupdates::autoreboot`:

- `['autoupdates']['autoreboot']['enable']` - Should automatic reboots happen?
  (defaults to `false`)
- `['autoupdates']['autoreboot']['random_wait']` - Maximum amount of time to
  randomly wait before scheduling a reboot
- `['autoupdates']['autoreboot']['reboot_delay']` - How much warning to give
  users once the automatic reboot has been scheduled
- `['autoupdates']['autoreboot']['week_of_month']` - Week of the month when
  automatic reboots should occur - first / 1 / second / 2 / third / 3 /
  fourth / 4 / last.
- `['autoupdates']['autoreboot']['minute']`
- `['autoupdates']['autoreboot']['hour']`
- `['autoupdates']['autoreboot']['day_of_month']`
- `['autoupdates']['autoreboot']['month']`
- `['autoupdates']['autoreboot']['day_of_week']` - Sunday = 0|7, Monday = 1,
  Tuesday = 2, ...

The timing attributes are fed directly to a [cron_wom](https://github.com/cla-rce/cron_wom)
resource.

**NOTE 1:** It is possible to set conflicting options that will result in
a reboot never occurring (e.g. `week_of_month` = first and `day_of_month` = 8).

**NOTE 2:** Many cron implementations will execute a task if either
`day_of_month` matches **OR** `day_of_week` matches. Keep this in mind when
picking a time, and make use of `week_of_month` when necessary.

N.B.: These are some default cron daily/weekly/monthly times - you might want to
steer clear of them if you have any jobs that take a while to finish:

- CentOS 5: 04:02 / 04:22 / 04:42
- CentOS 6-7: 03:05 / 03:25 / 03:45, with up to 45 minutes of random delay
- Ubuntu 10-16: 06:25 / 06:47 / 06:52

## To-Do / Limitations

- There is no cookbook-provided method for excluding packages from automatic
updates when using `yum-updatesd` (CentOS/RHEL 5). As a workaround, packages
can be excluded manually via the `exclude` option in `/etc/yum.conf`. That
workaround isn't used in this cookbook because it affects all uses of `yum`,
not just `yum-updatesd`. If that's OK in your situation, you could use the
[yum](https://supermarket.chef.io/cookbooks/yum) cookbook to manage
`/etc/yum.conf`.

- `autoupdates::reboot` has a significant blind spot when attempting to figure
out whether a CentOS/RHEL 5 system needs to be rebooted, because there isn't a
system-provided "reboot checker" script.

## License & Authors

**Author:** Peter Walz, University of Minnesota ([pnw@umn.edu](mailto:pnw@umn.edu))

**Copyright:** 2016, Peter Walz and the Regents of the University of Minnesota

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
