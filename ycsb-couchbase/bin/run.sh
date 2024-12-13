#!/bin/sh
#
SCRIPT_PATH=$(dirname "$0")
SCRIPT_ROOT=$(cd "$SCRIPT_PATH/.." && pwd)
CLASSPATH="${SCRIPT_ROOT}/conf:${SCRIPT_ROOT}/lib/*"
THREADCOUNT_LOAD=8
THREADCOUNT_RUN=8
RECORDCOUNT=500000
OPCOUNT=500000 # number of actual operations happening
RUNTIME=2000
RUN_MODE=0
LOAD_MODE=0
WORKLOAD=""
EXTRAARGS=""

while getopts "w:R:O:G:T:lrMS" opt
do
  case $opt in
    w)
      WORKLOAD=$OPTARG
      ;;
    l)
      LOAD_MODE=1
      ;;
    r)
      RUN_MODE=1
      ;;
    R)
      RECORDCOUNT=$OPTARG
      ;;
    O)
      OPCOUNT=$OPTARG
      ;;
    G)
      THREADCOUNT_LOAD=$OPTARG
      THREADCOUNT_RUN=$OPTARG
      ;;
    T)
      RUNTIME=$OPTARG
      ;;
    M)
      EXTRAARGS="$EXTRAARGS -manual"
      ;;
    S)
      EXTRAARGS="$EXTRAARGS -stats"
      ;;
    \?)
      ;;
    esac
done

if [ -z "$WORKLOAD" ]; then
  for workload in a b c d e f
  do
    if [ -f "${workload}" ]; then
      WORKLOAD_LIST="$WORKLOAD_LIST ${workload}"
    fi
  done
else
  WORKLOAD_LIST="${WORKLOAD}"
fi

for workload in $WORKLOAD_LIST; do
  LOAD_OPTS="-db site.ycsb.db.couchbase3.Couchbase3Client -P $workload -threads $THREADCOUNT_LOAD -p recordcount=$RECORDCOUNT -s -load $EXTRAARGS"
  RUN_OPTS="-db site.ycsb.db.couchbase3.Couchbase3Client -P $workload -threads $THREADCOUNT_RUN -p recordcount=$RECORDCOUNT -p operationcount=$OPCOUNT -p maxexecutiontime=$RUNTIME -s -t $EXTRAARGS"
  [ $RUN_MODE -eq 0 ] && java -cp "$CLASSPATH" site.ycsb.Client $LOAD_OPTS
  [ $LOAD_MODE -eq 0 ] && java -cp "$CLASSPATH" site.ycsb.Client $RUN_OPTS
done
