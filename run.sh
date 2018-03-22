#!/bin/sh
## env
export  JENKINS_HOME=/root/jwork

##变量
CMD="java -jar jenkins.war --httpPort=82"

case "$1" in

    start)
        ##nohup &  以守护进程启动
        nohup $CMD >/dev/null 2>&1 &
        echo "=== start $CMD"
        ;;
    stop)
        ##
        P_ID=`ps -ef | grep -w "$CMD" | grep -v "grep" | awk '{print $2}'`
        if [ "$P_ID" == "" ]; then
            echo "=== $CMD process not exists or stop success"
        else
            echo "=== $CMD process pid is:$P_ID"
            echo "=== begin kill $CMD process, pid is:$P_ID"
            kill -9 $P_ID
        fi
        ;;

    restart)
        $0 stop
        sleep 2
        $0 start
        echo "=== restart $CMD"
        ;;

    *)
        ## restart
        $0 stop
        sleep 2
        $0 start
        ;;
esac
exit 0
