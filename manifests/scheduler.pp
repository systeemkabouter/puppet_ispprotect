# manages the cronjob to run ISPProtect
class ispprotect::scheduler {

  $basedir = $ispprotect::basedir
  $scan_frequency = $ispprotect::scan_frequency
  $scan_hour = $ispprotect::scan_hour
  $scan_minute = $ispprotect::scan_minute
  $max_delay = $ispprotect::max_delay
  $scan_target = $ispprotect::scan_target
  $license = $ispprotect::license
  $mail_recipient = $ispprotect::mail_recipient

  case $scan_frequency {
    'daily':  {  }
    'weekly': { $weekday=6 }
    default: { fail { 'scan_frequency should be daily or weekly': } }
  }

  if $license == undef {
    $scan_key='TRIAL'
  } else {
    $scan_key="${basedir}/etc/license"
  }
  cron { 'ISPProtect scheduled scanner update':
    command => "${basedir}/lib/ispp_scan --update --scan-key=${scan_key}",
    hour    => $scan_hour,
    weekday => $weekday,
    minute  => '1',
  }

  cron { 'ISPProtect scheduled scan':
    command => "/bin/sleep $[ ( \$RANDOM % ${max_delay} )  + 1 ]s && ${basedir}/lib/ispp_scan --email-results=${mail_recipient} --path=${scan_target} --scan-key=${scan_key}",
    hour    => $scan_hour,
    weekday => $weekday,
    minute  => $scan_minute,
  }
}
