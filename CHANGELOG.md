# autoupdates Cookbook CHANGELOG

## 1.1.2 (2016-07-27)

- Move cron week-of-month logic to a separate cookbook ([cron_wom](https://github.com/cla-rce/cron_wom))
- Clean up some cookbook refs in Berksfile
- Switch to prettier `platform?` method in attributes files
- Make integration tests more portable by using the `crontab` command instead of
  reading crontab files directly

## 1.1.1 (2016-07-19)

- Fix escaping of '%' characters in cron tests
- Force some template attributes to be converted into integers (chef-client runs
  would fail if those attributes were entered as strings)

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
