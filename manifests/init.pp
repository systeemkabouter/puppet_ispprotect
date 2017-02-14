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

  $license = undef,
  $basedir = '/opt/ispprotect',
  $payload_url = 'https://www.ispprotect.com/download/ispp_scan.tar.gz',
  $scan_target = '/var/www/html',
  $scan_frequency = 'daily',
  $manage_clamav = true,
  $scan_hour = '3',
  $scan_minute = '17',
  $max_delay = '300',
  $mail_recipient = "root@$::fqdn",

) {

  contain ispprotect::install
  contain ispprotect::license
  contain ispprotect::scheduler

}
