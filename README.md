# YCSB_DocumentDBs

### To run,

curl -O https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz

tar -xvzf apache-maven-3.6.3-bin.tar.gz

sudo mv apache-maven-3.6.3 /usr/local/apache-maven-3.6.3

export M2_HOME=/usr/local/apache-maven-3.6.3

export PATH=$M2_HOME/bin:$PATH

source ~/.zshrc  # For Zsh users

mvn -version 


mvn clean package -DskipTests -X -Dcheckstyle.skip


### Install couchdb from their website, and create the admin with username='Admin' and password='password', and then run this

YCSB/bin/ycsb load couchdb -P workloads/workloada -p hosts="127.0.0.1" -p url="http://Admin:password@127.0.0.1:5984" -p recordcount=10000 -p threadcount=1 -s > LA1.txt
