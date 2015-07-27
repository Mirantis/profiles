# == Class: profiles::ssh::server
#
# Profile class for configuring sshd
#
# === Parameters
#
# This is a profile class and is therefore parameter-less. Gets included.
# This profile class sets up sshd
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
class profiles::ssh::server {

  # Hiera lookups for ssh config
  $config = hiera('ssh::config')

  # Load up ssh::server class from ssh module
  # Pass in hiera config as parameters
  class { '::ssh::server':
    permit_root_login => $config['permit_root_login'],
    options           => {
        'PasswordAuthentication' => $config['permit_passwd_auth'],
    }
  }

}
