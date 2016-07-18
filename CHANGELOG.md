# autoupdates Cookbook CHANGELOG

## 1.1.0 (2016-07-18)

- Add the ability to automatically reboot systems
- Rename `disabled` test suite to `disable` for consistency with the recipe name
- Add the [cron](https://supermarket.chef.io/cookbooks/cron) cookbook to test
  suites to ensure a cron daemon is present (the CentOS 5
  [Bento](https://github.com/chef/bento) base box doesn't include one).

## 1.0.1 (2016-07-14)

- Update default mailto destination on CentOS/RHEL 6

## 1.0.0 (2016-07-13)

- Initial release
