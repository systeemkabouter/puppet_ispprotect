# Class: ispprotect
# ===========================
#
# This class downloads, installs and schedules ISPProtect, a php malware scanner.
# By default it is deployed using the evaluation license, please purchase a
# a license if you chose to keep using the software.
#
# The product website can be found at https://ispprotect.com/
#
# Although the puppet module is licensed under the Apache license, the product
# itself is commercial software. The author of the module is not affiliated with
# the vendor.
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
# * `license`
#
# The commercial license that was obtained.
#
# * `ensure`
#
# Wether to add or remove defined resources. Defaults to present,
# can be set to absent to remove ISPProtect. Does this on best effort
# basis, YMMV. Please test this before actually using.
#
# * `basedir`
#
# Directory under where to install the payload and helper files.
#
# * `payload_url`
#
# Webaddress where to download the software. Defaults to the ispprotect official
# website, but may point at an internal distribution server.
#
# * `scan_target`
#
# base directory that needs to be scanned using the payload. Defaults to '/var/www/html'
#
# * `manage_clamav`
#
# Ensures the package clamav is installed, defaults to true
#
# * `scheduled_scan`
#
# Wether or not a cron scheduled scan should be planned. Defaults to true
#
# * `scan_hour`
#
# The hour of the day the scan is scheduled to start.
#
# * `scan_minute`
#
# The minute the crobjob will start. Please note that default a RANDOM
# sleep is performed before starting the actual scan.
#
# * `scan_weekday`
#
# Day of the week to run the scan, may be a array.
#
# * `may_delay`
#
# The maximum number of seconds the start of the scan will be delayed
#
# * `mail_recipient`
#
# The email address to sent reports to.
#
# Examples
# --------
#
# @example
#    class { 'ispprotect':
#      license => 'Your License Key Here'
#    }
#
# Authors
# -------
#
# Eelco Maljaars <eelco@maljaars-it.nl>
#
# Copyright
# ---------
#
# Copyright 2017 Maljaars IT / Erasmus University Rotterdam
#
class ispprotect(

  $license             = undef,
  $ensure              = 'present',
  $basedir             = '/opt/ispprotect',
  $payload_url         = 'https://www.ispprotect.com/download/ispp_scan.tar.gz',
  $scan_target         = '/var/www/html',
  $manage_clamav       = true,
  $scheduled_scan      = true,
  $scheduled_update    = true,
  $scan_weekday        = '6',
  $scan_hour           = '3',
  $scan_minute         = '17',
  $max_delay           = '300',
  $mail_recipient      = "root@${::fqdn}",
  $webproxy            = undef,
  $whitelist_path      = "${basedir}/etc/ispp_scan_whitelist",
  $email_empty_results = false,


) {

  contain ispprotect::install
  contain ispprotect::license
  contain ispprotect::scheduler

}
