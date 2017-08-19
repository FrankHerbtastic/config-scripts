#!/bin/bash
INSTALL_DIR=/opt/local
GIT_DIR=$INSTALL_DIR/git

if [ ! -d "$INSTALL_DIR" -o ! -d "$GIT_DIR" ]; then
    # Control will enter here if $DIRECTORY exists.
    mkdir -p $GIT_DIR
fi

cd $GIT_DIR
git clone https://github.com/open-mbee/mms
cd $GIT_DIR/mms/mms-ent

# Configure and copy properties file
mv ./mms.properties.example ./mms.properties

sed -i 's/POSTGRESDBNAME/mms/' mms.properties
sed -i 's/POSTGRESUSERNAME/mmsuser/' mms.properties
sed -i 's/POSTGRESPASSWORD/test123/' mms.properties

cp ./mms.properties /opt/local/alfresco-5.0.d/tomcat/shared/classes

# Build the repo
mvn package

# Find the amps and move them
find . -name '*.amp' -exec mv {} $INSTALL_DIR/alfresco-5.0.d/tomcat/webapps\;

cd $INSTALL_DIR/alfresco-5.0.d/

# First remove the current alfresco directories
rm -rf $INSTALL_DIR/alfresco-5.0.d/tomcat/webapps/alfresco
rm -rf $INSTALL_DIR/alfresco-5.0.d/tomcat/webapps/share

mkdir $INSTALL_DIR/alfresco-5.0.d/tomcat/webapps/alfresco
mkdir $INSTALL_DIR/alfresco-5.0.d/tomcat/webapps/share

# Install the amps
cd $INSTALL_DIR/alfresco-5.0.d/tomcat/webapps/alfresco
java -jar $INSTALL_DIR/alfresco-5.0.d/bin/alfresco-mmt.jar install $INSTALL_DIR/alfresco-5.0.d/tomcat/webapps/mms-amp.amp $INSTALL_DIR/alfresco-5.0.d/tomcat/webapps/alfresco.war -force
jar xvf ../alfresco.war

cd $INSTALL_DIR/alfresco-5.0.d/tomcat/webapps/share
java -jar $INSTALL_DIR/alfresco-5.0.d/bin/alfresco-mmt.jar install $INSTALL_DIR/alfresco-5.0.d/tomcat/webapps/mms-share-amp.amp
jar xvf ../share.war

# Install the MMS Webapp
cd $GIT_DIR
git clone https://github.com/Open-MBEE/mvn-repo/tree/release/d-0
unzip mvn-repo/evm-3.0.0.zip

mv mvn-repo/build $INSTALL_DIR/alfresco-5.0.d/tomcat/webapps/alfresco/mmsapp
