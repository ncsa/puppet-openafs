# openafs

[![pdk-validate](https://github.com/ncsa/puppet-openafs/actions/workflows/pdk-validate.yml/badge.svg)](https://github.com/ncsa/puppet-openafs/actions/workflows/pdk-validate.yml)
[![yamllint](https://github.com/ncsa/puppet-openafs/actions/workflows/yamllint.yml/badge.svg)](https://github.com/ncsa/puppet-openafs/actions/workflows/yamllint.yml)

Puppet module to install and configure OpenAFS

OpenAFS is a distributed filesystem: https://www.openafs.org/

## Usage

To install and configure the **OpenAFS client**:

```
  include openafs::client
```

To install and configure the **OpenAFS database server**:

```
  include openafs::database_server
```

To install and configure the **OpenAFS file server**:

```
  include openafs::file_server
```

## Configuration

The following parameters need to be set:
- `openafs::cellalias`: String of your OpenAFS CellAlias content
- `openafs::thiscell`: String of your OpenAFS ThisCell content
- `openafs::server_common::cellservdb`: String of your OpenAFS CellServDB content
- `openafs::server_common::keyfile_base64`: String of your base64 encoded KeyFile content
- `openafs::server_common::keyfileext_base64`: String of your base64 encoded KeyFileExt content
- `openafs::server_common::krb_conf`: String of your OpenAFS krb.conf content (Kerberos realm name)
- `openafs::server_common::license`: String of your OpenAFS License content
- `openafs::server_common::rxkad_keytab_base64`: String of your base64 encoded rxkad.keytab content

## Dependencies
- [puppet/epel](https://forge.puppet.com/puppet/epel)
- [puppetlabs/firewall](https://forge.puppet.com/puppetlabs/firewall)
- [puppetlabs/stdlib](https://forge.puppet.com/modules/puppetlabs/stdlib)

## Reference

[REFERENCE.md](REFERENCE.md)

