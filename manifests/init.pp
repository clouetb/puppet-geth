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
  String  $identity         = 'Participant1',
  String  $networkid        = '1234321',
  Integer $unlock           = 0,
  Integer $port             = 30999,
  String  $rpcaddr          = 'localhost',
  Integer $rpcport          = 8545,
  String  $rpcapi           = 'admin,eth,net,web3',
  String  $rpccorsdomain    = '*',
  Integer $minerthreads     = 1,
  String  $nat              = 'any',
  Integer $maxpeers         = 0,
  Boolean $nodiscover       = true,
  Boolean $rpc              = true,
  Boolean $mine             = true,
  Boolean $autodag          = true,
  String  $init_data        = '/home/geth/data', 
  String  $account_password = 'P4ssw0rd!',
)
{
    include geth::install
    include geth::config
    include geth::service
}
