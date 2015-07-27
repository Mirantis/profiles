# == Class: profiles::hiera
#
# Profile class to configure Hiera
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
class profiles::hiera {

  # Comment to test travis build
  # Install deep_merge gem for merged hashes in hiera
  package { 'deep_merge':
    ensure   => 'present',
    provider => 'gem',
  }

  # Call hiera module (relies on hunner/hiera)
  class { '::hiera':
    backends        => [
      'eyaml'
    ],
    hierarchy       => [
      '%{clientcert}',
      '%{application_tier}',
      '%{application_tier}/auth',
      '%{application_tier}/rabbit',
      '%{application_tier}/config',
      'defaults/datadog',
      'defaults/firewall',
      'defaults/ntp',
      'defaults/packages',
      'defaults/puppet',
      'defaults/ssh',
      'defaults/users',
      'defaults/yum',
    ],
    merge_behavior  => 'deeper',
    eyaml           => true,
    eyaml_datadir   => '/etc/puppet/environments/%{environment}/hieradata',
    eyaml_extension => 'yaml',
    create_keys     => true,
    datadir         => '/etc/puppet/environments/%{environment}/hieradata'
  }

}
