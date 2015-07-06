# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = 'localtiles'

  config.vm.box     = 'ubuntu-14.04-vagrant-current'
  config.vm.box_url = 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'

  config.vm.provider "virtualbox" do |v|
    v.memory = 5120
    v.cpus = 2
  end

  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.synced_folder '/var/vagrant', '/var/vagrant'

  config.vm.provision 'chef_solo' do |chef|
  chef.cookbooks_path = ['cookbooks', 'custom-cookbooks']
  chef.json = {
    'apt' => {
      'compile_time_update' => true
    },
    'authorization' => {
      'sudo' => {
        'users' => ['vagrant'],
        'passwordless' => true
      }
    },
    'postgresql' => {
      'password' => {
        'postgres' => 'postgres'
      },
      # 'config' => {
      #   'data_directory' => '/var/vagrant/postgresql'
      # }
    },
    # maybe we should just have a single path and implicitly put everything underneath that?
    'path' => {
      'tmp' => '/var/vagrant/tmp',
      'postgresql' => '/var/vagrant/postgresql',
      'tiles' => '/var/vagrant/tiles',
      'src' => '/var/vagrant/src',
      'etc' => '/var/vagrant/etc',
      'bin' => '/var/vagrant/bin',
      'var' => '/var/vagrant/var',
    },
    'pbf' => {
      'name' => 'nyc.pbf',
      'url' => 'https://s3.amazonaws.com/metro-extracts.mapzen.com/new-york_new-york.osm.pbf',
    },
  }
  chef.run_list = [
    'recipe[sudo]',
    'recipe[apt]',
    'recipe[ohai]',
    'recipe[git]',
    'recipe[python]',

    'recipe[mapzen_localtiles::setup_paths]',

    'recipe[mapzen_localtiles::pg_gem_workaround]',
    'recipe[postgresql::ruby]',
    'recipe[postgresql::client]',
    'recipe[postgresql::server]',
    'recipe[postgis]',

    'recipe[mapzen_localtiles::tile_packages]',
    'recipe[osmosis]',
    'recipe[osm2pgsql]',
    'recipe[mapzen_localtiles::checkout]',

    # conditionally runs create_database, download_pbf, and load_db_data recipes
    'recipe[mapzen_localtiles::setup_database]',

    'recipe[redis::install_from_package]',
    # 'recipe[redis::client]',
    # 'recipe[redis::server]',

    'recipe[tilestache::pip_requirements]',
    'recipe[mapzen_localtiles::tilestache_cfg]',

    'recipe[mapzen_localtiles::tilequeue_settings]',
    'recipe[tilequeue::config]',
    'recipe[tilequeue::install]',

    # 'recipe[varnish]',
  ]

  end
end
