function wait_for_db_to_be_ready_to_serve() {

    echo ""
	echo "Waiting for DB to be ready ... "
    
	lsnrctl status LISTENER | grep 'Instance ".*", status READY' > /dev/null

	status_grep=$?

	while [ $status_grep -ne 0 ]
	do
        
		sleep 5s
        lsnrctl status LISTENER | grep 'Instance ".*", status READY' > /dev/null
        
        status_grep=$?
        
	done

	echo ""
	echo ""

	lsnrctl status LISTENER
	
	echo ""
	echo ""
}

function run_scripts() {

	SCRIPTS_ROOT="$1";
	connectionString=$2

	if [ -z "$SCRIPTS_ROOT" ]; then
	   echo "$0: No SCRIPTS_ROOT passed on, no scripts will be run";
	   exit 1;
	fi;

	if [ -d "$SCRIPTS_ROOT" ] && [ -n "$(ls -A $SCRIPTS_ROOT)" ]; then

	  for f in $SCRIPTS_ROOT/*; do
	      case "$f" in
	          *.sh)     echo "running $f"; . "$f" ;;
	          *.sql)    echo "running $f"; echo "exit" | $ORACLE_HOME/bin/sqlplus -s $connectionString @"$f"; echo ;;
	          *)        echo "ignoring $f" ;;
	      esac
	      echo "";
	  done
	  
	fi;
}

source /home/oracle/setup/dockerInit.sh


if [ ! -f /home/oracle/startup-finished ]; then

	echo ""
	echo ""
	echo ""
	echo "Going to run startup scripts"
	echo ""
	echo ""
	echo ""

	run_scripts /docker-initdb/startup "/ as sysdba"    

	touch /home/oracle/startup-finished
fi

if [ ! -f /home/oracle/setup-finished ]; then

	echo ""
	echo ""
	echo ""
	echo "Going to run setup scripts"
	echo ""
	echo ""
	echo ""

	run_scripts /docker-initdb/setup "${DB_USER}/${DB_PASSWORD}"

	touch /home/oracle/setup-finished
fi

echo "DB setup complete"

wait_for_db_to_be_ready_to_serve

echo "DB is ready to serve"

# open port for checking if DB is up and running
nc -l -k -p 9999

# just need to keep it running
while true; do
	sleep 5m
done;
