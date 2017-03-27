#!/usr/bin/env bash

wget https://launchpad.net/test-db/employees-db-1/1.0.6/+download/employees_db-full-1.0.6.tar.bz2

bzip2 -d employees_db-full-1.0.6.tar.bz2
tar -xvf employees_db-full-1.0.6.tar
cd employees_db

sed -i '.bak' 's/storage_engine/default_storage_engine/g' employees.sql
sed -i '.bak' 's/storage_engine/default_storage_engine/g' test_employees_md5.sql
sed -i '.bak' 's/storage_engine/default_storage_engine/g' test_employees_sha.sql

#mysql -u root -p
#mysql -t < employees.sql
#sudo mysql -t < test_employees_md5.sql
#sudo mysql -t < test_employees_sha.sql

mysql -u root -p -t < employees.sql
mysql -u root -p -t < test_employees_md5.sql
mysql -u root -p -t < test_employees_sha.sql

# To create employees table in Hive
sqoop import --connect jdbc:mysql://localhost:3306/employees --username root -P --table employees --fields-terminated-by "|" --hive-import --driver com.mysql.jdbc.Driver -m 1

# To create salaries table in Hive
sqoop import --connect jdbc:mysql://localhost:3306/employees --username root -P --table salaries --fields-terminated-by "|" --hive-import --driver com.mysql.jdbc.Driver -m 1

#hive -e "DESCRIBE EXTENDED employees;"
#hive -e "drop table employees;"
#hive -e "drop table salaries;"
#
#hdfs dfs -du -h /apps/hive/warehouse/employees
#hdfs dfs -du -h /apps/hive/warehouse/salaries
#
#to view block size:
#http://localhost:50070/explorer.html#/apps/hive/warehouse/salaries
#maria_dev / maria_dev
#

