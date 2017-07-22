# geth

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with geth](#setup)
    * [What geth affects](#what-geth-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with geth](#beginning-with-geth)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Release Notes/Contributors/Etc](#release-notes)
8. [License](#license)


## Description

clouetb-geth installs and configures go-ethereum on CentOS.
It relies upon the package provided on the OKAY RPM repository (https://okay.com.mx/en/blog/rpm-repositories-for-centos-6-and-7.html).
It also provides a custom facts plugin.

## Setup

### What geth affects

Installs the package from the above-mentioned repository. Creates an unprivileged user (with its home directory) for running go-ethereum as a systemd service unit. Also installs and runs ntpd from the centos repository as Ethereum requires proper time synchronization.

### Setup Requirements

Only tested on CentOS 7.
Uses puppet-stdlib.

### Beginning with geth

If you're happy with the defaults, just enter :
```puppet
class {'geth':
}
# Trigger install
class {'geth::install':}
# Run configuration and account creation
class {'geth::config':}
# Enable and run geth as a systemd service unit
class {'geth::service':}
```

Otherwise, feel free to configure :
```puppet
# Generic parameters
class {'geth':
  user             => 'my_user',
  identity         => 'MyIdentityOnEthereum',
  networkid        => 9999999999,
  init_data        => '/tmp/genesis.json',
  account_password => 'V3ryS3cr3tP4ssw0rd',
  rpcaddr          => '192.168.1.1',
  ...
}
# Trigger install
class {'geth::install':}
# Run configuration and account creation
class {'geth::config':}
# Enable and run geth as a systemd service unit
class {'geth::service':}
```

## Usage

Please refer to manifests/init.pp for an extensive list of supported parameters or see below.

## Reference

* String  $user
The user Ethereum will run as 
(default: geth)
* String  $identity
The identity of this node in the blockchain
(default: geth_identity)
* String  $networkid
The id of the network geth must connect to
(default: 1234567890)
* Integer $unlock
Shall we unlock the account (0 for not unlocking or id of the account)
(default: 0)
* Integer $port
The port geth must listen on
(default: 30999)
* String  $rpcaddr
The address geth will bind to for exposing the RPC interface
(default: localhost)
* Integer $rpcport
The port geth will bind to for exposing the RPC interface
(default: 8545)
* String  $rpcapi
The RPC API that will be enabled
(default: 'admin,eth,net,web3')
* String  $rpccorsdomain
Cross domain that will be entitled to send requests to geth RPC API
(default: *)
* Integer $minerthreads
The number of threads that will do mining
(default: 1)
* String  $nat
The kind of nat that will be used for exposing the listening port
(default: any)
* Integer $maxpeers
The maximum number of peers allowed to connect. 0 for no max.
(default: 0)
* Boolean $nodiscover
Shall we prevent new nodes discovery?
(default: true = no node will be discovered)
* Boolean $rpc
Shall we enable RPC API?
(default: true)
* Boolean $mine
Shall we mine?
(default: true)
* Boolean $autodag
Shall we pregenerate DAG?
(default: true)
* String  $datadir
The directory where geth data will be stored
(default: /home/${user}/data)
* String  $init_data
The parameters for initializing the blockchain
(default /home/${user}/genesis.json)
* String  $passfile
The file where the account password will be stored
(default: /home/${user}/passfile)
* String  $dagdir
Directory where the DAG will be stored
(default: /home/${user}/.ethash)
* Integer $block_number
The block number for which to generate the DAG
(default: 0)
* String  $logdir
The directory where all the logs will be stored
(default: /var/log/geth)
* String  $account_password
The accound password
(default: P4ssw0rd!)

## Limitations

Only tested on CentOS 7.
This module was developed for an inhouse project, so it doesn't support all the ethereum functionalities so far.
I'm far from an expert in Ethereum, documentation might not be completely accurate regarding Ethereum internals.
I'm far from an expert in Puppet as well. If your node starts to smoke while using this module, you should probably file an issue.

## Development

Pull requests, comments, issues are welcome.

## Release Notes/Contributors/Etc.

* 0.5 - Initial version published on puppet forge.
* 0.5.1 - Service now started after install.
* 0.5.2 - Changed metadata to comply with puppet forge's recommendation.
* 0.6.0 - Added a makedag function for pre-generating the DAG (long running operation)

## License

                    GNU GENERAL PUBLIC LICENSE
                       Version 3, 29 June 2007

 Copyright (C) 2007 Free Software Foundation, Inc. <http://fsf.org/>
 Everyone is permitted to copy and distribute verbatim copies
 of this license document, but changing it is not allowed.