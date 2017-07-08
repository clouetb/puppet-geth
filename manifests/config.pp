# == Class: geth::config
class geth::config ($init_data, $account_password) inherits geth {
  exec { 'geth-init-data':
    cwd         => '/home/geth'
    command     => 'geth --datadir data init $init_data',
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
    cwd         => '/home/geth'
    command     => 'geth account new --password /home/geth/passfile',
    user        => 'geth',
    path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
  }
}

