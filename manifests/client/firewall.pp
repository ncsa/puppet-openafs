# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include openafs::client::firewall
class openafs::client::firewall (
  String $dport,
  String $proto,
  String $source,
) {

  firewall { "200 allow OpenAFS via ${proto} from ${source}":
    proto    => $proto,
    dport    => $dport,
    source   => $source,
    action   => 'accept',
    provider => 'iptables',
  }

}
