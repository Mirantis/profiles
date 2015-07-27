# == Class: profiles::openstack::nova::controller
#
# Class for setting up a nova controller
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
# === Copyright
#
# Copyright 2015 Mirantis Inc, unless otherwise noted.
#
class profiles::openstack::nova::controller {

  $config = hiera(nova::config)
  $auth   = hiera(auth)
  $rabbit = hiera(rabbit::config)
  $openstack = hiera(openstack::config)

  # Setup the nova class
  class { '::pmlc_nova':
    debug                  => $config['debug'],
    rabbit_pass            => $rabbit['password'],
    neutron_admin_pass     => $auth['neutron_admin_password'],
    nova_admin_password    => $auth['nova_admin_password'],
    nova_conductor_workers => $config['nova_conductor_workers'],
    nova_database_password => $auth['nova_db_pass'],
    role                   => 'controller',
    management_vip         => $openstack['management_vip'],
  }

}
