name              'newrelic_plugins'
maintainer        'Junius Wang'
maintainer_email  'wangjunbo924@gmail.com'
license           'MIT'
description       'Installs New Relic Plugins.'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '1.0.0'

recipe 'newrelic_plugins::pivotal_agent', 'Installs New Relic Pivotal Agent Plugin'
recipe 'newrelic_plugins::logwatcher', 'Installs New Relic logwatcher Plugin'

depends   "rvm"

%w{centos redhat }.each do |os|
  supports os
end