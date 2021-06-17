# @summary Configure the firewall settings for OpenAFS client
#
# @param dports
#   Array of destination ports that need to be open for the OpenAFS client
#
# @param proto
#   String of protocol that needs to be open for the OpenAFS client
#
# @param sources
#   Array CIDR sources that need to be open for the OpenAFS client
#
# @example
#   include openafs::client::firewall
class openafs::client::firewall (
  Array[String]  $dports,
  String         $proto,
  Array[String]  $sources,
) {

  $sources.each | $location, $source |
  {
    firewall { "200 allow OpenAFS via ${proto} from ${source}":
      proto    => $proto,
      dport    => $dports,
      source   => $source,
      action   => 'accept',
    }
  }

}
