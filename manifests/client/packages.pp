# @summary Install packages for OpenAFS client
#
# @param packages
#   Array of packages that need to be installed for the OpenAFS client
#
# @param prereq_packages
#   Array of prerequisite packages that need to be installed for the OpenAFS client
#
# @example
#   include openafs::client::packages
class openafs::client::packages (
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
