#!/bin/bash

# Download and install binaries
wget https://get.enterprisedb.com/postgresql/postgresql-9.3.18-1-linux-x64-binaries.tar.gz
tar zxf postgresql-9.3.18-1-linux-x64-binaries.tar.gz

mv pgsql /opt/local

# Create postgres config scripts to add binaries to path
echo "export POSTGRES_HOME=/opt/local/pgsql" > postgres_conf.sh
echo 'export LD_LIBRARY_PATH=$POSTGRES_HOME/lib' >> postgres_conf.sh
echo 'export PATH=$POSTGRES_HOME/bin:$PATH' >> postgres_conf.sh
echo 'export MANPATH=$POSTGRES_HOME/share/man:$MANPATH' >> postgres_conf.sh
chmod +x postgres_conf.sh
mv postgres_conf.sh /etc/profile.d
source /etc/profile.d/postgres_conf.sh

# Create postgres user
useradd postgres
chown -R postgres /opt/local/pgsql

# Create database and start postgres as postgres user
/bin/su - postgres -c "/opt/local/pgsql/bin/initdb -D /opt/local/pgsql/data"
/bin/su postgres -c 'pg_ctl start -D /opt/local/pgsql/data -l /opt/local/pgsql/serverlog'
