# Class: geth
# ===========================
#
# A class for grouping parameters for the go-ethereum.
# Tested on CentOS only so far.
#
# Parameters
# ----------
#
# * String  $user
# The user Ethereum will run as 
# (default: geth)
# * String  $identity
# The identity of this node in the blockchain
# (default: geth_identity)
# * String  $networkid
# The id of the network geth must connect to
# (default: 1234567890)
# * Integer $unlock
# Shall we unlock the account (0 for not unlocking or id of the account)
# (default: 0)
# * Integer $port
# The port geth must listen on
# (default: 30999)
# * String  $rpcaddr
# The address geth will bind to for exposing the RPC interface
# (default: localhost)
# * Integer $rpcport
# The port geth will bind to for exposing the RPC interface
# (default: 8545)
# * String  $rpcapi
# The RPC API that will be enabled
# (default: 'admin,eth,net,web3')
# * String  $rpccorsdomain
# Cross domain that will be entitled to send requests to geth RPC API
# (default: *)
# * Integer $minerthreads
# The number of threads that will do mining
# (default: 1)
# * String  $nat
# The kind of nat that will be used for exposing the listening port
# (default: any)
# * Integer $maxpeers
# The maximum number of peers allowed to connect. 0 for no max.
# (default: 0)
# * Boolean $nodiscover
# Shall we prevent new nodes discovery?
# (default: true = no node will be discovered)
# * Boolean $rpc
# Shall we enable RPC API?
# (default: true)
# * Boolean $mine
# Shall we mine?
# (default: true)
# * Boolean $autodag
# Shall we pregenerate DAG?
# (default: true)
# * String  $datadir
# The directory where geth data will be stored
# (default: /home/${user}/data)
# * String  $init_data
# The parameters for initializing the blockchain
# (default /home/${user}/genesis.json)
# * String  $passfile
# The file where the account password will be stored
# (default: /home/${user}/passfile)
# * String  $logdir
# The directory where all the logs will be stored
# (default: /var/log/geth)
# * String  $account_password
# The accound password
# (default: P4ssw0rd!)
#
# Examples
# --------
#
# @example
#    # Generic parameters
#    class {'geth':
#      user             => 'my_user',
#      identity         => 'MyIdentityOnEthereum',
#      networkid        => 9999999999,
#      init_data        => '/tmp/genesis.json',
#      account_password => 'V3ryS3cr3tP4ssw0rd',
#      rpcaddr          => '192.168.1.1',
#      ...
#    }
#    # Trigger install
#    class {'geth::install':}
#    # Run configuration and account creation
#    class {'geth::config':}
#    # Enable and run geth as a systemd service unit
#    class {'geth::service':}
#
# Authors
# -------
#
# Benoît Clouet <benoit.clouet@gmail.com>
#
# Copyright
# ---------
#
# Copyright 2017 Benoît Clouet.
#
# License
# -------
#
#                     GNU GENERAL PUBLIC LICENSE
#                        Version 3, 29 June 2007

#  Copyright (C) 2007 Free Software Foundation, Inc. <http://fsf.org/>
#  Everyone is permitted to copy and distribute verbatim copies
#  of this license document, but changing it is not allowed.


class geth(
  String  $user             = 'geth',
  String  $identity         = 'geth_identity',
  String  $networkid        = '1234567890',
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
  String  $datadir          = "/home/${user}/data",
  String  $init_data        = "/home/${user}/genesis.json",
  String  $passfile         = "/home/${user}/passfile",
  String  $logdir           = '/var/log/geth',
  String  $account_password = 'P4ssw0rd!',
)
{}