# Osmosis Node Sync Monitor

> Osmosis node blocks sync monitor tools.

[![Build Status](http://img.shields.io/travis/badges/badgerbadgerbadger.svg?style=flat-square)](https://travis-ci.org/badges/badgerbadgerbadger) [![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

## Table of Contents

- [Installation](#installation)
- [Features](#features)
- [Contributing](#contributing)
- [Team](#team)
- [FAQ](#faq)
- [License](#license)

## Installation

- Ubuntu 20.04 LTS
- Written in bash

### Clone

- Clone this repo to your server using:

``` bash
$ sudo mkdir -p /data/monitor/exinpool
$ cd /data/monitor/exinpool
$ sudo git clone https://github.com/ExinPool/Osmosis
$ sudo apt -y install jq
```

### Setup

Copy `config.cfg.defaults` to `config.cfg` and change some varibles like this in the `config.cfg`.

``` bash
SERVICE=Osmosis
LOCAL_HOST=http://127.0.0.1:26657/status
REMOTE_HOST_FIRST=https://rpc.osmosis.zone/status
REMOTE_HOST_SECOND=https://osmosis-mainnet-rpc.allthatnode.com:26657/status
ABS_NUM=100
LOG_FILE=osmosis-sync.log
LARK_WEBHOOK_URL=https://open.larksuite.com/open-apis/bot/v2/hook/
```

Add crontab like this in the server.

``` bash
# Osmosis node sync monitor
*/30 * * * * cd /data/monitor/exinpool/BSC/process && bash bsc_sync.sh >> bsc_sync.log &
```

The crontab will run every minute then you can check the log in the `bsc_sync.log`.

## Features

- Monitor Osmosis node blocks sync
- Send alarm message when node blocks sync is abnormal
- Send alarm message to Lark which based on Lark webhook API

## Contributing

To be continued.

## Team

@ExinPool

## FAQ

To be continued.

## License

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

- **[MIT license](https://opensource.org/licenses/mit-license.php)**
- Copyright 2022 © ExinPool