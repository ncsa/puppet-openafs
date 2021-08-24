# @summary Install packages for OpenAFS file server
#
# @param packages
#   Array of packages that need to be installed for the OpenAFS file server
#
# @param prereq_packages
#   Array of prerequisite packages that need to be installed for the OpenAFS file server
#
# @example
#   include openafs::file_server::packages
class openafs::file_server::packages (
  Array $packages,
  Array $prereq_packages,
) {
  ensure_packages( $prereq_packages )

  $packages_defaults = {
    require => [
      Package['dkms'],
      Class['openafs::repos'],
    ],
  }
  ensure_packages( $packages, $packages_defaults )
}
