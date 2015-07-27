# == Class: profiles::firewall::purge
#
# Profile class for clearing any existing firewall rules
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
# === Copyright
#
# Copyright 2015 Mirantis, Inc
#
class profiles::firewall::purge {

  resources { 'firewall':
    purge => true
  }

}
