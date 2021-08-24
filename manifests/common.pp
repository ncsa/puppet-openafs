# @summary Configure settings common to all OpenAFS services
#
# @example
#   include openafs::common
class openafs::common {

  $puppet_file_header = '# This file is managed by Puppet; changes may be overwritten'

  # SPECIFIC FILES FROM LOOKUP
  $configpath = lookup('openafs::configpath')
  $cellalias = lookup('openafs::cellalias')
  $thiscell = lookup('openafs::thiscell')

  File {
    owner  => root,
    group  => root,
    ensure => file,
    mode   => '0644',
    require => [
      Package['openafs'],
    ],
  }

  file { "${configpath}/CellAlias":
    content => $cellalias,
  }
  file { "${configpath}/ThisCell":
    content => "${thiscell}\n",
  }

}
