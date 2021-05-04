# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include openafs::common
class openafs::common (
  String $cellalias,
  Hash   $profile_files,
  String $thiscell,
) {

  file { '/etc/openafs/ThisCell':
    ensure  => 'file',
    content => $thiscell,
    notify  => Service['openafs-client'],
    require => [
      Package['openafs-client'],
    ],
  }

  file { '/etc/openafs/CellAlias':
    ensure  => 'file',
    content => $cellalias,
    notify  => Service['openafs-client'],
    require => [
      Package['openafs-client'],
    ],
  }

  $profile_files.each | $filename, $content | {
    file { $filename:
      content => $content,
    }
  }

}
