#!/bin/bash
. /functions

if [[ $# -eq 0 ]]; then
    MODE="thaw"
else
    MODE=$1
fi

## We redirect this to /dev/null since there's already logging in the script.
if [[ "${MODE}" == "archive" ]]; then
    daemon "nohup /usr/local/odi/DTS_Delivery_App/bin/ingest.sh > /dev/null &"
fi
echo "Running DSS in mode: ${MODE}"
/usr/bin/python /usr/local/dss/bin/dss3.py ${MODE} >> /usr/local/var/log/dss/dss_${MODE}.log 2>&1

