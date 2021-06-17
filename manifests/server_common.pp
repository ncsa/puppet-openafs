# @summary Configure common settings to all OpenAFS server types
#
# @param files
#   Hash of common server config files for OpenAFS servers
#
# @example
#   include openafs::server_common
class openafs::server_common (
  Hash   $files,
) {

  File {
    owner  => root,
    group  => root,
    ensure => file,
    mode   => '0640',
  }

  ensure_resources('file', $files )

  $puppet_file_header = '# This file is managed by Puppet; changes may be overwritten'

  # SPECIFIC FILES FROM LOOKUP
  $thiscell = lookup('openafs::thiscell')
  $cellservdb = lookup('openafs::server::cellservdb')
  $keyfile_base64 = lookup('openafs::server::keyfile_base64')
  $keyfileext_base64 = lookup('openafs::server::keyfileext_base64')
  $krb_conf = lookup('openafs::server::krb_conf')
  $license = lookup('openafs::server::license')
  $rxkad_keytab_base64 = lookup('openafs::server::rxkad_keytab_base64')
  $userlist = lookup('openafs::server::userlist')

  file { '/etc/openafs/server/CellServDB':
    content => $cellservdb,
  }
  file { '/etc/openafs/CellServDB':
    ensure => 'link',
    target => '/etc/openafs/server/CellServDB',
  }
  file { '/etc/openafs/server/krb.conf':
    content => "${krb_conf}\n",
  }
  file { '/etc/openafs/server/License':
    content => "${license}\n",
  }
  file { '/etc/openafs/server/ThisCell':
    content => "${thiscell}\n",
  }
  file { '/etc/openafs/server/UserList':
    content => $userlist,
  }
  file { '/etc/openafs/server/KeyFile':
    content => base64('decode', $keyfile_base64),
  }
  file { '/etc/openafs/server/KeyFileExt':
    content => base64('decode', $keyfileext_base64),
  }
  file { '/etc/openafs/server/rxkad.keytab':
    content => base64('decode', rxkad_keytab_base64),
  }

}
