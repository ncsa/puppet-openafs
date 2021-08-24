# @summary Rebuild the kernel module for OpenAFS when needed
#
# @param testfile
#   String of file/path to test for at top level under /afs/thiscell/ to check to
#   see if AFS mounted as expected.
#
# @example
#   include openafs::client::rebuild
class openafs::client::rebuild (
  String $testfile,
) {
  # IF AFS FILESYSTEM IS UNAVAILABLE 
  # INDICATES OpenAFS OR kernel HAVE BEEN UPDATED
  # CAN BE RESOLVED BY REBUILDING VIA REINSTALLING THE dkms-openafs PACKAGE

  $thiscell = lookup('openafs::thiscell')

  case $facts['os']['family'] {
    'RedHat': {
      $rebuild_command = 'yum -y reinstall dkms-openafs'
      $rebuild_onlyif = 'yum list installed dkms-openafs'
    }
    'Suse': {
      $rebuild_command = 'zypper install --force --no-confirm dkms-openafs'
      $rebuild_onlyif = 'zypper search -i dkms-openafs'
    }
    default: {
      fail('Only RedHat and Suse OS families are supported at this time')
    }
  }

  exec { 'rebuild_afs':
    path    => ['/usr/bin', '/usr/sbin'],
    command => $rebuild_command,
    creates => "/afs/${thiscell}/${testfile}",
    onlyif  => $rebuild_onlyif,
    timeout => '1200',
    notify  => Service['openafs-client'],
    require => [
      Package['openafs-client'],
    ],
  }
}
