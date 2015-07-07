name             'vagrant-tiles'
maintainer       'mapzen'
maintainer_email 'rob@mapzen.com'
license          'All rights reserved'
description      'Installs/Configures tile stack locally'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

supports 'ubuntu'

depends 'sudo'
depends 'apt'
depends 'ohai'
depends 'git'
depends 'python'

depends 'postgresql'
depends 'postgis'
depends 'database'
depends 'redis'
depends 'nginx'

depends 'osm2pgsql'
depends 'osmosis'
depends 'tilestache'
depends 'tilequeue'
