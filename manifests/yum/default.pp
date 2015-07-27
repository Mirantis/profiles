# == Class: profiles::yum::default
#
# Profile class for configuring yum repos
#
# === Parameters
#
# This is a profile class and is therefore parameter-less. Gets included.
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
class profiles::yum::default {

  # Hiera lookups
  $repos  = hiera_hash(yum::repos)

  include ::yum

  yum::repo { 'base':
    description => $repos[base][description],
    mirrorlist  => $repos[base][mirrorlist],
    gpgcheck    => $repos[base][gpgcheck],
    gpgkey      => $repos[base][gpgkey],
    notify      => Exec['yum_clean'],
  }

  yum::repo { 'updates':
    description => $repos[updates][description],
    mirrorlist  => $repos[updates][mirrorlist],
    gpgcheck    => $repos[updates][gpgcheck],
    gpgkey      => $repos[updates][gpgkey],
    notify      => Exec['yum_clean'],
  }

  yum::repo { 'extras':
    description => $repos[extras][description],
    mirrorlist  => $repos[extras][mirrorlist],
    gpgcheck    => $repos[extras][gpgcheck],
    gpgkey      => $repos[extras][gpgkey],
    notify      => Exec['yum_clean'],
  }

  yum::repo { 'EPEL':
    description => $repos[epel][description],
    mirrorlist  => $repos[epel][mirrorlist],
    gpgcheck    => $repos[epel][gpgcheck],
    gpgkey      => $repos[epel][gpgkey],
    notify      => Exec['yum_clean'],
  }

  yum::repo { 'puppetlabs-products':
    description => $repos[puppetlabs-products][description],
    baseurl     => $repos[puppetlabs-products][baseurl],
    gpgcheck    => $repos[puppetlabs-products][gpgcheck],
    gpgkey      => $repos[puppetlabs-products][gpgkey],
    notify      => Exec['yum_clean'],
  }

  yum::repo { 'puppetlabs-deps':
    description => $repos[puppetlabs-deps][description],
    baseurl     => $repos[puppetlabs-deps][baseurl],
    gpgcheck    => $repos[puppetlabs-deps][gpgcheck],
    gpgkey      => $repos[puppetlabs-deps][gpgkey],
    notify      => Exec['yum_clean'],
  }

  exec { 'yum_clean':
    command     => '/bin/yum clean all',
    refreshonly => true,
  }

}
