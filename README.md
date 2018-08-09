Ansible Playbooks
-----------

These Ansible playbooks will help in Building Hortonworks clusters (either Hortonworks Data Platform or Hortonworks DataFlow), Cloudera CDH, KAFKA, Cassandra, HBase clusters, Upgrading - Ambari, HDP and HDF, and Adding New Nodes to the Clusters.

#What my Scripts Do
This script will apply the required playbooks in one run with the tags specified

- Setup Password less SSH: `setup-ssh.sh`
- Prepare New nodes: `prepare-new-nodes.sh`
- Install HDP: `install-hdp.sh`
- Install HDF: `install-hdf.sh`
- Install CDH: `install-cdh.sh`
- Upgrade Ambari: `upgrade-ambari.sh`
- Upgrade HDP: `upgrade-hdp.sh`
- Upgrade HDF: `upgrade-hdf.sh`
- Upgrade ClouderaManager: `upgrade-cm.sh`
- Upgrade CDH: `upgrade-cdh.sh`

#remove special chars
sed -i 's/\r//' bootstrap.sh
## [Requirements](id:requirements)

- Ansible >= 2.2.1, < 2.4.0

- Expects CentOS/RHEL 6/7


## [Details](id:details)

#Java archive and JCE- Downlaod from here - might need an account - update the URL if needed
http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html

http://www.oracle.com/technetwork/java/javase/downloads/java-archive-javase8-2177648.html

#JDK8_162
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u162-b12/0da788060d494f5095bf8624735fa2f1/jdk-8u162-linux-x64.tar.gz -O jdk-8u162-linux-x64.tar.gz

wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn/java/jdk/8u112-b15/jdk-8u112-linux-x64.tar.gz?AuthParam=1516813176_6fe4cad8add790de99927e89082e80f3 -O jdk-8u112-linux-x64.tar.gz

wget http://download.oracle.com/otn-pub/java/jce/8/jce_policy-8.zip?AuthParam=1516812837_0db4d8ff86dff16b6588d754fdc84d45 -O jce_policy-8.zip



#Local Repositories
http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.6.1.0/ambari-2.6.1.0-centos7.tar.gz
https://docs.hortonworks.com/HDPDocuments/Ambari-2.6.1.0/bk_ambari-installation/content/hdp_26_repositories.html

https://docs.hortonworks.com/HDPDocuments/HDF3/HDF-3.0.2/bk_release-notes/content/ch_hdf_relnotes.html

nohup wget https://s3.amazonaws.com/public-repo-1.hortonworks.com/HDF/centos7/3.x/updates/3.0.2.0/HDF-3.0.2.0-centos7-rpm.tar.gz &
nohup wget http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.6.0.0/ambari-2.6.0.0-centos7.tar.gz &
nohup wget http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.6.3.0/HDP-2.6.3.0-centos7-rpm.tar.gz &
nohup wget http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.21/repos/centos7/HDP-UTILS-1.1.0.21-centos7.tar.gz &
nohup wget https://s3.amazonaws.com/public-repo-1.hortonworks.com/HDF/centos7/3.x/updates/3.0.2.0/tars/hdf_ambari_mp/hdf-ambari-mpack-3.0.2.0-76.tar.gz &

Repos urls: 
Ambari : 2.6.0 
http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.6.0.0/ambari.repo 

HDP : 2.6.3	
http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.6.3.0/hdp.repo 

HDP-Utils : 1.1.0.21 
http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.21/repos/centos7/HDP-UTILS-1.1.0.21-centos7.tar.gz 

HDF	: 3.0.2 
https://s3.amazonaws.com/public-repo-1.hortonworks.com/HDF/centos7/3.x/updates/3.0.2.0/hdf.repo 


#Database Repo URLS

#Oracle OJDBC Driver
http://www.oracle.com/technetwork/database/features/jdbc/index-091264.html

For Oracle Database 11g: select Oracle Database 11g Release 2 drivers > ojdbc6.jar.
For Oracle Database 12c: select Oracle Database 12c Release 1 driver > ojdbc7.jar.

Copy the .jar file to the Java share directory. For example:
mkdir -p /usr/share/java/
cp ojdbc7.jar /usr/share/java/
Make sure the .jar file has the appropriate permissions. For example:
chmod 644 /usr/share/java/ojdbc7.jar
ambari-server setup --jdbc-db=oracle --jdbc-driver=/usr/share/java/ojdbc7.jar

#sqlplus
http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html
http://download.oracle.com/otn/linux/instantclient/122010/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip

wget http://download.oracle.com/otn/linux/instantclient/122010/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip?AuthParam=1517613160_65665f4c35d539a20f31eaf81806d871 -O instantclient-sqlplus-linux.x64-12.2.0.1.0.zip

unzip instantclient-sqlplus-linux.x64-12.2.0.1.0.zip

sqlplus <AMBARIUSER>/<AMBARIPASSWORD> < Ambari-DDL-Oracle-CREATE.sql

ambari-server setup -s 
--database=embedded|oracle|mysql|postgres
--databasehost=Hostname of database server
--databaseport=Database port
--databasename=Database/Schema/Service name or ServiceID
--databaseusername=Database user login
--databasepassword=Database user password



#ll /var/lib/ambari-server/resources/
-rwxr-xr-x  1 root root     80019 Apr  2  2017 Ambari-DDL-MySQL-CREATE.sql
-rwxr-xr-x  1 root root      1192 Apr  2  2017 Ambari-DDL-MySQL-DROP.sql
-rwxr-xr-x  1 root root     85439 Apr  2  2017 Ambari-DDL-Oracle-CREATE.sql
-rwxr-xr-x  1 root root      2160 Apr  2  2017 Ambari-DDL-Oracle-DROP.sql



#SSL
copy all certs to rolesprepare-ssl-encryption/files



#sysctl.conf - final:
vm.swapiness = 1
net.ipv6.conf.all.disable_ipv6=1
net.ipv6.conf.default.disable_ipv6=1
vm.dirty_background_ratio = 5
net.core.wmem_default = 212992
net.core.rmem_default = 212992
net.core.wmem_max = 2097152
net.core.rmem_max = 2097152
net.ipv4.tcp_wmem = 4096 65536 4194304
net.ipv4.tcp_rmem = 4096 87380 6291456
net.ipv4.tcp_window_scaling = 1
net.ipv4.tcp_max_syn = 2048
net.core.netdev_max_backlog = 2000  

#Generate ansible inventory
for i in `cat inv-file`; do host $i | awk '{print $1" ansible_host="$4" node_fqdn="$1}'; done

#install MPack
sudo service ambari-server stop
sudo ambari-server install-mpack --mpack=/bigdata/installers/hdf-ambari-mpack-3.0.2.0-76.tar.gz --purge --verbose
<!-- Are you absolutely sure you want to perform the purge [yes/no]? (no)yes -->
sudo service ambari-server start

#Drivers
cd /bigdata/installers
sudo mkdir -p /usr/share/java/
sudo chmod -R 755 /usr/share/java/
sudo cp ojdbc7.jar /usr/share/java/
sudo chmod -R 755 /usr/share/java/
sudo cp mysql-connector-java-5.1.45-bin.jar /usr/share/java/
sudo ln -s /usr/share/java/mysql-connector-java-5.1.45-bin.jar /usr/share/java/mysql-connector-java.jar
sudo chmod 755 /usr/share/java/mysql-connector-java-5.1.45-bin.jar
