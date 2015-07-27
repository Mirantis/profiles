# == Class: profiles::common::users::install
#
# Class to create user accounts on systems
#
# === Parameters
#
# This is a profile class and has no parameters
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#

class profiles::common::users::install {
  # Hiera lookups to grab users and groups to apply to boxes by default
  $users     = hiera_hash('users')
  $groups    = hiera_hash('groups')
  $keys      = hiera_hash('ssh_keys')
  $root_user = hiera_hash('users::root')

  # Create resources for users, groups, and ssh keys
  create_resources(user, $users)
  create_resources(user, $root_user)
  create_resources(group, $groups)
  create_resources(ssh_authorized_key, $keys)
}
