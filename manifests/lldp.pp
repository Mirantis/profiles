# == Class: profiles::lldp
#
# Class for setting up lldp
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
# === Copyright
#
# Copyright 2015 Mirantis Inc, unless otherwise noted.
#
class profiles::lldp {

  # Install lldpd
  package { 'lldpd':
    ensure => 'present',
  }

}
