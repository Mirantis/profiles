# == Class: profiles::common::users
#
# Profile class to include user management
#
# === Parameters
#
# This is a profile class and has no parameters
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#

class profiles::common::users {

  include ::profiles::common::users::shells
  include ::profiles::common::users::install

  Class['::profiles::common::users::shells'] -> Class['::profiles::common::users::install']
}
