source 'https://supermarket.getchef.com/'

metadata

cookbook 'apt'
cookbook 'cron_wom', git: 'git@github.com:cla-rce/cron_wom.git'

group :integration do
  cookbook 'cron'
  cookbook 'autoupdates_test', path: './test/cookbooks/autoupdates_test'
end
