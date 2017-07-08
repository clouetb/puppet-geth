# Class: geth
# ===========================
#
# Full description of class geth here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'geth':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <benoit.clouet@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class geth (
  String  $identity         = $geth::install::identity,
  String  $networkid        = $geth::install::networkid,
  Integer $unlock           = $geth::install::unlock,
  Integer $port             = $geth::install::port,
  String  $rpcaddr          = $geth::install::rpcaddr,
  Integer $rpcport          = $geth::install::rpcport,
  String  $rpcapi           = $geth::install::rpcapi,
  String  $rpccorsdomain    = $geth::install::rpccorsdomain,
  Integer $minerthreads     = $geth::install::minerthreads,
  String  $nat              = $geth::install::nat,
  Integer $maxpeers         = $geth::install::maxpeers,
  Boolean $nodiscover       = $geth::install::nodiscover,
  Boolean $rpc              = $geth::install::rpc,
  Boolean $mine             = $geth::install::mine,
  Boolean $autodag          = $geth::install::autodag,
  String  $init_data        = $geth::config::init_data, 
  String  $account_password = $geth::config::account_password,
)
{
    include geth::install
    include geth::config
    include geth::service
}
