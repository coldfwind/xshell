#!/bin/bash
#service mongod status
stop_mongod () 
{
        kill -9 `pgrep mongod`
            [ $? -eq 0 ] && echo "service stop succed" || echo "service stop failed. please check!!!"
        sleep 2
    Mongodb=$(ps -ef | grep "$1" | grep -v grep |grep -w "mongod")
        if [ -z "$Mongodb" ];then
            echo -e "MongoDB: \033[1;31m mode \033[0m"
        else
            echo -e "MongoDB: \033[1;32m running \033[0m"
        fi

}
start_mongod () 
{
    cd /opt/mongo/bin;
        nohup ./mongod --dbpath=/mnt/db_prod --port 27017 --logpath="/mnt/log/mongodb_$(date +%Y%m%d%H%M%S)" --wiredTigerCacheSizeGB 6 2>&1 &
            [ $? -eq 0 ] && echo "service start succed" || echo "service start failed. please check!!!"
    Mongodb=$(ps -ef | grep "$1" | grep -v grep |grep -w "mongod")
        if [ -z "$Mongodb" ];then
            echo -e "MongoDB: \033[1;31m mode \033[0m"
        else
            echo -e "MongoDB: \033[1;32m running \033[0m"
        fi
}
status_mongod () 
{
    Mongodb=$(ps -ef | grep "$1" | grep -v grep |grep -w "mongod")
        if [ -z "$Mongodb" ];then
            echo -e "MongoDB: \033[1;31m mode \033[0m"
        else
            echo -e "MongoDB: \033[1;32m running \033[0m"
        fi
}
case $1 in
    start)
        start_mongod
        ;;
    stop)
        stop_mongod
        ;;
    status)
        status_mongod
        ;;
    restart)
        stop_mongod
        start_mongod
        ;;
    *)
        echo "./mongo stop|start|status|restart"
        ;;
esac
