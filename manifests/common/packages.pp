# == Class: profiles::common::packages
#
# This class ensures that the default/common packages
# that we want on every box are installed. These packages
# are agnostic to any particular service or application that
# should be running. Things like rsync, bc, wget, strace, etc.
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#

class profiles::common::packages {
  # Hiera lookup to get a list of packages to install by default
  # These will all be things that won't hurt by being the latest
  $packages = $::operatingsystem ? {
    'CentOS' => hiera_array("${::operatingsystem}::${::operatingsystemmajrelease}::packages"),
    'Ubuntu' => hiera_array("${::operatingsystem}::${::lsbmajdistrelease}::packages"),
  }

  package { $packages:
    ensure => latest,
  }
}
