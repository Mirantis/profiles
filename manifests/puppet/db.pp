# == Class: profiles::puppet::db
#
# Profile class for configuring PuppetDB
#
# === Parameters
#
# This is a profile class and is therefore parameter-less. Gets included.
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
# === Copyright
#
# Copyright 2015 Mirantis, Inc
#
class profiles::puppet::db {

  # Hiera lookups
  # Grab a hash of config to apply to the agent
  $config = hiera(puppet::db::config)

  class { 'puppetdb':
    database                => $config['database'],
    database_username       => $config['database_username'],
    database_password       => $config['database_password'],
    database_name           => $config['database_name'],
    puppetdb_service_status => $config['service_status'],
    listen_address          => $config['listen_address'],
    ssl_listen_address      => $config['ssl_listen_address'],
    listen_port             => $config['listen_port'],
    ssl_listen_port         => $config['ssl_listen_port'],
    ssl_deploy_certs        => $config['ssl_deploy_certs']
  }

}
