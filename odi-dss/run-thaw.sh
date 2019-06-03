#!/bin/bash
. /functions
/usr/bin/python /usr/local/dss/dss3.py thaw >> /usr/local/dss/dss_thaw.log 2>&1 &
