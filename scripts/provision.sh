#!/usr/bin/env bash

apt-get -y autoremove

apt-get install -y curl
echo "deb http://apt.nuxeo.org/ trusty releases" > /etc/apt/sources.list.d/nuxeo.list
curl http://apt.nuxeo.org/nuxeo.key | apt-key add -

apt-get update

apt-get install -y \
    unzip python python-requests python-lxml \
    imagemagick ufraw ffmpeg2theora ffmpeg-nuxeo \
    poppler-utils exiftool libwpd-tools \
    openjdk-7-jdk libreoffice redis-tools \
    postgresql-client screen \
    apache2 curl git

# Oracle JDK
mkdir -p /usr/lib/jvm && \
	curl -o/tmp/jdk-8-linux-x64.tgz -L --insecure --header 'Cookie: oraclelicense=accept-securebackup-cookie' 'http://download.oracle.com/otn-pub/java/jdk/8u40-b26/jdk-8u40-linux-x64.tar.gz' && \
    tar xzf /tmp/jdk-8-linux-x64.tgz -C /usr/lib/jvm && \
    #tar xzf /vagrant/packages/jdk-8-linux-x64.tgz -C /usr/lib/jvm && \
	ln -s /usr/lib/jvm/jdk1.8.0_40 /usr/lib/jvm/java-8 && \
    update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-8/jre/bin/java 1081 && \
    update-alternatives --set java /usr/lib/jvm/java-8/jre/bin/java

# Fake SMTP 
mkdir /tmp/fakesmtp && \
    unzip -q -d /tmp/fakesmtp /vagrant/packages/fakeSMTP-latest.zip && \
    mv /tmp/fakesmtp/$(/bin/ls -1 /tmp/fakesmtp) /usr/lib/fakeSMTP.jar && \
    rm -rf /tmp/fakesmtp
screen -d -m -S smtp java -jar /usr/lib/fakeSMTP.jar --start-server --background

# configuration Apache2
a2enmod proxy proxy_http proxy_balancer lbmethod_byrequests headers
printf "\nServerName localhost\n" >> /etc/apache2/apache2.conf
rm -f /etc/apache2/sites-enabled/*
cp /vagrant/config/apache/proxy.conf /etc/apache2/sites-available/proxy.conf
a2ensite proxy.conf
service apache2 restart

# configuration Postgres
#apt-get install -y postgresql-9.3
# su postgres pg_ctl -D "nuxeo" \
# 	-o "-c listen_addresses='*'" \
# 	-w start
# pgconf=/etc/postgresql/9.5/nuxeo/postgresql.conf
# #perl -p -i -e "s/^#?shared_buffers\s*=.*$/shared_buffers = 100MB/" $pgconf
# #perl -p -i -e "s/^#?effective_cache_size\s*=.*$/effective_cache_size = 1GB/" $pgconf
# perl -p -i -e "s/^#?work_mem\s*=.*$/work_mem = 32MB/" $pgconf
# perl -p -i -e "s/^#?wal_buffers\s*=.*$/wal_buffers = 8MB/" $pgconf
# perl -p -i -e "s/^#?lc_messages\s*=.*$/lc_messages = 'en_US.UTF-8'/" $pgconf
# perl -p -i -e "s/^#?lc_time\s*=.*$/lc_time = 'en_US.UTF-8'/" $pgconf
# perl -p -i -e "s/^#?log_line_prefix\s*=.*$/log_line_prefix = '%t [%p]: [%l-1] '/" $pgconf

# psql -u root < /vagrant/scripts/init-db.sql
# service postgresql restart

# REDIS
# cd /tmp
# tar xzf /vagrant/packages/redis-3.0.7.tar.gz
# cd redis-3.0.7
# make && make install
# cp utils/redis_init_script /etc/init.d/redis_6379
# cp redis.conf /etc/redis/6379.conf
# update-rc.d redis_6379 defaults
# /etc/init.d/redis_6379 start

# Elasticsearch
# dpkg -i /vagrant/packages/elasticsearch-1.7.5.deb
# cluster.name: elasticsearch
# esconf=/etc/elasticsearch/elasticsearch.yml
# perl -p -i -e "s/^#?cluster.name\s*:.*$/cluster.name: nuxeo/" $esconf

# service elasticsearch restart


# configuration Nuxeo 
useradd -u 1005 -d /opt/nuxeo -m -s /bin/bash nuxeo
cd /opt/nuxeo
wget https://cdn.nuxeo.com/nuxeo-10.10/nuxeo-server-10.10-tomcat.zip

mkdir deploytmp
pushd deploytmp
unzip -q /opt/nuxeo/nuxeo-server-10.10-tomcat.zip
dist=$(/bin/ls -1 | head -n 1)
mv $dist ../
popd
rm -rf deploytmp
ln -s $dist server
chmod +x server/bin/nuxeoctl

# wizard
echo "nuxeo.wizard.done=true" >> server/bin/nuxeo.conf

server/bin/nuxeoctl mp-init
server/bin/nuxeoctl mp-install --accept=true --relax=false nuxeo-jsf-ui
server/bin/nuxeoctl mp-install --accept=true --relax=false nuxeo-dam
server/bin/nuxeoctl mp-install --accept=true --relax=false nuxeo-drive
server/bin/nuxeoctl mp-install --accept=true --relax=false nuxeo-diff

chown -R nuxeo:nuxeo /opt/nuxeo

## config ES, BDD, REDIS
# TODO
# nxconf=/opt/nuxeo/server/bin/nuxeo.conf

# nuxeo.db.name=nuxeo
# nuxeo.db.user=nuxeo
# nuxeo.db.password=nuxeo
# nuxeo.db.host=localhost
# nuxeo.db.port=5432

# nuxeo.redis.enabled=true
# nuxeo.redis.host=localhost

# elasticsearch.enabled=true
# elasticsearch.addressList=localhost:9300
# elasticsearch.clusterName=nuxeo

cp /vagrant/config/nuxeo/nuxeo /etc/init.d/nuxeo
chmod +x /etc/init.d/nuxeo
update-rc.d nuxeo defaults
service nuxeo start



# outils de development
apt-get install -y git

mkdir -p /usr/local/apache-maven
cd /usr/local/apache-maven
tar -xzvf /vagrant/packages/apache-maven-3.1.1-bin.tar.gz
echo "export M2_HOME=/usr/local/apache-maven/apache-maven-3.1.1" >> /etc/profile
source /etc/profile
echo "export M2=$M2_HOME/bin" >> /etc/profile
echo "export MAVEN_OPTS=\"-Xms256m -Xmx512m\"" >> /etc/profile
source /etc/profile
echo "export PATH=$M2:$PATH" >> /etc/profile
echo "export JAVA_HOME=/usr/lib/jvm/java-8" >> /etc/profile
source /etc/profile

cd 
apt install nodejs

apt install npm

npm install -g yo

npm install -g yo nuxeo/generator-nuxeo


