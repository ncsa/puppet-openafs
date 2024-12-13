#!/usr/bin/bash


# Update as needed
URL='https://download.sinenomine.net/openafs/rpms/rhel8/Source/SPackages/openafs-1.8.13-1.src.rpm'

# No more updates below here
builddir=$HOME/rpmbuild
required_pkgs=(
  createrepo
  rpm-build
  ncurses-devel
  pam-devel
  swig
  @Development\ Tools
)


install_dependencies() {
  yum install -y "${required_pkgs[@]}"
}


get_source() {
  tmpdir=$(mktemp -d)
  pushd "${tmpdir}"
  curl -O "$URL"
  srpm="$(ls)"
  rpm -ivh "${srpm}" #installs into $HOME/rpmbuild
  popd
  rm -rf "${tmpdir}"
}


build_rpms() {
  # builds RPMS into $HOME/rpmbuild/RPMS/x86_64
  rpmbuild -bb $builddir/SPECS/openafs.spec --with supergroups --with transarc-paths
}


validate_rpms() {
  local _testdir="${builddir}"/test
  mkdir "${_testdir}"
  rpm2cpio "${builddir}"/RPMS/x86_64/openafs-server-*.rpm \
  | cpio -idmv -D "${_testdir}"
  strings "${_testdir}"/usr/afs/bin/ptserver | grep -i -- ^-
}


mk_repo() {
  createrepo $builddir/RPMS/x86_64
}


clean() {
  [[ -d "${builddir}" ]] && rm -rf "${builddir}"
}


###
# MAIN
###

install_dependencies

clean

get_source

build_rpms

validate_rpms

mk_repo
