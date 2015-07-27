# == Class: profiles::openstack::keystone
#
# Class for setting up keystone
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
# === Copyright
#
# Copyright 2015 Mirantis Inc, unless otherwise noted.
#
class profiles::openstack::keystone {

  $config    = hiera(keystone::config)
  $rabbit    = hiera(rabbit::config)
  $auth      = hiera(auth)
  $openstack = hiera(openstack::config)

  class { '::pmlc_keystone':
    debug               => $config['debug'],
    use_ad              => $config['use_ad'],
    rabbit_pass         => $rabbit['password'],
    database_password   => $auth['keystone_db_pass'],
    public_workers      => $config['public_workers'],
    admin_workers       => $config['admin_workers'],
    memcache_dead_retry => $config['memcache_dead_retry'],
    dead_retry          => $config['dead_retry'],
    socket_timeout      => $config['socket_timeout'],
    bind_user           => $auth['bind_user'],
    ldap_password       => $auth['ldap_password'],
    management_vip      => $openstack['management_vip'],
  }

}
