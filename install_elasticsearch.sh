#!/bin/bash
INSTALL_DIR=/opt/local

# Download and install ElasticSearch binaries
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.4.0.tar.gz
tar zxf elasticsearch-5.4.0.tar.gz
mv elasticsearch-5.4.0 $INSTALL_DIR/
ln -s $INSTALL_DIR/elasticsearch-5.4.0 $INSTALL_DIR/elasticsearch

# Create elastic config script
echo "export ES_HOME=$INSTALL_DIR/elasticsearch" > elasticsearch_conf.sh
echo 'export PATH=${ES_HOME}/bin:$PATH' >> elasticsearch_conf.sh
chmod +x elasticsearch_conf.sh
mv elasticsearch_conf.sh /etc/profile.d
source /etc/profile.d/elasticsearch_conf.sh 

# Create ElasticSearch user since it
useradd esadmin
chown -R esadmin $INSTALL_DIR/elasticsearch-5.4.0
