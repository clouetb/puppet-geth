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
  String  $account_password = $geth::account_password,
  String  $datadir          = $geth::datadir,
  String  $passfile         = $geth::passfile,
  String  $logdir           = $geth::logdir,
)
inherits geth {

  yumrepo { 'okay-repo':
    baseurl  => 'http://repo.okay.com.mx/centos/$releasever/$basearch/release',
    descr    => 'OKAY RPM repository',
    enabled  => 1,
    gpgcheck => 0,
  }

  package { 'go-ethereum':
    ensure  => installed,
    require => Yumrepo['okay-repo'],
  }

  group { 'geth':
    ensure => 'present',
  }

  user { 'geth':
    ensure     => 'present',
    groups     => 'geth',
    managehome => true,
  }

  file { 'geth.service':
    path    => '/lib/systemd/system/geth.service',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => epp('geth/geth.service.epp'),
  }
  ~> exec { 'geth-systemd-reload':
    command     => 'systemctl daemon-reload',
    path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
    refreshonly => true,
  }

  file { 'datadir':
    ensure => 'directory',
    path   => "${datadir}",
    owner  => 'geth',
    mode   => '0744',
  }

  file { 'logdir':
    ensure => 'directory',
    path   => "${logdir}",
    owner  => 'geth',
    mode   => '0755',
  }
}

