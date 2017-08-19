#!/bin/bash

if [ -d "/opt/local" ]; then
    # Control will enter here if $DIRECTORY exists.
    mkdir -p /opt/local
fi

echo "export JAVA_HOME=/opt/local/java" > java.sh
echo 'export PATH=$PATH:$JAVA_HOME/bin' >> java.sh

chmod +x java.sh
mv java.sh /etc/profile.d/java.sh
source /etc/profile.d/java.sh

wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz

tar zxf jdk-8u131-linux-x64.tar.gz

mv jdk1.8.0_131 /opt/local

ln -s /opt/local/jdk1.8.0_131 /opt/local/java

source /etc/init.d/java.sh