# == Class: sm::install
#
# This class exists to coordinate all software package management related
# actions, functionality and logical units in a central place.
#
#
# === Parameters
#
# This class does not provide any parameters.
#
#
# === Examples
#
# This class may be imported by other classes to use its functionality:
#   class { 'sm::install': }
#
# It is not intended to be used directly by external resources like node
# definitions or other modules.
#
#
# === Authors
#
# * Long Nguyen <mailto:long.nguyen11288@gmail.com>
#
class sm::install {
  if $sm::ensure == 'present' {
    exec { 'install-sm':
      path    => '/usr/bin:/usr/sbin:/bin',
      command => "bash -c '/usr/bin/curl -L https://get.smf.sh | sh'",
      unless => 'ls /opt/sm'
    }

  } else {
    exec { 'remove-sm': 
      path    => '/usr/bin:/usr/sbin:/bin',
      command => "rm -rf /opt/sm/"
    }
  }
}
