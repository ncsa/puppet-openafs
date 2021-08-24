# @summary Install and configure OpenAFS client
#
# @param profile_files
#   Hash of profile files related to OpenAFS client usage
#
# @example
#   include openafs::client
class openafs::client (
  Hash   $profile_files,
) {
  include epel
  include openafs::common
  include openafs::repos
  include openafs::client::firewall
  include openafs::client::packages
  include openafs::client::rebuild
  include openafs::client::service

  Class['epel']
  -> Class['openafs::repos']
  -> Class['openafs::client::packages']
  -> Class['openafs::common']
  -> Class['openafs::client::rebuild']
  -> Class['openafs::client::service']

  $profile_files.each | $filename, $content | {
    file { $filename:
      content => $content,
    }
  }
}
