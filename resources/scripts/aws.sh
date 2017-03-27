#!/usr/bin/env bash



AWS Details:

ec2-52-56-219-167.eu-west-2.compute.amazonaws.com
 52.56.219.167


chmod 600 hdp-exercise.pem

ssh -i hdp-exercise.pem ec2-user@ec2-52-56-219-167.eu-west-2.compute.amazonaws.com
ssh -i hdp-exercise.pem ec2-user@ec2-52-56-220-174.eu-west-2.compute.amazonaws.com
ssh -i hdp-exercise.pem ec2-user@ec2-52-56-222-243.eu-west-2.compute.amazonaws.com

# install iptables and ntpd
sudo yum install iptables-services
sudo systemctl start iptables
sudo service iptables save
sudo yum -y install ntp
sudo systemctl start ntpd

sudo chkconfig ntpd on
sudo chkconfig iptables off
sudo systemctl stop iptables
sudo service ntpd start

cd ~/aws-key/
scp -i hdp-exercise.pem hdp-exercise.pem ec2-user@ec2-52-56-219-167.eu-west-2.compute.amazonaws.com:

on node:
mv hdp-exercise.pem .ssh/id_rsa


Master:
ec2-user@ec2-52-56-219-167.eu-west-2.compute.amazonaws.com
52.56.219.167
ip-172-31-26-241.eu-west-2.compute.internal
172.31.26.241


Data-nodes:
ec2-user@ec2-52-56-220-174.eu-west-2.compute.amazonaws.com
52.56.220.174
ip-172-31-31-203.eu-west-2.compute.internal
172.31.31.203

Data-node2:
ec2-user@ec2-52-56-222-243.eu-west-2.compute.amazonaws.com
52.56.222.243
ip-172-31-24-130.eu-west-2.compute.internal
172.31.24.130

scp -i hdp-exercise.pem hdp-exercise.pem ec2-user@ec2-52-56-220-174.eu-west-2.compute.amazonaws.com:
scp -i hdp-exercise.pem hdp-exercise.pem ec2-user@ec2-52-56-222-243.eu-west-2.compute.amazonaws.com:


sudo -i
wget -nv http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.4.2.0/ambari.repo -O /etc/yum.repos.d/ambari.repo
yum repolist
yum install ambari-server
ambari-server setup
ambari-server start

hive password: hive / hadoop

Issues:
BUG-41308 :
During cluster install, DataNode fails to install with the following error:

resource_management.core.exceptions.
Fail: Execution of '/usr/bin/yum -d 0 -e 0 -y install snappy-devel' returned 1.
Error: Package: snappy-devel-1.0.5-1.el6.x86_64 (HDP-UTILS-1.1.0.20)
           Requires: snappy(x86-64) = 1.0.5-1.el6
           Installed: snappy-1.1.0-3.el7.x86_64 (@anaconda/7.1)
               snappy(x86-64) = 1.1.0-3.el7
           Available: snappy-1.0.5-1.el6.x86_64 (HDP-UTILS-1.1.0.20)
               snappy(x86-64) = 1.0.5-1.el6
Hadoop requires the snappy-devel package that is a lower version that what is on the machine already. Run the following on the host and retry.

yum remove snappy
yum install snappy-devel

#references:
#https://hortonworks.com/blog/deploying-hadoop-cluster-amazon-ec2-hortonworks/
# https://community.hortonworks.com/questions/18428/amazon-aws-ec2-ambari-install-sudo-chkconfig-ntpd.html
#https://dzone.com/articles/how-set-multi-node-hadoop
# https://docs.hortonworks.com/HDPDocuments/Ambari-2.1.0.0/bk_releasenotes_ambari_2.1.0.0/content/ambari_relnotes-2.1.0.0-known-issues.html
