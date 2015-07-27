# == Class: profiles::common::sudo
#
# Profile class to configure sudo and sudoers.
# This class uses hiera to drive the sudoers.
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#

class profiles::common::sudo {

  contain ::sudo
  contain ::sudo::configs

}
