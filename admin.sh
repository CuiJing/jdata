#!/bin/bash




#############  CONFIG #############

PYTHON27=/usr/local/python2.7/bin/python
PIDFILE=/var/run/jdata.pid
OUTLOG=/var/log/jdata.out.log
ERRLOG=/var/log/jdata.err.log
PORT=18017
MEMCACHED=192.168.9.152:11211

###################################



cd `dirname $0`
basedir=`pwd`

function help(){
 echo
 echo "Usage:"
 echo -e  "\t $0 start|stop|restart|test"
 echo
 exit
 }

function start(){
   $PYTHON27 manage.py runfcgi method=threaded host=127.0.0.1 port=$PORT pidfile=$PIDFILE outlog=$OUTLOG errlog=$ERRLOG
}

function runtest(){
   [ -z $1 ] && port=8080 || port=$1
   $PYTHON27 manage.py runserver 0.0.0.0:$port 
}

function stop(){
   [ -f $PIDFILE ]  && (kill -9 `cat $PIDFILE`;rm -f $PIDFILE) || echo "Jdata is running?"
}


if [ -z $1 ];then
  help
fi

sed -i -e 's/CACHE_BACKEND.*/CACHE_BACKEND = "memcached:\/\/'$MEMCACHED'\/?timeout=3600"/g' settings.py 



case $1 in 
  start)
    start
    ;;
  stop)
    stop
    ;;
  restart)
    stop
    start
    ;;
  test)
    runtest $2
    ;;
  *)
    help
    ;;
esac




