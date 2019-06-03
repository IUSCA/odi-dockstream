#!/bin/bash

. /root/functions


daemon --user=root "nohup /usr/sbin/crond &"
/usr/bin/crontab /etc/cron.d/0odi-portal-notifications
### start spider
LOGDIR=/usr/local/var/log
daemon --user=odiuser "nohup /usr/local/portal/bin/listener/ppa-spider.py 1>>${LOGDIR}/ppa-spider.log 2>>${LOGDIR}/ppa-spider.stderr &"

### start listener
daemon --user=odiuser "nohup /usr/local/portal/bin/listener/portal.py 1>>${LOGDIR}/ppa-portal-listener.log 2>>${LOGDIR}/ppa-portal-listener.stderr &"

### Make sure we have our composer stuffs
cd /usr/local/portal/library/ && php composer.phar install

### This bit stolen from the default run script in centos/httpd

# Make sure we're not confused by old, incompletely-shutdown httpd
# context after restarting the container.  httpd won't start correctly
# if it thinks it is already running.
rm -rf /run/httpd/* /tmp/httpd*

exec /usr/sbin/apachectl -DFOREGROUND 
####
#

#/run-httpd.sh


