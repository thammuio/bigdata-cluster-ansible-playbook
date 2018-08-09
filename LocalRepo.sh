#Create Local Repo
#sed -i 's/\r//' filename
nohup wget https://s3.amazonaws.com/public-repo-1.hortonworks.com/HDF/centos7/3.x/updates/3.0.2.0/HDF-3.0.2.0-centos7-rpm.tar.gz &
nohup wget http://public-repo-1.hortonworks.com/ambari/centos7/2.x/updates/2.6.0.0/ambari-2.6.0.0-centos7.tar.gz &
nohup wget http://public-repo-1.hortonworks.com/HDP/centos7/2.x/updates/2.6.3.0/HDP-2.6.3.0-centos7-rpm.tar.gz &
nohup wget http://public-repo-1.hortonworks.com/HDP-UTILS-1.1.0.21/repos/centos7/HDP-UTILS-1.1.0.21-centos7.tar.gz &
nohup wget https://s3.amazonaws.com/public-repo-1.hortonworks.com/HDF/centos7/3.x/updates/3.0.2.0/tars/hdf_ambari_mp/hdf-ambari-mpack-3.0.2.0-76.tar.gz &


nohup tar -zxvf ambari-2.6.0.0-centos7.tar.gz &
nohup tar -zxvf HDF-3.0.2.0-centos7-rpm.tar.gz &
nohup tar -zxvf HDP-2.6.3.0-centos7-rpm.tar.gz &
mkdir -p HDP-UTILS/1.1.0.22
nohup tar -zxvf HDP-UTILS-1.1.0.21-centos7.tar.gz -C HDP-UTILS/1.1.0.22 &


sudo mkdir -p /hadoop/installers/el7-rpms/ambari/
sudo mkdir -p /hadoop/installers/el7-rpms/HDP/
sudo mkdir -p /hadoop/installers/el7-rpms/HDP-UTILS/
sudo mkdir -p /hadoop/installers/el7-rpms/HDF/


mv ambari/centos7/2.6.0.0-267 el7-rpms/ambari/
mv HDP/centos7/2.6.3.0-235 el7-rpms/HDP/
mv HDF/centos7/3.0.2.0-76 el7-rpms/HDF/
mv HDP-UTILS/1.1.0.21 el7-rpms/HDP-UTILS/


createrepo el7-rpms/ambari/2.6.0.0-267/
createrepo el7-rpms/HDP/2.6.3.0-235/
createrepo el7-rpms/HDF/3.0.2.0-76/
createrepo el7-rpms/HDP-UTILS/1.1.0.21/

mkdir -p /var/www/html

sudo ln -s rpms /var/www/html/rpms


nohup python -m SimpleHTTPServer 9007 &