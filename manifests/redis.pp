# == Class: profiles::redis
#
# Profile class for configuring Redis
#
# === Parameters
#
# This is a profile class and is therefore parameter-less. Gets included.
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
class profiles::redis {
  
  # Include Redis module
  # Defaults are fine for now
  include ::redis
}
