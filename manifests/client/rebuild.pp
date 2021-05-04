# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include openafs::client::rebuild
class openafs::client::rebuild {

  # IF AFS FILESYSTEM IS UNAVAILABLE 
  # INDICATES OpenAFS OR kernel HAVE BEEN UPDATED
  # CAN BE RESOLVED BY REBUILDING VIA REINSTALLING THE dkms-openafs PACKAGE

  exec { 'rebuild_afs':
    path    => ['/usr/bin', '/usr/sbin'],
    command => 'yum -y reinstall dkms-openafs',
    creates => '/afs/ncsa.uiuc.edu/README',
    onlyif  => 'yum list installed dkms-openafs',
    timeout => '1200',
    notify  => Service['openafs-client'],
    require => [
      Package['openafs-client'],
    ],
  }

}
