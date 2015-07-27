# == Class: profiles::firewall::puppet
#
# Profile class for configuring the firewall on a Puppetmaster
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
# === Copyright
#
# Copyright 2015 Mirantis, Inc
#
class profiles::firewall::puppet {

  # Hiera lookups
  # Grab a hash of config to apply to the agent
  $config       = hiera_hash(firewall::rules)

  firewall { "007 allow puppet traffic from ${config['puppet_source_cidr']}":
    proto  => 'tcp',
    chain  => 'INPUT',
    dport  => '8140',
    source => $config['puppet_source_cidr'],
    action => 'accept',
  } ->

  Firewall {
  }

  class { '::firewall': }
  class { '::profiles::firewall::pre': }
  class { '::profiles::firewall::post': }

  Class['::firewall'] ->
  Class['::profiles::firewall::pre'] ->
  Class['::profiles::firewall::post']

}
