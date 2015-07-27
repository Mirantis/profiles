# == Class: profiles::foreman::server
#
# Profile class to configure Foreman server
#
# === Parameters
#
# This is a parameter-less class and gets included from a role via 'include'
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
# === Copyright
#
# Copyright 2015 Mirantis Inc, unless otherwise noted.
#
class profiles::foreman::server {

  # Hiera lookups
  $config = hiera_hash(foreman::config)

  class { 'foreman':
    unattended            => $config['unattended'],
    passenger             => $config['passenger'],
    use_vhost             => $config['use_vhost'],
    servername            => $config['servername'],
    version               => $config['version'],
    db_manage             => $config['db_manage'],
    db_database           => $config['db_database'],
    db_username           => $config['db_username'],
    db_password           => $config['db_password'],
    puppet_home           => $config['puppet_home'],
    locations_enabled     => $config['locations_enabled'],
    organizations_enabled => $config['organizations_enabled'],
    admin_username        => $config['admin_username'],
    admin_password        => $config['admin_password'],
    admin_email           => $config['admin_email'],
    initial_organization  => $config['initial_organization'],
    initial_location      => $config['initial_location'],
    server_ssl_ca         => $config['server_ssl_ca'],
    server_ssl_cert       => $config['server_ssl_cert'],
    server_ssl_key        => $config['server_ssl_key'],
    server_ssl_crl        => $config['server_ssl_crl'],
    apipie_task           => $config['apipie_task'],
    oauth_consumer_key    => $config['oauth_key'],
    oauth_consumer_secret => $config['oauth_secret'],
  }

}
