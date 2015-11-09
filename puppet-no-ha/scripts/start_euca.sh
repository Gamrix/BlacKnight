#!/usr/bin/env bash

/usr/sbin/euca_conf --initialize
service eucalyptus-cloud start
service eucalyptus-cc start
service eucalyptus-nc start