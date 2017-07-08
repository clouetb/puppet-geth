# == Class: geth::service
class geth::service inherits geth {
  service { 'geth':
    ensure   => stopped,
    enable   => true,
  }
}
