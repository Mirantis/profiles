# == Class: profiles::openstack::neutron::server
#
# Class for setting up a neutron controller
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
# === Copyright
#
# Copyright 2015 Mirantis Inc, unless otherwise noted.
#
class profiles::openstack::neutron::server {

  $config = hiera(neutron::config)
  $auth   = hiera(auth)
  $rabbit = hiera(rabbit::config)
  $openstack = hiera(openstack::config)

  # Setup the neutron class
  class { '::pmlc_neutron':
    debug                    => $config['debug'],
    is_server                => true,
    use_aci                  => $config['use_aci'],
    allow_overlapping_ips    => $config['allow_overlapping_ips'],
    api_workers              => $config['api_workers'],
    nova_admin_pass          => $auth['nova_admin_password'],
    rabbit_user              => $rabbit['user'],
    rabbit_password          => $rabbit['password'],
    admin_user               => $auth['neutron_admin_user'],
    admin_password           => $auth['neutron_admin_password'],
    database_pass            => $auth['neutron_db_pass'],
    rpc_workers              => $config['rpc_workers'],
    apic_hosts               => $config['apic_hosts'],
    apic_username            => $auth['apic_username'],
    apic_password            => $auth['apic_password'],
    apic_vpc_pairs           => $config['apic_vpc_pairs'],
    enable_isolated_metadata => $config['enable_isolated_metadata'],
    management_vip           => $openstack['management_vip'],
  }

}
