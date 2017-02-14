# ispprotect

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with ispprotect](#setup)
    * [What ispprotect affects](#what-ispprotect-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with ispprotect](#beginning-with-ispprotect)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module installs, configures and schedules the ISPProtect php malware scanner
on a node.

The module downloads the package from ispprotect.com or a custom URL. After that,
it unpacks and configures the package. Lastly the module schedules auto updates
for the scanner and actual scanning of a directory tree.

## Setup

### What ispprotect affects

This module installs the clamav package by default, you can prevent this by
setting the manage_clamav parameter to false.


### Beginning with ispprotect

Apart from the mail_recipient parameter, it should be usable using the defaults.
For real work you will need a license key, the trail expires after just a number
of tries.

## Usage

```
class { 'ispprotect':
  mail_recipient => 'you@example.com',
  scan_target => '/var/www/mywebsite',
}
```

## Reference

* `license`

The commercial license that was obtained.

* `basedir`

Directory under where to install the payload and helper files.

* `payload_url`

Web address where to download the software. Defaults to the ispprotect official
website, but may point at an internal distribution server.

* `scan_target`

base directory that needs to be scanned using the payload. Defaults to '/var/www/html'

* `scan_frequency`

Set the scan frequency to daily or weekly. Defaults to daily

* `manage_clamav`

Ensures the package clamav is installed, defaults to true

* `scan_hour`

The hour of the day the scan is scheduled to start.

* `scan_minute`

The minute the crobjob will start. Please note that default a RANDOM
sleep is performed before starting the actual scan.

* `may_delay`

The maximum number of seconds the start of the scan will be delayed


* `mail_recipient`

The email address to sent reports to.


## Limitations

Currently only tested on Red Hat Enterprise Linux 7. RHEL6 will be tested soon.

## Development

This module is new and a 'early' release. PR for more parameters or support for
other OS versions welcome.

## Disclaimer

This module is provided as-is. The author is an independant consultant without
other ties to ISPProtect than as a user / consumer. Product related questions
should be directed at ispprotect.com.
