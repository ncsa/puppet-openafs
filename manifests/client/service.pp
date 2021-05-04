# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include openafs::client::service
class openafs::client::service (
  Boolean $enable,
  String  $ensure,
  String  $service_name,
) {

  service { $service_name:
    ensure => $ensure,
    enable => $enable
  }

}
