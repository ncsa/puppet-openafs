# @summary Install and configure OpenAFS database server
#
# @example
#   include openafs::database_server
class openafs::database_server {

  include openafs::client
  include openafs::common
  include openafs::yumrepo
  include openafs::database_server::firewall
  include openafs::database_server::packages
  include openafs::database_server::service
  include openafs::server_common

  Class['openafs::yumrepo']
    -> Class['openafs::client']
      -> Class['openafs::database_server::packages']
        -> Class['openafs::common']
          -> Class['openafs::server_common']
            -> Class['openafs::database_server::service']

}
