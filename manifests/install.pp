# == Class: geth::install
class geth::install inherits geth {

  yumrepo { 'okay-repo':
    baseurl => 'http://repo.okay.com.mx/centos/$releasever/$basearch/release',
    descr => 'OKAY RPM repository',
    enabled => 1,
    gpgcheck => 0,
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
    managehome => true,
  }

  file { 'datadir':
    path    => '/home/geth/data',
    ensure  => 'directory',
    owner   => 'geth',
  }

  file { '/lib/systemd/system/geth.service':
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('geth/geth.service.erb'),
  }~>
  exec { 'geth-systemd-reload':
    command     => 'systemctl daemon-reload',
    path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
    refreshonly => true,
  }

}

