# == Class: profiles::deploy
#
# Profile class to configure sinatra app to deploy code to puppetmasters
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
class profiles::deploy {

  # Grab our config
  $config = hiera('deploy::config')

  class { '::deploy':
    puppetmasters   => $config[puppetmasters],
    ssh_private_key => $config[ssh_private_key],
    group           => $config[group],
    mode            => $config[mode],
  }

}
