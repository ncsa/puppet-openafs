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
  $configpath = lookup('openafs::configpath')
  $thiscell = lookup('openafs::thiscell')
  # DECODE BASE64 PARAMETERS
  $keyfile = Sensitive( base64('decode', $keyfile_base64 ) )
  $keyfileext = Sensitive( base64('decode', $keyfileext_base64 ) )
  $rxkad_keytab = Sensitive( base64('decode', $rxkad_keytab_base64 ) )

  file { "${configpath}/server/CellServDB":
    content => $cellservdb,
    mode    => '0644',
  }
  file { "${configpath}/CellServDB":
    ensure => 'link',
    target => "${configpath}/server/CellServDB",
  }
  file { "${configpath}/server/krb.conf":
    content => "${krb_conf}\n",
  }
  file { "${configpath}/server/License":
    content => Sensitive($license),
  }
  file { "${configpath}/server/ThisCell":
    content => "${thiscell}\n",
  }
  file { "${configpath}/server/UserList":
    content => $userlist,
  }
  file { "${configpath}/server/KeyFile":
    content => $keyfile,
  }
  file { "${configpath}/server/KeyFileExt":
    content => $keyfileext,
  }
  file { "${configpath}/server/rxkad.keytab":
    content => $rxkad_keytab,
  }

}
