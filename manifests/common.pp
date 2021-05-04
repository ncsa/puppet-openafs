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
  Hash   $yumrepo,
) {

  $yumrepo_defaults = {
    ensure  => present,
    enabled => true,
  }
  ensure_resources( 'yumrepo', $yumrepo, $yumrepo_defaults )

  # FOLLOWING WILL NEED TO CHANGE IF openafs REPO CHANGES ITS GPGKEY
  #$gpgpubkeyinstalled="rpm -q gpg-pubkey-`echo $(gpg --throw-keyids < /etc/pki/rpm-gpg/RPM-GPG-KEY-openafs) | cut --characters=11-18 | tr [A-Z] [a-z]`"
  $gpgpubkeyinstalled='rpm -q gpg-pubkey-5124ee19-54c66e4b'
  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-openafs':
    ensure => present,
#    source => 'https://copr-be.cloud.fedoraproject.org/results/jsbillings/openafs/pubkey.gpg',
    source => 'https://its-repo.ncsa.illinois.edu/openafs/jsbillings/centos-7-x86_64/pubkey.gpg',
  }
  exec { 'validate openafs gpg key':
    path      => '/bin:/usr/bin:/sbin:/usr/sbin',
    command   => 'gpg --keyid-format 0xLONG /etc/pki/rpm-gpg/RPM-GPG-KEY-openafs | grep -q 17FD55A45124EE19',
    unless    => $gpgpubkeyinstalled,
    require   => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-openafs'],
    logoutput => 'on_failure',
  }
  exec { 'import openafs gpg key':
    path      => '/bin:/usr/bin:/sbin:/usr/sbin',
    command   => 'rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-openafs',
    unless    => $gpgpubkeyinstalled,
    require   => [
      File['/etc/pki/rpm-gpg/RPM-GPG-KEY-openafs'],
      Exec['validate openafs gpg key']
    ],
    logoutput => 'on_failure',
  }


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
