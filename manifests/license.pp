# manages the license or emits a warning
# that the package is deployed using an
# evaluation license
class ispprotect::license {

  $license = $::ispprotect::license
  $license_file = "${::ispprotect::basedir}/etc/license"

  if $license == undef {
    notify { 'ISPProtect is commercial software, please purchase a license at https://ispprotect.com/': }

    file { $license_file : ensure => 'absent', }

  } else {

    file { $license_file :
      owner   => 'root',
      group   => 'root',
      mode    => '0440',
      content => "${::ispprotect::license}\n"
    }

  }

}
