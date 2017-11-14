
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

echo ""
echo ""
echo ""
echo "Going to run startup scripts"
echo ""
echo ""
echo ""

run_scripts /docker-initdb/startup "/ as sysdba"

echo ""
echo ""
echo ""
echo "Going to run setup scripts"
echo ""
echo ""
echo ""

run_scripts /docker-initdb/setup "${DB_USER}/${DB_PASSWORD}"


echo "DB setup complete."

# open port for checking if DB is up and running
nc -l -k -p 9999

# just need to keep it running
while true; do
	sleep 1m
done;
