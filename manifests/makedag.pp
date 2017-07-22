# == Class: geth::makedag
class geth::makedag (
  String  $user         = $geth::user,
  String  $ethash_path  = $geth::ethash_path,
  Integer  $block_number = $geth::block_number,
  String  $logdir       = $geth::logdir,
)
{
  file { $ethash_path:
    ensure => directory,
    owner  => $user,
    mode   => '0755',
  }

  exec { "geth makedag ${block_number} ${ethash_path} >> ${logdir}/init-dag.log 2>&1":
    cwd     => "/home/${user}",
    user    => $user,
    path    => [ '/usr/bin', '/bin', '/usr/sbin' ],
    timeout => 7200,
  }
}

