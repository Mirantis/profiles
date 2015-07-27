# == Class: profiles::puppet::agent
#
# Profile class for configuring the Puppet agent
#
# === Parameters
#
# This is a profile class and is therefore parameter-less. Gets included.
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
class profiles::puppet::agent {

  # Hiera lookups
  # Grab a hash of config to apply to the agent
  $config = hiera(puppet::agent::config)
  $autosign_oid = hiera(puppet::autosign::oid)
  $autosign_key = hiera(puppet::autosign::key)

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
    server                      => false,
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
    server_parser               => $config[server_parser],
  }

}
