#!/usr/bin/env bash

# Install maven
wget http://mirror.vorboss.net/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
tar -xvf apache-maven-3.3.9-bin.tar.gz
mv apache-maven-3.3.9 /usr/local

export PATH=/usr/local/apache-maven-3.3.9/bin:$PATH

mvn -version

git clone https://github.com/rcongiu/Hive-JSON-Serde.git

cd Hive-JSON-Serde
mvn -Phdp25 clean package

hdfs dfs -mkdir /lib
hdfs dfs -put json-serde/target/json-serde-1.3.8-SNAPSHOT-jar-with-dependencies.jar /lib
hdfs dfs -chmod -R 755 /lib

#Reference:
#https://github.com/rcongiu/Hive-JSON-Serde
#https://hortonworks.com/blog/howto-use-hive-to-sqlize-your-own-tweets-part-two-loading-hive-sql-queries/
