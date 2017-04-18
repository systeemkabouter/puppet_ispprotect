# manages the cronjob to run ISPProtect
class ispprotect::scheduler {

<<<<<<< HEAD
  $basedir             = $ispprotect::basedir
  $scheduled_scan      = $ispprotect::scheduled_scan
  $scheduled_update    = $ispprotect::scheduled_update
  $scan_weekday        = $ispprotect::scan_weekday
  $scan_hour           = $ispprotect::scan_hour
  $scan_minute         = $ispprotect::scan_minute
  $max_delay           = $ispprotect::max_delay
  $scan_target         = $ispprotect::scan_target
  $license             = $ispprotect::license
  $mail_recipient      = $ispprotect::mail_recipient
  $ensure              = $ispprotect::ensure
  $webproxy            = $ispprotect::webproxy
  $whitelist_path      = $ispprotect::whitelist_path
  $email_empty_results = $ispprotect::email_empty_results

  if $license == undef {
    $scan_key='TRIAL'
  } else {
    $scan_key="${basedir}/etc/license"
  }

  $email_empty_results_string = $email_empty_results ? {
    true => ' --email-empty-results ',
    false => undef,
  }


  cron { 'ISPProtect scheduled scanner update': ensure => 'absent', }

  file { "${basedir}/bin/run_ispprotect.sh":
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0550',
    content => template("${module_name}/run_ispprotect.sh.erb"),
  }

  if $scheduled_scan {
    cron { 'ISPProtect scheduled scan':
      ensure  => $ensure,
      command => "${basedir}/bin/run_ispprotect.sh",
      hour    => $scan_hour,
      weekday => $scan_weekday,
      minute  => $scan_minute,
    }
  } else {
    cron { 'ISPProtect scheduled scan': ensure => 'absent', }
  }

}
