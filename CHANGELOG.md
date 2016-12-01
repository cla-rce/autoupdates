# autoupdates Cookbook CHANGELOG

## 1.1.5 (2016-12-01)

- Use the `node['packages']` attribute to determine if `update-notifier-common`
  is installed, instead of executing `dpkg-query`.

## 1.1.4 (2016-09-22)

- Fix usage of `dpkg-query` so it works properly on Ubuntu 12.04
- Update OS list in `.kitchen.yml`, add `chefignore`

## 1.1.3 (2016-08-18)

- Work around a problem that was preventing the `update-notifier-common` package
  from being automatically installed.
- Integration testing: add `apt` to run lists to ensure Apt's cache is
  up-to-date, ensure the `debian-goodies` package is installed.

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
