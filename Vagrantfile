# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.hostname = 'localtiles'

  config.omnibus.chef_version = '11.12.8'
  config.berkshelf.enabled = true
  config.vm.box = 'ubuntu-14.04-opscode'
  config.vm.box_url = 'http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_ubuntu-14.04_chef-provisionerless.box'

  config.vm.provider "virtualbox" do |v|
    v.memory = 5120
    v.cpus = 2
  end

  config.vm.synced_folder '.', '/vagrant', disabled: true
  # config.vm.synced_folder '/var/vagrant', '/var'

  config.vm.provision 'chef_solo' do |chef|
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
    # 'path' => '/var/vagrant',
    'path' => '',
    'pbf' => {
      'name' => 'nyc.pbf',
      'url' => 'https://s3.amazonaws.com/metro-extracts.mapzen.com/new-york_new-york.osm.pbf',
    },
    # will seed these tiles on initial run
    'tilequeue' => {
      'tiles' => {
        'custom' => {
          'zoom_start' => 11,
          'zoom_until' => 15,
          'bboxes' => [
            [-74.501, 40.345, -73.226, 41.097],
          ]
        }
      }
    },
  }
  chef.run_list = [
    'recipe[ohai]',
    'recipe[sudo]',
    'recipe[apt]',
    'recipe[git]',
    'recipe[python]',

    'recipe[vagrant-tiles::setup_paths]',

    'recipe[vagrant-tiles::pg_gem_workaround]',
    'recipe[postgresql::ruby]',
    'recipe[postgresql::client]',
    'recipe[postgresql::server]',
    'recipe[postgis]',

    'recipe[vagrant-tiles::tile_packages]',
    'recipe[osmosis]',
    'recipe[osm2pgsql]',
    'recipe[vagrant-tiles::checkout]',

    'recipe[vagrant-tiles::setup_database]',

    'recipe[redis::install_from_package]',

    'recipe[tilequeue::processor]',
    'recipe[tilequeue::tilediff]',
    'recipe[vagrant-tiles::seed]',

    'recipe[vagrant-tiles::osmupdate]',

    'recipe[tileserver]',

    'recipe[vagrant-tiles::nginx]',
    'recipe[vagrant-tiles::varnish]',
  ]

  end
end
