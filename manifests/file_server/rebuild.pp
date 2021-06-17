# @summary Rebuild the kernel module for OpenAFS when needed
#
# @example
#   include openafs::file_server::rebuild
class openafs::file_server::rebuild {

  # IF AFS FILESYSTEM IS UNAVAILABLE
  # INDICATES OpenAFS OR kernel HAVE BEEN UPDATED
  # CAN BE RESOLVED BY REBUILDING VIA REINSTALLING THE dkms-openafs PACKAGE

  exec { 'rebuild_afs':
    path    => ['/usr/bin', '/usr/sbin'],
    command => 'yum -y reinstall dkms-openafs',
## THIS PROBABLY NEED TO CHANGE TO ??
    creates => '/afs/ncsa.uiuc.edu/README',
    onlyif  => 'yum list installed dkms-openafs',
    timeout => '1200',
#    notify  => Service['openafs-client'],
    require => [
      Package['openafs-client'],
    ],
  }

}
