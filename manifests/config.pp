# == Class: geth::config
class geth::config (
  String  $datadir          = $geth::datadir,
  String  $account_password = $geth::account_password,
  String  $passfile         = $geth::passfile,
)
inherits geth {
  exec { 'geth-init-data':
    cwd     => '/home/geth',
    command => "geth data init --datadir ${datadir}",
    user    => 'geth',
    path    => [ '/usr/bin', '/bin', '/usr/sbin' ],
}
~> file { 'passfile':
    path    => "${passfile}",
    content => "${account_password}",
    owner   => 'geth',
    mode    => '0400',
}
~> exec { 'geth-create-account':
    cwd     => '/home/geth',
    command => "geth account new --password ${passfile}",
    user    => 'geth',
    path    => [ '/usr/bin', '/bin', '/usr/sbin' ],
  }
}

