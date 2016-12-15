#!/bin/bash
args=("$@");

if [ "${args[0]}" ]; then
	case "${args[0]}" in
	    'count')
			echo "7"
            exit 1
            ;;

        '1')
            printf "Step ${args[0]} - Downloading latest updates \r\n";
            wget -q https://github.com/3RaGaming/Web_Control/archive/dev-bot-manage.zip -O /tmp/dev-bot-manage.zip
            printf "\r\n-----------\r\n\r\n";
            ;;

        '2')
            printf "Step ${args[0]} - Unzipping updates \r\n";
            unzip -u /tmp/dev-bot-manage.zip -d /tmp/
            printf "\r\n-----------\r\n\r\n";
            ;;

        '3')
            printf "Step ${args[0]} - Updating files \r\n";
            rsync -a -v /tmp/Web_Control-dev-bot-manage/html/* ./
            rsync -a -v /tmp/Web_Control-dev-bot-manage/factorio/manage.c /var/www/factorio/
            rsync -a -v /tmp/Web_Control-dev-bot-manage/factorio/manage.new.sh /var/www/factorio/
            rsync -a -v /tmp/Web_Control-dev-bot-manage/factorio/3RaFactorioBot.js /var/www/factorio/
            printf "\r\n-----------\r\n\r\n";
            ;;
	    
        '4')
            printf "Step ${args[0]} - Compiling updated manage.c \r\n";
            gcc -o /var/www/factorio/managepgm -pthread /var/www/factorio/manage.c
            printf "\r\n-----------\r\n\r\n";
            ;;

        '5')
            printf "Step ${args[0]} - Deleting temporary files \r\n";
            rm -Rf /tmp/dev-bot-manage.zip /tmp/Web_Control-dev-bot-manage/
            printf "\r\n-----------\r\n\r\n";
            ;;
	    
	'6')
	    #Temporary, having to kill ghost processes while Stud is gone
	    printf "Killing ghost processes\r\n"
	    sudo kill -SIGKILL 14714 19056 19458 29257 19012 13710 14619 19014
	    ;;
	    
	'7')
	    printf "Insuring ghost processes are gone\r\n"
	    ps -u www-data -o comm,pid,args
	    ;;

        *)
            printf "Error in input provided\r\n"
            exit 1
	esac
else
    printf "No input provided\r\n"
fi

