# == Class: geth::service
class geth::service {
  service { 'geth':
    ensure => stopped,
    enable => true,
  }
}
