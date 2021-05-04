# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include openafs::client
class openafs::client {

  include openafs::common
  include openafs::client::firewall
  include openafs::client::packages
  include openafs::client::rebuild
  include openafs::client::service

}
