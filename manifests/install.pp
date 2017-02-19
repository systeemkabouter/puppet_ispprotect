# downloads and installs the ISPProtect archive
class ispprotect::install {

  $basedir = $::ispprotect::basedir
  $payload_url = $::ispprotect::payload_url
  $manage_clamav = $::ispprotect::manage_clamav

  $skeleton = [$basedir, "${basedir}/bin", "${basedir}/tmp", "${basedir}/lib"]

  if $manage_clamav {
    package { 'clamav': ensure => 'present', }
  }

  file { $skeleton:
    ensure => 'directory',
    owner  => 'root',
    group  => 'root',
    mode   => '0550'
  } ->

  exec { 'fetch_payload':
    command => "/usr/bin/curl ${payload_url} -o ${basedir}/tmp/ispp_scan.tar.gz",
    creates => "${basedir}/tmp/ispp_scan.tar.gz",
  } ->

  exec { 'unpack_payload':
    command => "/bin/tar -xf ${basedir}/tmp/ispp_scan.tar.gz --directory ${basedir}/lib/",
    creates => "${basedir}/lib/ispp_scan.php",
  }

}
