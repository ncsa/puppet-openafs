# @summary Configure settings common to all OpenAFS services
#
# @param viceetcdir
#   String of dirctory to AFS common configuration directory (viceetcdir)
#
# @example
#   include openafs::common
class openafs::common (
  String $viceetcdir,
) {
  $puppet_file_header = '# This file is managed by Puppet; changes may be overwritten'

# WERE TESTING FORCING UPDATES TO /etc/hosts - DO NOT THINK NEEDED
#  file_line { 'hosts_localhost_ipv6':
#    ensure            => absent,
#    path              => '/etc/hosts',
#    #line              => '::1 localhost',
#    match             => '::1.*localhost',
#    match_for_absence => true,
#  }
#  host { $facts['fqdn']:
#    ensure       => 'present',
#    host_aliases => [
#      $facts['hostname'],
#    ],
#    ip           => $facts['ipaddress'],
#  }
#  host { 'localhost':
#    ensure       => 'present',
#    host_aliases => [
#      'localhost.localdomain',
#      'localhost4',
#      'localhost4.localdomain4',
#    ],
#    ip           => '127.0.0.1',
#  }

  # SPECIFIC FILES FROM LOOKUP
  $cellalias = lookup('openafs::cellalias')
  $thiscell = lookup('openafs::thiscell')

  File {
    owner  => root,
    group  => root,
    ensure => file,
    mode   => '0644',
    require => [
      Package['openafs'],
    ],
  }

  file { "${viceetcdir}/CellAlias":
    content => $cellalias,
  }
  file { "${viceetcdir}/ThisCell":
    content => "${thiscell}\n",
  }
}
