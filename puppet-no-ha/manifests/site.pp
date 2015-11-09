# manifests/site.pp

# Puppet
File {
  owner => 'root',
  group => 'root'
}

Exec {
  path => "$path"
}

# Eucalyptus
$CLOUD_OPTS = '--db-home=/usr/pgsql-9.1/ --java-home=/usr/lib/jvm/java-1.7.0'
$EUCALYPTUS = '/'
$EUCA_BASE = '/var/lib/eucalyptus'
$HYPERVISOR = 'kvm'
$LOGLEVEL = 'DEBUG'
$VNET_DNS = '128.111.41.10'
$VNET_MODE = 'MANAGED-NOVLAN'
$VNET_NETMASK = '255.255.255.0'
$VNET_PRIVINTERFACE = 'br0'
$VNET_PUBLICIPS = '128.111.55.41-128.111.55.46 128.111.55.48-128.111.55.49'
$VNET_SUBNET = '10.50.10.0'

# Riak CS
# Note: consult docs.basho.com/riakcs/latest/cookbooks/Version-Compatibility/
# for riak-cs version compatibility
$RIAKCS_VERSION = '2.0.0-1.el6'
$RIAK_VERSION = '2.0.5-1.el6'
$STANCHION_VERSION = '2.0.0'

$RIAKCS_PORT = 9090
$STANCHION_HOST = '128.111.55.39'
$RIAK_ADMIN_KEY = 'GE-NBCXO9KMHB5FX6_LE'
$RIAK_ADMIN_SECRET = 'poijG0ZVojshvgLrkR1CzLmqcHDdekjhoTT5uQ=='

# ZooKeeper
$ZK_SERVERS = [ '128.111.55.39', '128.111.55.51', '128.111.55.50', '128.111.55.25' ]
$ZK_IDS = { '128.111.55.39' => 1,
                '128.111.55.51' => 2,
                '128.111.55.50' => 3,
                '128.111.55.25' => 4 }

# Physical nodes
node 'squeak.cs.ucsb.edu' {
  $PUBLIC_IP = '128.111.55.40'
  $IPADDR = '10.50.10.40'
  $HOSTNAME = 'squeak.cs.ucsb.edu'

  include riak
  include eucalyptus
  # include blacknight
}

node 'lisp.cs.ucsb.edu' {
  $PUBLIC_IP = '128.111.55.33'
  $IPADDR = '10.50.10.33'
  $HOSTNAME = 'lisp.cs.ucsb.edu'

  include riak
  include eucalyptus
  # include blacknight
}

node 'fsharp.cs.ucsb.edu' {
  $PUBLIC_IP = '128.111.55.31'
  $IPADDR = '10.50.10.31'
  $HOSTNAME = 'fsharp.cs.ucsb.edu'

  include riak
  include eucalyptus
  # include blacknight
}

node 'perl.cs.ucsb.edu' {
  $PUBLIC_IP = '128.111.55.28'
  $IPADDR = '10.50.10.28'
  $HOSTNAME = 'perl.cs.ucsb.edu'

  include riak
  include eucalyptus
  # include blacknight
}

node 'python.cs.ucsb.edu' {
  $PUBLIC_IP = '128.111.55.22'
  $IPADDR = '10.50.10.22'
  $HOSTNAME = 'python.cs.ucsb.edu'

  include riak
  include eucalyptus
  # include blacknight
}
