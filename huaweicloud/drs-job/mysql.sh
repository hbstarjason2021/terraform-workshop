
### apt-get install expect

mysql_host=$(ifconfig eth0 |grep "inet "| awk '{print $2}')

## mysql -u root -h $mysql_host -p -e "create database loadtest"
## Cloud12#$

#!/usr/bin/expect
spawn mysql -u root -h $mysql_host -p -e "create database loadtest"
expect "*password"
send "Cloud12#$\n"
expect eof 
# 上面脚本\n可用\r代替


### sysbench /root/sysbench/tests/include/oltp_legacy/oltp.lua --db-driver=mysql --mysql-db=loadtest --mysql-user=root --mysql-password='Cloud12#$' --mysql-port=3306 --mysql-host='$mysql_host' --oltp-tables-count=10 --oltp-table-size=10000 --threads=20 prepare
### sysbench /root/sysbench/tests/include/oltp_legacy/insert.lua --db-driver=mysql --mysql-db=loadtest --mysql-user=root --mysql-password='Cloud12#$' --mysql-port=3306 --mysql-host='$mysql_host' --oltp-tables-count=10 --oltp-table-size=1000 --max-time=3600 --max-requests=0 --threads=10 --report-interval=3 --rate=20 --forced-shutdown=1 run

