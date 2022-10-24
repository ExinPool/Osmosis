# Osmosis Node Process Monitor

> Osmosis node process monitor tools.

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
```

### Setup

Copy `config.cfg.defaults` to `config.cfg` and change some varibles like this in the `config.cfg`.

``` bash
SERVICE=Osmosis
PROCESS=26656
PROCESS_NUM=1
LOG_FILE=osmosis-process.log
LARK_WEBHOOK_URL=https://open.larksuite.com/open-apis/bot/v2/hook/
```

Add crontab like this in the server.

``` bash
# Osmosis node process monitor
*/30 * * * * cd /data/monitor/exinpool/Osmosis/process && bash osmosis-process.sh >> osmosis-process.log &
```

The crontab will run every 30 minutes then you can check the log in the `osmosis-process.log`.

## Features

- Monitor Osmosis node process
- Send alarm message when node is abnormal
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
