# == Class: profiles::firewall::post
#
# Default last firewall rules
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
# === Copyright
#
# Copyright 2015 Mirantis, Inc
#
class profiles::firewall::post {

  # Default firewall rules to be applied last
  firewall { '999 drop all input':
    proto  => 'all',
    chain  => 'INPUT',
    action => 'drop',
  }
}
