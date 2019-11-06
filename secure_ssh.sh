# xshell  
#! /bin/bash
#The IP that the password of login server is typed wrong 5 times, prohibit login
cat /var/log/secure|awk '/Failed/{print $(NF-3)}'|sort|uniq -c|awk '{print $2"="$1;}' > /var/log/black.txt
for i in `cat  /var/log/black.txt`
do
  IP=`echo $i |awk -F= '{print $1}'`
  NUM=`echo $i|awk -F= '{print $2}'`
   if [ $NUM -gt 5 ];then
      grep $IP /etc/hosts.deny > /dev/null
    if [ $? -gt 0 ];then
      echo "sshd:$IP:deny" >> /etc/hosts.deny
    fi
  fi
done
