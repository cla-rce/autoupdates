name             'autoupdates'
maintainer       'Peter Walz, University of Minnesota'
maintainer_email 'pnw@umn.edu'
license          'Apache 2.0'
description      'Enables automatic updates via an appropriate method for supported platforms'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))

version          '1.1.6'

supports 'ubuntu', '>= 12.04'
supports 'redhat', '>= 5.0'
supports 'centos', '>= 5.0'

depends 'apt', '>= 2.5.0'
depends 'cron_wom'

chef_version '>= 12.1' if respond_to?(:chef_version)

source_url 'https://github.com/cla-rce/autoupdates' if respond_to?(:source_url)
issues_url 'https://github.com/cla-rce/autoupdates/issues' if respond_to?(:issues_url)
