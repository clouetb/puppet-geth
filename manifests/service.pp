# == Class: geth::service
class geth::service inherits geth {
  file { 'logdir':
    path     => '/var/log/geth',
    ensure   => 'directory',
    owner    => 'geth',
    mode     => '0755',
  }~>
  service { 'geth':
    ensure   => running,
    enable   => true,
  }
}
