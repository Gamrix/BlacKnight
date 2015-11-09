# modules/eucalyptus/manifests/init.pp

class eucalyptus {

  # formerly config -------------------------------------------------
  include install-euca

  # TODO: chkconfig eucalyptus-* off
  class euca-prep {
    file { '/etc/eucalyptus/' :
      ensure  => directory,
    }

    file { '/etc/eucalyptus/eucalyptus.conf' :
      require => File['/etc/eucalyptus'],
      ensure  => file,
      content => template('eucalyptus/eucalyptus.conf.erb')
    }

    file { '/etc/selinux/config' :
      ensure => file,
      source => 'puppet:///modules/eucalyptus/selinux.config.original'
    }

    exec { '/usr/sbin/setenforce 0' :
      onlyif => '/usr/bin/test `/usr/sbin/getenforce` == Enabled'
    }

    service { 'eucalyptus-cloud' :
      enable  => false,
    }

    service { 'eucalyptus-cc' :
      enable  => false,
    }

    service { 'eucalyptus-nc' :
      enable  => false,
    }

    service { 'eucanetd' :
      enable  => false,
    }

    # formerly network ------------------------------------------------

    augeas{ "ifcfgeth1":
      context => '/etc/sysconfig/network-scripts/ifcfg-eth1',
      changes => [
        "set BRIDGE br0",
        "set ONBOOT yes",
        "set NM_CONTROLLED no",
        "set BOOTPROTO none",
      ],
    }

    file { '/etc/sysconfig/network-scripts/ifcfg-br0' :
      content => template('eucalyptus/ifcfg-br0.erb'),
      mode    => 0644
    }
    
    package{'ntp':
      ensure => installed,
    }

    service { 'ntpd' :
      require => Package[ 'ntp' ],
      ensure  => 'running',
      enable  => 'true'
    }

    # TODO: Eucalyptus seems to complain about this
    service { 'iptables' :
      ensure => 'stopped',
      enable => 'false'
    }

    # TODO: cleaner way of doing this?
    exec { 'Bring up br0 at boot':
      command => "/bin/echo 'ifup br0' >> /etc/rc.local",
      unless  => "/bin/grep 'ifup br0' /etc/rc.local"
    }
  }

  # formerly repo ---------------------------------------------------
  class euca-repo-setup{
    package { 'eucalyptus-release' :
      provider => rpm,
      ensure   => present,
      source   => 'http://downloads.eucalyptus.com/software/eucalyptus/4.1/centos/6/x86_64/eucalyptus-release-4.1.el6.noarch.rpm'
    }

    package { 'euca2ools-release' :
      provider => rpm,
      ensure   => present,
      source   => 'http://downloads.eucalyptus.com/software/euca2ools/3.2/centos/6/x86_64/euca2ools-release-3.2.el6.noarch.rpm'
    }

    package { 'epel-release' :
      provider => rpm,
      ensure   => present,
      source   => 'http://downloads.eucalyptus.com/software/eucalyptus/4.1/centos/6/x86_64/epel-release-6.noarch.rpm'
    }
  }

  # formerly packages -----------------------------------------------
  class install-euca{
    require euca-prep
    require euca-repo-setup
    $pkgs = [ 'eucalyptus-nc.x86_64',
      'eucalyptus-cloud',
      'eucalyptus-cc',
      'eucalyptus-service-image',
      'eucalyptus-sc',
      'eucalyptus-walrus' ]

    package { $pkgs :
      ensure  => 'present',
    }
  }

}
