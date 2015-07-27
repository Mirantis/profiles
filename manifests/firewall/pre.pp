# == Class: profiles::firewall::pre
#
# Profile class for declaring firewall classes
# that should be defined first
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
# === Copyright
#
# Copyright 2015 Mirantis, Inc
#
class profiles::firewall::pre {

  # Hiera lookups
  $config = hiera_hash(firewall::rules)

  Firewall {
    require => undef,
  }

  # Default firewall rules
  firewall { '000 drop INVALID packets':
    proto  => 'all',
    state  => 'INVALID',
    action => 'drop',
  } ->

  firewall { '001 accept related and established connections':
    proto  => 'all',
    chain  => 'INPUT',
    state  => ['RELATED', 'ESTABLISHED'],
    action => 'accept',
  } ->

  # Accept all SSH connections from trusted hosts
  # firewall { "002 accept all SSH from ${config['ssh_source_cidr']}":
  #   proto  => 'tcp',
  #   chain  => 'INPUT',
  #   port   => '22',
  #   action => 'accept',
  #   source => $config['ssh_source_cidr'],
  # } ->

  # Enable SSH Throttling
  firewallchain { 'SSH:filter:IPv4':
    ensure  => present,
  } ->

  firewall { '003 set up ssh connection tracking':
    proto   => 'tcp',
    chain   => 'SSH',
    dport   => '22',
    ctstate => 'NEW',
    recent  => 'set',
    rname   => 'SSH',
    rsource => true,
  } ->

  firewall { '004 reject more than 10 new connections in 60 seconds':
    proto     => 'tcp',
    chain     => 'SSH',
    dport     => '22',
    ctstate   => 'NEW',
    recent    => 'update',
    rname     => 'SSH',
    rseconds  => '60',
    rhitcount => '10',
    rsource   => true,
    action    => 'reject',
    reject    => 'tcp-reset',
  } ->

  firewall { '005 accept new ssh connections':
    proto   => 'tcp',
    chain   => 'SSH',
    dport   => '22',
    ctstate => 'NEW',
    action  => 'accept',
  } ->

  firewall { '006 new ssh connections jump to SSH chain':
    proto => 'tcp',
    chain => 'INPUT',
    dport => '22',
    jump  => 'SSH',
  } ->

  firewall { "007 accept all ICMP from ${config['icmp_source_cidr']}":
    proto  => 'icmp',
    chain  => 'INPUT',
    action => 'accept',
    source => $config['icmp_source_cidr'],
  } ->

  firewall { '008 accept all to lo interface':
    proto   => 'all',
    iniface => 'lo',
    action  => 'accept',
  } ->

  firewall { '009 Reject local traffic not on loopback':
    iniface     => '! lo',
    proto       => 'all',
    destination => '127.0.0.1/8',
    action      => 'reject'
  } ->

  firewall { '010 allow all outbound traffic':
    proto  => 'all',
    chain  => 'OUTPUT',
    state  => ['NEW', 'RELATED', 'ESTABLISHED'],
    action => 'accept',
  }

}
