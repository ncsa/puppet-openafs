# @summary Configure service for OpenAFS file server
#
# @param enable
#   Boolean of whether the default service should be enabled
#
# @param ensure
#   String of how the default service should be ensured
#
# @param service_name
#   String of the name of the default service
#
# @example
#   include openafs::file_server::service
class openafs::file_server::service (
  Boolean $enable,
  String  $ensure,
  String  $service_name,
) {

  service { $service_name:
    ensure => $ensure,
    enable => $enable
  }

}
