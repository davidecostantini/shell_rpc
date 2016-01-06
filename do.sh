#!/bin/sh
echo "Starting `date -u`"
cat hosts_list.txt | while read l
do
    IFS=':' read -a arr <<< "${l}"
    host=${arr[0]}
    port=${arr[1]}
    user=${arr[2]}
    key=${arr[3]}


    #Check comments
    if [ "${l:0:1}" == "#" ];then
        continue
    fi


    if [ ! -f command.sh ]; then
        echo "Script command.sh not found!"
        exit 1
    fi

    #check user
    if [ "$user" == "" ]; then
       user="root"
    fi

    #check user
    if [ "$port" == "" ]; then
       port=22
    fi


    echo "Storing KEY for host $host"

    ssh-keyscan -p $port -H $host >> ~/.ssh/known_hosts

    echo "Running command on host ${host} using port ${port} and user ${user}"

    if [ "$key" != "" ];then
        echo "Using key: $key"
        ssh -T -i $key -p $port $user@$host < command.sh &> log_$host #&
    else
        ssh -T -p $port $user@$host < command.sh &> log_$host #&
    fi

    echo "---------------------------------------------"

done
echo "Completed - `date -u`"

