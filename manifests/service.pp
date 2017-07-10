# == Class: geth::service
class geth::service {
  service { 'geth':
    ensure => running,
    enable => true,
  }
}
