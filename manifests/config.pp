# == Class: geth::config
class geth::config (
  String  $user             = $geth::user,
  String  $datadir          = $geth::datadir,
  String  $init_data        = $geth::init_data,
  String  $account_password = $geth::account_password,
  String  $passfile         = $geth::passfile,
  String  $logdir           = $geth::logdir,
)
{
  exec { "geth --datadir ${datadir} init ${init_data} >> ${logdir}/init-data.log 2>&1":
    cwd     => "/home/${user}",
    user    => 'geth',
    path    => [ '/usr/bin', '/bin', '/usr/sbin' ],
  }

  ~> file { $passfile:
      content => $account_password,
      owner   => $user,
      mode    => '0400',
  }

  ~> exec { "geth --datadir ${datadir} --password ${passfile} account new >> ${logdir}/create-account.log 2>&1":
      cwd  => "/home/${user}",
      user => $user,
      path => [ '/usr/bin', '/bin', '/usr/sbin' ],
    }
}

