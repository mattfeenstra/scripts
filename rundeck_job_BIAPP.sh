date >>/tmp/rundeck.log
whoami >>/tmp/rundeck.log
pwd >>/tmp/rundeck.log
uname -a >>/tmp/rundeck.log
echo @option.BRANCH@  >>/tmp/rundeck.log
echo @option.GIT_URL@ >>/tmp/rundeck.log

rm -rf /var/www/html/* || true
rm -rf /var/www/html/.* || true





echo ${option.BRANCH} >> /tmp/rundeck.log




git clone --branch ${option.BRANCH} ${option.GIT_URL} /var/www/html 1>>/tmp/rundeck.log 2>>/tmp/rundeck.log





/etc/init.d/httpd restart




UUID e858fdd8-e6b7-4b7d-8a2d-75bdea0cae63



