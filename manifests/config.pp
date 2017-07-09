# == Class: geth::config
class geth::config (
  String  $datadir          = $geth::datadir,
  String  $init_data        = $geth::init_data,
  String  $account_password = $geth::account_password,
  String  $passfile         = $geth::passfile,
  String  $logdir           = $geth::logdir,
)
inherits geth {
  exec { 'geth-init-data':
    cwd     => '/home/geth',
    command => "geth data init --datadir ${datadir} ${init_data} 2>> ${logdir}/init-data.log",
    user    => 'geth',
    # Command is so long ?!?
    timeout => 1800,
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
    command => "geth account new --password ${passfile} 2>> ${logdir}/create-account.log",
    user    => 'geth',
    path    => [ '/usr/bin', '/bin', '/usr/sbin' ],
  }
}

