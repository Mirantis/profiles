# == Class: profiles::ntp::client
#
# Profile class for configuring an ntp client
#
# === Parameters
#
# This is a profile class and is therefore parameter-less. Gets included.
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
class profiles::ntp::client {

  # Hiera lookups
  $config = hiera(ntp::config)

  class { '::ntp':
    config   => $config['config'],
    servers  => $config['servers'],
    restrict => $config['restrict'],
    minpoll  => $config['minpoll'],
  }

}
