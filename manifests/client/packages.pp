# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include openafs::client::packages
class openafs::client::packages (
  Array $prereq_packages,
  Array $packages,
){

  ensure_packages( $prereq_packages )

  $packages_defaults = {
    require => [
#      Exec['import openafs gpg key'],
      Package['dkms'],
      Yumrepo['openafs'],
    ]
  }
  ensure_packages( $packages, $packages_defaults )

}
