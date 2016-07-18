source 'https://supermarket.getchef.com/'

metadata

cookbook 'apt', git: 'git@github.com:chef-cookbooks/apt.git'

group :integration do
  cookbook 'cron', git: 'git@github.com:chef-cookbooks/cron.git'
  cookbook 'autoupdates_test', path: './test/fixtures/cookbooks/autoupdates_test'
end
