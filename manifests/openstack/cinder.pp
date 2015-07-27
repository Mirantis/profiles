# == Class: profiles::openstack::cinder
#
# Class for setting up cinder
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
# === Copyright
#
# Copyright 2015 Mirantis Inc, unless otherwise noted.
#
class profiles::openstack::cinder {

  $config = hiera(cinder::config)
  $rabbit = hiera(rabbit::config)
  $auth   = hiera(auth)
  $openstack = hiera(openstack::config)

  class { '::pmlc_cinder':
    debug             => $config['debug'],
    use_ceph          => $config['use_ceph'],
    rabbit_user       => $rabbit['user'],
    rabbit_pass       => $rabbit['password'],
    admin_user        => $auth['cinder_user'],
    admin_password    => $auth['cinder_admin_password'],
    database_password => $auth['cinder_db_pass'],
    management_vip    => $openstack['management_vip'],
  }

}
