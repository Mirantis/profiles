# == Class: profiles::common::users::shells
#
# Class for ensuring user shells are installed prior to
# adding the user with their preferred shell
#
# === Parameters
#
# This is a profile class and has no parameters
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#

class profiles::common::users::shells {
  # Hiera lookups to grab users and groups to apply to boxes by default
  $shells = hiera('shells')

  package { $shells:
    ensure => latest,
  }
}
