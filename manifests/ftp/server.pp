# == Class: profiles::ftp::server
#
# Profile class for configuring an ftp server
#
# === Parameters
#
# This is a profile class and is therefore parameter-less. Gets included.
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
class profiles::ftp::server {

  # Hiera lookups
  $config = hiera(ftp::config)

  # Load pureftpd module and pass in parameters from hiera
  class { '::pureftpd':
    use_selinux => $config['use_selinux'],
    config      => {
      chrooteveryone   => $config['chrooteveryone'],
      daemonize        => $config['daemonize'],
      noanonymous      => $config['noanonymous'],
      displaydotfiles  => $config['displaydotfiles'],
      syslogfacility   => $config['syslogfacility'],
      bind             => $config['bind'],
      maxclientsperip  => $config['maxclientsperip'],
      maxclientsnumber => $config['maxclientsnumber'],
      tlsciphersuite   => $config['tlsciphersuite']
    }
  }

}
