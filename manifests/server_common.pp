# @summary Configure common settings to all OpenAFS server types
#
# @param cellservdb
#   String of CellServDB config file contents for OpenAFS servers
#
# @param files
#   Hash of common server config files for OpenAFS servers
#
# @param keyfile_base64
#   String of base64 encoding of the KeyFile file contents for OpenAFS servers
#
# @param keyfileext_base64
#   String of base64 encoding of the KeyFileExt file contents for OpenAFS servers
#
# @param krb_conf
#   String of krb.conf config file contents for OpenAFS servers
#
# @param license
#   String of License file contents for OpenAFS servers
#
# @param rxkad_keytab_base64
#   String of base64 encoding of the rxkad.keytab file contents for OpenAFS servers
#
# @param userlist
#   String of UserList file contents for OpenAFS servers
#
# @example
#   include openafs::server_common
class openafs::server_common (
  String $cellservdb,
  Hash   $files,
  String $keyfile_base64,
  String $keyfileext_base64,
  String $krb_conf,
  String $license,
  String $rxkad_keytab_base64,
  String $userlist,
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
  # DECODE BASE64 PARAMETERS
  $keyfile = Sensitive( base64('decode', $keyfile_base64 ) )
  $keyfileext = Sensitive( base64('decode', $keyfileext_base64 ) )
  $rxkad_keytab = Sensitive( base64('decode', $rxkad_keytab_base64 ) )

  file { '/etc/openafs/server/CellServDB':
    content => $cellservdb,
    mode   => '0644',
  }
  file { '/etc/openafs/CellServDB':
    ensure => 'link',
    target => '/etc/openafs/server/CellServDB',
  }
  file { '/etc/openafs/server/krb.conf':
    content => "${krb_conf}\n",
  }
  file { '/etc/openafs/server/License':
    content => Sensitive($license),
  }
  file { '/etc/openafs/server/ThisCell':
    content => "${thiscell}\n",
  }
  file { '/etc/openafs/server/UserList':
    content => $userlist,
  }
  file { '/etc/openafs/server/KeyFile':
    content => $keyfile,
  }
  file { '/etc/openafs/server/KeyFileExt':
    content => $keyfileext,
  }
  file { '/etc/openafs/server/rxkad.keytab':
    content => $rxkad_keytab,
  }

}
