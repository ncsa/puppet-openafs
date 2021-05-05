# @summary Configure the firewall settings for OpenAFS file server
#
# @param dports
#   Array of destination ports that need to be open for the OpenAFS file server
#
# @param proto
#   String of protocol that needs to be open for the OpenAFS file server
#
# @param sources
#   Array CIDR sources that need to be open for the OpenAFS file server
#
# @example
#   include openafs::file_server::firewall
class openafs::file_server::firewall (
  Array[String] $dports,
  String        $proto,
  Array[String] $sources,
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
