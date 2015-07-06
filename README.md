# vagrant-tiles

This will set up a vagrant image with all tile components in a single vm.

# Prerequisites

* vagrant
* librarian-chef

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

```
librarian-chef install
vagrant up
```
