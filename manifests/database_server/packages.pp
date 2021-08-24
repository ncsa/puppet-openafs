# @summary Install packages for OpenAFS database server
#
# @param packages
#   Array of packages that need to be installed for the OpenAFS database server
#
# @example
#   include openafs::database_server::packages
class openafs::database_server::packages (
  Array $packages,
) {
  $packages_defaults = {
    require => [
      Class['openafs::repos'],
    ],
  }
  ensure_packages( $packages, $packages_defaults )
}
