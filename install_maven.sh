#!/bin/bash

wget http://mirror.cogentco.com/pub/apache/maven/maven-3/3.5.0/binaries/apache-maven-3.5.0-bin.tar.gz

tar zxf apache-maven-3.5.0-bin.tar.gz
mv apache-maven-3.5.0 /usr/local
ln -s /usr/local/apache-maven-3.5.0 /usr/local/maven

echo 'export M2_HOME=/usr/local/maven' > maven.sh
echo 'export PATH=${M2_HOME}/bin:${PATH}' >> maven.sh
chmod +x maven.sh

mv maven.sh /etc/profile.d
source /etc/profile.d/maven.sh

source /etc/init.d/maven.sh
