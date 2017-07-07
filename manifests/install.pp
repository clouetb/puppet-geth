# == Class: geth::install
class geth::install inherits geth {

  yumrepo { 'okay-repo':
    baseurl => 'http://repo.okay.com.mx/centos/$releasever/$basearch/release',
    descr => 'OKAY RPM repository',
    enabled => 1,
    gpgcheck => 1,
    gpgkey => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-OKAY',
  }

  package { 'go-ethereum':
    ensure => installed,
    require => Yumrepo["okay-repo"],
  }

  group { 'geth':
    ensure => 'present',
  }

  user { 'geth':
    ensure => 'present',
    groups => 'geth',
  }

}

