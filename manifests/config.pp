# == Class: geth::config
class geth::config (
  String  $init_data        = $geth::init_data, 
  String  $account_password = $geth::account_password,
) 
inherits geth {
  exec { 'geth-init-data':
    cwd         => '/home/geth',
    command     => "geth data init --datadir $init_data",
    user        => 'geth',
    path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
  }~>
  file { 'passfile':
    path        => '/home/geth/passfile',
    content     => "${account_password}",
    owner       => 'geth',
    mode        => '0400',
  }~>
  exec { 'geth-create-account':
    cwd         => '/home/geth',
    command     => 'geth account new --password /home/geth/passfile',
    user        => 'geth',
    path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
  }
}

