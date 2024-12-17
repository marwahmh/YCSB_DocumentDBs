# YCSB_DocumentDBs

## YCSB on CouchDB

Couchdb binding is buit on https://github.com/arnaudsjs/YCSB-couchdb-binding?tab=readme-ov-file to support the latest version.

### To run on CouchDB,

1. Install couchdb from their website https://couchdb.apache.org/ , and create the admin with username='Admin' and password='password', and then run this if you would like to run a specific workload

2. setup maven:
   
curl -O https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz

tar -xvzf apache-maven-3.6.3-bin.tar.gz

sudo mv apache-maven-3.6.3 /usr/local/apache-maven-3.6.3

export M2_HOME=/usr/local/apache-maven-3.6.3

export PATH=$M2_HOME/bin:$PATH

source ~/.zshrc  # For Zsh users

mvn -version 

cd YCSB-couchdb

mvn clean package -DskipTests -X -Dcheckstyle.skip


3. Run benchmark
   
to load data: 

./bin/ycsb load couchdb -P workloads/workloada -p hosts="127.0.0.1" -p url="http://Admin:password@127.0.0.1:5984" -p recordcount=10000 -p threadcount=1 -s > LA1.txt


to run test: 

./bin/ycsb run couchdb -P workloads/workloada -p hosts="127.0.0.1" -p url="http://Admin:password@127.0.0.1:5984" -p recordcount=10000 -p threadcount=1 -p operationcount=10000 -s > LA1.txt


• -P workloads/workloada: Specifies the workload configuration file. 

• -p hosts: Host address for CouchDB.

• -p url: URL with admin credentials for CouchDB.

• -p recordcount: Number of records to load.

• -p threadcount: Number of threads to use.

• -s > LA1.txt: Outputs results to LA1.txt.


Alternatively, you can use our runMult.sh script to run multiple workloads.

## YCSB on CouchBase

1. Install the Couchbase server from the official website https://www.couchbase.com/downloads/?family=couchbase-server

2. cd ycsb-couchbase 

3. run 'mvn clean package'

4. to run a specific workload, run the following command 

bin/run.sh -w workloads/workloada -R $record_count -O $record_count -G $thread_count 

• -O : Number of Operations.

• -R : Number of records.

• -G threadcount: Number of threads to use.

5. Alternatively, you can use our runMult.sh script to run several workloads.


## Running our queries

We used dataset available here https://www.kaggle.com/datasets/promptcloud/travel-hotel-listing-from-bookingcom-2020?resource=download

1. For couchbase, load data in booking_final.json from the UI to a new DB. Get json lines data from here: https://drive.google.com/file/d/1CToVRyAItkVLivj-gwXn0wocmN4_vSMQ/view?usp=drive_link

3. For couchdab , get the file booking_final_transformed_data.json here: https://drive.google.com/file/d/1U_--1PZu2FPmx8fHhoP_Cd10kEx-GuSa/view?usp=sharing , and then do this:

  jq -c '.docs[]' booking_final_transformed_data.json | while read doc; do
  curl -X POST http://Admin:password@127.0.0.1:5984/booking \
    -H "Content-Type: application/json" \
    -d "$doc"

3. Run the queries as specified in the queries document. 
