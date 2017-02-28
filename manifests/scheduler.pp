# manages the cronjob to run ISPProtect
class ispprotect::scheduler {

  $basedir        = $ispprotect::basedir
  $scheduled_scan = $ispprotect::scheduled_scan
  $scan_weekday   = $ispprotect::scan_weekday
  $scan_hour      = $ispprotect::scan_hour
  $scan_minute    = $ispprotect::scan_minute
  $max_delay      = $ispprotect::max_delay
  $scan_target    = $ispprotect::scan_target
  $license        = $ispprotect::license
  $mail_recipient = $ispprotect::mail_recipient

  if $license == undef {
    $scan_key='TRIAL'
  } else {
    $scan_key="${basedir}/etc/license"
  }
  cron { 'ISPProtect scheduled scanner update':
    command => "${basedir}/lib/ispp_scan --update --scan-key=${scan_key}",
    hour    => $scan_hour,
    weekday => $scan_weekday,
    minute  => '1',
  }

  if $scheduled_scan {
    cron { 'ISPProtect scheduled scan':
      command => "/bin/sleep $[ ( \$RANDOM % ${max_delay} )  + 1 ]s && ${basedir}/lib/ispp_scan --non-interactive --force-yes --email-results=${mail_recipient} --path=${scan_target} --scan-key=${scan_key} >/dev/null",
      hour    => $scan_hour,
      weekday => $scan_weekday,
      minute  => $scan_minute,
    }
  } else {
    cron { 'ISPProtect scheduled scan': ensure => 'absent', }
  }

}
