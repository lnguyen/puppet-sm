# == Class: sm
#
# This class is able to install or remove sm on a node.
#
# === Parameters
#
# [*ensure*]
#   String. Controls if the managed resources shall be <tt>present</tt> or
#   <tt>absent</tt>. If set to <tt>absent</tt>:
#   * The managed software packages are being uninstalled.
#   * Any traces of the packages will be purged as good as possible. This may
#     include existing configuration files. The exact behavior is provider
#     dependent. Q.v.:
#     * Puppet type reference: {package, "purgeable"}[http://j.mp/xbxmNP]
#     * {Puppet's package provider source code}[http://j.mp/wtVCaL]
#   * System modifications (if any) will be reverted as good as possible
#     (e.g. removal of created users, services, changed log settings, ...).
#   * This is thus destructive and should be used with care.
#   Defaults to <tt>present</tt>.
#
#
# The default values for the parameters are set in sm::params. Have
# a look at the corresponding <tt>params.pp</tt> manifest file if you need more
# technical information about them.
#
# === Examples
#
# * Installation, make sure service is running and will be started at boot time:
#     class { 'sm': }
#
# * Removal/decommissioning:
#     class { 'sm':
#       ensure => 'absent',
#     }
#
# === Authors
#
# * Long Nguyen<mailto:longnguyen11288@gmail.com>
#

class sm(
   $ensure              = $sm::params::ensure,
   $exts                = $sm::params::exts,
   $sets                = $sm::params::sets
  
) inherits sm::params {
  class { 'sm::install': 
  }

  class { 'sm::packages': 
    require => Class['sm::install']
  }
}

