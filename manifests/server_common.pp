# @summary Configure common settings to all OpenAFS server types
#
# @param afsbackupdir
#   String of path to AFS server backup directory
#
# @param afsconfdir
#   String of path to AFS server configuration directory
#
# @param afslocaldir
#   String of path to AFS server local directory
#
# @param afslogsdir
#   String of path to AFS server logs directory
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
  String $afsbackupdir,
  String $afsconfdir,
  String $afslocaldir,
  String $afslogsdir,
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

  $afslocaldir_parent_path = dirname( $afslocaldir )

  file { $afslocaldir_parent_path :
    ensure => 'directory',
    mode   => '0700',
  }
  file { $afslocaldir :
    ensure => 'directory',
    mode   => '0700',
  }
  file { "${afslocaldir}/local" :
    ensure => 'directory',
    mode   => '0750',
  }

  file { $afsbackupdir :
    ensure => 'directory',
    mode   => '0700',
  }
  file { $afslogsdir :
    ensure => 'directory',
    mode   => '0755',
  }
  file { "${afsbackupdir}/logs" :
    ensure => 'directory',
    mode   => '0755',
  }

  file { $afsconfdir :
    ensure => 'directory',
    mode   => '0700',
  }

  ensure_resources('file', $files )

  $puppet_file_header = '# This file is managed by Puppet; changes may be overwritten'

  # SPECIFIC FILES FROM LOOKUP
  $thiscell = lookup('openafs::thiscell')
  $viceetcdir = lookup('openafs::common::viceetcdir')
  # DECODE BASE64 PARAMETERS
  $keyfile = Sensitive( base64('decode', $keyfile_base64 ) )
  $keyfileext = Sensitive( base64('decode', $keyfileext_base64 ) )
  $rxkad_keytab = Sensitive( base64('decode', $rxkad_keytab_base64 ) )

  file { "${afsconfdir}/CellServDB":
    content => $cellservdb,
    mode    => '0644',
  }
  file { "${viceetcdir}/CellServDB":
    ensure  => 'link',
    target  => "${afsconfdir}/CellServDB",
    require => [
      Class[openafs::client],
    ],
  }
  file { "${afsconfdir}/krb.conf":
    content => "${krb_conf}\n",
  }
  file { "${afsconfdir}/License":
    content => Sensitive($license),
  }
  file { "${afsconfdir}/ThisCell":
    content => "${thiscell}\n",
  }
  file { "${afsconfdir}/UserList":
    content => $userlist,
  }
  file { "${afsconfdir}/KeyFile":
    content => $keyfile,
  }
  file { "${afsconfdir}/KeyFileExt":
    content => $keyfileext,
  }
  file { "${afsconfdir}/rxkad.keytab":
    content => $rxkad_keytab,
  }
  file { "${afslocaldir}/NetInfo":
    content => $facts['networking']['ip'],
    mode    => '0644',
  }
}
