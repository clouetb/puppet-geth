# == Class: geth::install
class geth::install
(
  String  $identity         = $geth::identity,
  String  $networkid        = $geth::networkid,
  Integer $unlock           = $geth::unlock,
  Integer $port             = $geth::port,
  String  $rpcaddr          = $geth::rpcaddr,
  Integer $rpcport          = $geth::rpcport,
  String  $rpcapi           = $geth::rpcapi,
  String  $rpccorsdomain    = $geth::rpccorsdomain,
  Integer $minerthreads     = $geth::minerthreads,
  String  $nat              = $geth::nat,
  Integer $maxpeers         = $geth::maxpeers,
  Boolean $nodiscover       = $geth::nodiscover,
  Boolean $rpc              = $geth::rpc,
  Boolean $mine             = $geth::mine,
  Boolean $autodag          = $geth::autodag,
  String  $init_data        = $geth::init_data, 
  String  $account_password = $geth::account_password,
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
    content => epp('geth/geth.service.erb'),
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

