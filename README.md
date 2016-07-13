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
- Chef 12.1+

### Cookbooks
- [apt](https://supermarket.chef.io/cookbooks/apt) 2.5.0+

## Usage

Set the `['autoupdates']['enable']` attribute to `true`, and include
`autoupdates` (or `autoupdates::default`) in your node's run list.

## Recipes

### default

Installs and configures an appropriate automatic update service -
`unattended-upgrades` for `apt`, and `yum-cron` or `yum-updatesd` for `yum`.

### disable

Disables automatic updates by disabling and shutting down the appropriate
service; packages and config files are not removed.

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
  to false)
- `['autoupdates']['apt']['exclude']` - Array of package names to exclude from
  automatic updates when using `apt`. Wildcards are accepted - e.g. 'libc6\*'
- `['autoupdates']['yum']['exclude']` - Array of package names to exclude from
  automatic updates when using `yum`. Wildcards are accepted - e.g. 'glibc\*'

There are a number of attributes specific to `yum-updatesd` and `yum-cron` that
this cookbook makes available. Descriptions of each attribute are available
in the templated config files for those packages.

## To-Do / Limitations

- There is no cookbook-provided method for excluding packages from automatic
updates when using `yum-updatesd` (RHEL/CentOS 5). As a workaround, packages
can be excluded manually via the `exclude` option in `/etc/yum.conf`. That
workaround isn't used in this cookbook because it affects all uses of `yum`,
not just `yum-updatesd`. If that's OK in your situation, you could use the
[yum](https://supermarket.chef.io/cookbooks/yum) cookbook to manage
`/etc/yum.conf`.

- Testing of `autoupdates::disable` needs to be improved - at the moment,
testing fails on first run for CentOS / RHEL 5. After a second converge,
it works as expected.

- A recipe should be added to reboot the node at a predetermined time if
any updates have been installed that require a system reboot to implement
(e.g. a library that gets updated, and applications need to be restarted
to load the new version).

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
