name             'vagrant-tiles'
maintainer       'mapzen'
maintainer_email 'rob@mapzen.com'
license          'All rights reserved'
description      'Installs/Configures tile stack locally'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.0'

supports 'ubuntu'

depends 'database'

depends 'sudo'
depends 'apt'
depends 'ohai'
depends 'git'
depends 'python'

depends 'postgresql'
depends 'postgis'
depends 'database'
depends 'redis'
depends 'varnish'

depends 'osm2pgsql'
depends 'tilestache'
depends 'tilequeue'
