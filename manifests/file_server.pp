# @summary Install and configure OpenAFS file server
#
# @example
#   include openafs::file_server
class openafs::file_server {

#  include epel
  include openafs::common
  include openafs::yumrepo
  include openafs::file_server::firewall
  include openafs::file_server::packages
  include openafs::file_server::rebuild
  include openafs::file_server::service
  include openafs::server_common

  Class['epel']
    -> Class['openafs::yumrepo']
      -> Class['openafs::file_server::packages']
        -> Class['openafs::common']
          -> Class['openafs::server_common']
            -> Class['openafs::file_server::rebuild']
              -> Class['openafs::file_server::service']

}
