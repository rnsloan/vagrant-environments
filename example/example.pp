# execute command
exec { 'apt-get update':
  command => '/usr/bin/apt-get update',
  timeout => 0  
}

# install package
package { "apache2":
  ensure => present,
  require => Exec['apt-get update']
}

package { "php5-cli":
  ensure => present,
  require => Exec['apt-get update']
}

# run service
service { "apache2":
  ensure => running,
  require => Package['apache2']  
}

file { '/etc/apache2/sites-available/default':
  ensure => file,
  require => Package['apache2']
}    

# execute command only when command it is subscribed to has run
# (needs file resource declared above)
exec { 'reload-apache2':
  command => '/etc/init.d/apache2 reload',
  refreshonly => true,
  subscribe => File['/etc/apache2/sites-available/default'],
  require => Package['apache2']
}

# create directory
file { "/var/www/uploads":
  ensure => 'directory',
  owner => "www-data",
  group => "www-data",
  mode => "777"
}

# create group
group { "wheel":
  ensure => "present",
}

# create user
user { "developer":
  ensure => "present",
  gid => "wheel",
  shell => "/bin/bash",
  home => "/home/developer",
  managehome => true,
  password => "passwordtest",
  require => Group['wheel']
}