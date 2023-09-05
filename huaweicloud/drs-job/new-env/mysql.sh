#!/usr/bin/expect

### apt-get install expect

mysql_host=$(ifconfig eth0 |grep "inet "| awk '{print $2}')
mysql_paas="Cloud12#$"

## mysql -u root -h $mysql_host -p -e "create database loadtest"
## Cloud12#$


spawn mysql -u root -h $mysql_host -e "create database loadtest"  -p
expect "Enter password:"
send "Cloud12#$\r"
interact

#####  echo "create database loadtest" | mysql -u root -h  $mysql_host -p${mysql_paas}

### sysbench /root/sysbench/tests/include/oltp_legacy/oltp.lua --db-driver=mysql --mysql-db=loadtest --mysql-user=root --mysql-password="$mysql_paas" --mysql-port=3306 --mysql-host="$mysql_host" --oltp-tables-count=10 --oltp-table-size=10000 --threads=20 prepare
### sysbench /root/sysbench/tests/include/oltp_legacy/insert.lua --db-driver=mysql --mysql-db=loadtest --mysql-user=root --mysql-password="$mysql_paas" --mysql-port=3306 --mysql-host="$mysql_host" --oltp-tables-count=10 --oltp-table-size=1000 --max-time=3600 --max-requests=0 --threads=10 --report-interval=3 --rate=20 --forced-shutdown=1 run

