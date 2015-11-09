#!/usr/bin/env bash

euca_conf --register-service -T user-api -H 128.111.55.40 -N squeak_services
usr/sbin/euca_conf --register-walrusbackend --partition walrus --host 128.111.55.40  --component squeak_walrus
/usr/sbin/euca_conf --register-cluster --partition squeak_zone --host  128.111.55.40 --component squeak_cc
/usr/sbin/euca_conf --register-sc --partition squeak_zone --host 128.111.55.40 --component squeak_sc
/usr/sbin/euca_conf --register-nodes "128.111.55.40 128.111.55.33"
