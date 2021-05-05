# @summary Install packages for OpenAFS database server
#
# @param packages
#   Array of packages that need to be installed for the OpenAFS database server
#
# @example
#   include openafs::database_server::packages
class openafs::database_server::packages (
  Array $packages,
){

#  ensure_packages( $prereq_packages )

  $packages_defaults = {
    require => [
      Yumrepo['openafs'],
    ]
  }
  ensure_packages( $packages, $packages_defaults )

}
