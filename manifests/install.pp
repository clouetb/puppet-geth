# == Class: geth::install
class geth::install
(
  String  $identity       = 'Participant1',
  String  $networkid      = '1234321',
  Integer $unlock         = 0,
  Integer $port           = 30999,
  String  $rpcaddr        = 'localhost',
  Integer $rpcport        = 8545,
  String  $rpcapi         = 'admin,eth,net,web3',
  String  $rpccorsdomain  = '*',
  Integer $minerthreads   = 1,
  String  $nat            = 'any',
  Integer $maxpeers       = 0,
  Boolean $nodiscover     = true,
  Boolean $rpc            = true,
  Boolean $mine           = true,
  Boolean $autodag        = true,
) 
inherits geth {

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

  file { 'geth.service':
    path    => '/lib/systemd/system/geth.service',
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
  
  file { 'datadir':
    path    => '/home/geth/data',
    ensure  => 'directory',
    owner   => 'geth',
    mode    => '0744',
  }

  file { 'logdir':
    path     => '/var/log/geth',
    ensure   => 'directory',
    owner    => 'geth',
    mode     => '0755',
  }
}

