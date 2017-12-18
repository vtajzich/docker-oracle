# Oracle in Docker container

## Support for startup and setup scripts

This image is has entry points for startup and setup scripts. 

* Startup scripts are run as sysdba
* Setup scripts are run using specified user (env variable DB_USER and DB_PASSWORD)

To run startup and setup scripts copy then to locations:

```
/docker-initdb/startup
```

and 

```
/docker-initdb/setup
```

or mount these locations.

## How to wait for DB to be ready

The initialization of Oracle DB can take a while. When startup and setup scripts are processed then start.sh script waits 
for DB to be ready to serve (accept incoming connections and process queries).

When DB is ready to serve then port _9999_ is opened.

## How to check if port is open?

Best option to wait for port to be open is following script

```
https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh
```

Usage to wait for port "9999" on host "oracle-db":

```
/opt/wait/wait-for-it.sh -h oracle-db -p 9999 -t 0
```



# Apendix

Details about oracle docker image: 

https://store.docker.com/images/oracle-database-enterprise-edition/plans/08cf8677-bb8f-453c-b667-6b0c24a388d4?tab=instructions