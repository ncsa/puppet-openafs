# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include openafs::client
class openafs::client {

  include epel
  include openafs::common
  include openafs::yumrepo
  include openafs::client::firewall
  include openafs::client::packages
  include openafs::client::rebuild
  include openafs::client::service

  Class['epel']
    -> Class['openafs::yumrepo']
      -> Class['openafs::client::packages']
        -> Class['openafs::common']
          -> Class['openafs::client::rebuild']
            -> Class['openafs::client::service']

}
