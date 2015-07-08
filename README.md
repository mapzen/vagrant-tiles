# vagrant-tiles

This will set up a vagrant image with all tile components in a single vm.

## Prerequisites

* vagrant
* vagrant omnibus plugin (`vagrant plugin install vagrant-omnibus`)

## Configuration

The [Vagrantfile](Vagrantfile) contains all configuration.

In particular, it is expecting that a `/var/vagrant` path exists on the host, and is where many files will be placed. This directory should already exist, and should be owned by the user that will be creating the image.

To set up that location:

```
sudo mkdir /var/vagrant
sudo chown `whoami`:`whoami` /var/vagrant
```

The Vagrantfile also has configuration to use 5 gigabytes of memory and 2 processors.

## Installation

    vagrant up

## Components running

* postgresql, will contain osm data based off of configured pbf file
* redis, serves as work queue and tracks tiles of interest
* minutely osmosis and osm2pgsql cron, pulls data from osm planet minutely diffs
* minutely tilequeue intersect, consumes osm2pgsql expired tiles and pushes work to redis
* tilequeue process, pulls work from redis and writes tiles to .../var/tiles
* tilestache service, runs on port 8000
* nginx used as cache over filesystem tiles at .../var/tiles, runs on port 8080
* varnish, will issue subrequests to nginx first, and on 404, will issue subrequest to tilestache
