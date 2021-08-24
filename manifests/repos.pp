# @summary Install and configure OpenAFS package repository
#
# @param repos
#   Hash of yumrepo or zypprepo resources for OpenAFS yum/zypper repositories
#
# @example
#   include openafs::repos
class openafs::repos (
  Hash   $repos,
) {
  if (! empty( $repos ) ) {
    $repo_defaults = {
      ensure  => present,
      enabled => true,
    }
    case $facts['os']['family'] {
      'RedHat': {
        ensure_resources( 'yumrepo', $repos, $repo_defaults )
      }
      'Suse': {
        ensure_resources( 'zypprepo', $repos, $repo_defaults )
        # IMPORTING ANY NEW gpgkeys
        $repos.each |$repo, $elements| {
          if $elements['gpgkey'].stdlib::start_with('http') {
            exec { "import gpgkey for repo ${repo}":
              command     => "rpm --import ${elements['gpgkey']}",
              path        => ['/usr/bin', '/usr/sbin', '/sbin'],
              refreshonly => true,
              subscribe   => Zypprepo[$repo],
            }
          }
        }
      }
      default: {
        fail('Only RedHat and Suse OS families are supported at this time')
      }
    }
  }
}
