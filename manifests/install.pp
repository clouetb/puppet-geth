# == Class: geth::install
class geth::install
(
  String  $user             = $geth::user,
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
{

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

  # Proper time synchronization is needed for connecting to the blockchain
  package { 'ntp':
    ensure => installed,
  }
  ~> service { 'ntpd':
    ensure => running,
    enable => true,
  }

  group { $user:
    ensure => present,
  }

  user { $user:
    ensure     => present,
    groups     => $user,
    managehome => true,
  }

  file { '/lib/systemd/system/geth.service':
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

  file { $datadir:
    ensure => directory,
    owner  => $user,
    mode   => '0744',
  }

  file { $logdir:
    ensure => directory,
    owner  => $user,
    mode   => '0755',
  }
}

