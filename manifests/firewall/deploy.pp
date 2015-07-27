# == Class: profiles::firewall::deploy
#
# Profile class for configuring the firewall on a deploy server to deploy r10k
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
# === Copyright
#
# Copyright 2015 Mirantis, Inc
#
class profiles::firewall::deploy {

  # Hiera lookups
  # Grab a hash of config to apply to the agent
  $config       = hiera_hash(firewall::rules)

  firewall { '007 allow traffic to sinatra app for r10k deploy':
    proto  => 'tcp',
    chain  => 'INPUT',
    dport  => '9292',
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
