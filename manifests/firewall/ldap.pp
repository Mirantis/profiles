# == Class: profiles::firewall::ldap
#
# Profile class for configuring the firewall on an ldap server 
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
# === Copyright
#
# Copyright 2015 Mirantis, Inc
#
class profiles::firewall::ldap {

  # Hiera lookups
  # Grab a hash of config to apply to the agent
  $config       = hiera_hash(firewall::rules)

  validate_string($config['ldaps_source_cidr'])

  firewall { "007 allow openldap traffic from ${config['ldaps_source_cidr']}":
    proto  => 'tcp',
    chain  => 'INPUT',
    dport  => '636',
    source => $config['ldaps_source_cidr'],
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
