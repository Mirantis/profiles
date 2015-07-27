# == Class: profiles::foreman::proxy
#
# Profile class to configure Foreman proxy server
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
class profiles::foreman::proxy {

  # Hiera lookup. Configuration hash
  $config = hiera_hash(foreman::proxy::config)

  file { '/usr/share/foreman-proxy/.ssh':
    ensure  => 'directory',
    owner   => 'foreman-proxy',
    group   => 'foreman-proxy',
    mode    => '0700',
    require => Class['foreman_proxy']
  }

  # SSH Key for foreman-proxy for remote puppet events
  file { '/etc/foreman-proxy/keys':
    ensure => 'directory',
    path   => '/etc/foreman-proxy/keys',
    owner  => 'foreman-proxy',
    group  => 'foreman-proxy',
    mode   => '0700'
  }

  file { 'puppetssh_key':
    ensure  => 'file',
    path    => '/etc/foreman-proxy/keys/foreman-proxy_rsa',
    content => $config['ssh_private_key'],
    require => File['/etc/foreman-proxy/keys'],
    owner   => 'foreman-proxy',
    group   => 'foreman-proxy',
    mode    => '0600',
  }

  # Configure foreman-proxy
  class { 'foreman_proxy':
    repo                  => $config['repo'],
    gpgcheck              => $config['gpgcheck'],
    version               => $config['version'],
    ssl                   => $config['ssl'],
    user                  => $config['user'],
    log_level             => $config['log_level'],
    ssl_ca                => $config['ssl_ca'],
    ssl_cert              => $config['ssl_cert'],
    ssl_key               => $config['ssl_key'],
    trusted_hosts         => $config['trusted_hosts'],
    manage_sudoersd       => $config['manage_sudoers'],
    use_sudoersd          => $config['use_sudoersd'],
    puppetca              => $config['puppetca'],
    puppetca_listen_on    => $config['puppetca_listen_on'],
    ssldir                => $config['ssldir'],
    puppetdir             => $config['puppetdir'],
    autosign_location     => $config['autosign_location'],
    puppet_group          => $config['puppet_group'],
    puppetrun             => $config['puppetrun'],
    puppetrun_listen_on   => $config['puppetrun_listen_on'],
    puppetrun_provider    => $config['puppetrun_provider'],
    puppet_user           => $config['puppet_user'],
    puppet_url            => $config['puppet_url'],
    puppet_ssl_ca         => $config['puppet_ssl_ca'],
    puppet_ssl_cert       => $config['puppet_ssl_cert'],
    puppet_ssl_key        => $config['puppet_ssl_key'],
    puppetssh_user        => $config['puppetssh_user'],
    puppetssh_keyfile     => $config['puppetssh_keyfile'],
    puppetssh_sudo        => $config['puppetssh_sudo'],
    templates             => $config['templates'],
    tftp                  => $config['tftp'],
    dhcp                  => $config['dhcp'],
    dns                   => $config['dns'],
    dns_zone              => $config['dns_zone'],
    dns_reverse           => $config['dns_reverse'],
    dns_forwarders        => [$config[dns_forwarders]],
    bmc                   => $config['bmc'],
    foreman_base_url      => $config['foreman_base_url'],
    oauth_effective_user  => $config['oauth_effective_user'],
    oauth_consumer_key    => $config['oauth_consumer_key'],
    oauth_consumer_secret => $config['oauth_consumer_secret']
  }

}
