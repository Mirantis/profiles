# == Class: profiles::puppet::master
#
# Profile class for configuring the Puppetmaster
#
# === Parameters
#
# This is a profile class and is therefore parameter-less. Gets included.
#
# === Examples
#
#  class { 'profiles':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
# === Copyright
#
# Copyright 2015 Mirantis, Inc
#
class profiles::puppet::master {

  # Hiera lookups
  # Grab a hash of config to apply to the agent
  $config       = hiera(puppet::master::config)
  $puppetdb     = hiera(puppet::db::config)
  $autosign_oid = hiera(puppet::autosign::oid)
  $autosign_key = hiera(puppet::autosign::key)

  # Autosign binary

  file { 'autosign-policy':
    ensure  => 'file',
    path    => "/etc/puppet/${config['autosign_file']}",
    mode    => $config['autosign_mode'],
    owner   => 'puppet',
    group   => 'puppet',
    content => template('profiles/puppet/autosign-policy.rb.erb')
  }

  # Setup autosigning csr_attributes file
  file { 'csr_attributes':
    ensure  => 'file',
    path    => '/etc/puppet/csr_attributes.yaml',
    owner   => 'puppet',
    group   => 'puppet',
    mode    => '0640',
    content => template('profiles/puppet/csr_attributes.yaml.erb')
  }

  class { '::puppet':
    version                     => $config[version],
    server                      => $config[server],
    server_git_repo             => $config[server_git_repo],
    runmode                     => $config[runmode],
    pluginsync                  => $config[pluginsync],
    show_diff                   => $config[show_diff],
    server_reports              => $config[server_reports],
    server_storeconfigs_backend => $config[server_storeconfigs_backend],
    server_facts                => $config[server_facts],
    server_ca                   => false,
    ca_ttl                      => $config[ca_ttl],
    puppetmaster                => $config[puppetmaster],
    ca_server                   => $config[ca_server],
    server_foreman_url          => $config[server_foreman_url],
    server_parser               => $config[server_parser]
  }

  class { '::puppetdb::master::config':
    puppetdb_server => $puppetdb['puppetdb_server'],
  }

  # Install r10k
  class { '::r10k':
  version           => $config['r10k_version'],
  sources           => {
    'puppet' => {
      'remote'  => $config['r10k_remote_repo'],
      'basedir' => "${::settings::confdir}/environments",
      'prefix'  => false,
    }
  },
  manage_modulepath => false,
  }

  exec { 'r10k_deploy':
    command     => '/usr/local/bin/r10k deploy environment -pv',
    refreshonly => true,
  }

  Class['::r10k'] ~>
  Exec['r10k_deploy']

}
