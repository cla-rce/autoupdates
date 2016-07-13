source 'https://supermarket.getchef.com/'

metadata

cookbook 'apt', git: 'git@github.com:opscode-cookbooks/apt.git'

group :integration do
  cookbook 'autoupdates_test', path: './test/fixtures/cookbooks/autoupdates_test'
end
