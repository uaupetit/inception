#!/bin/sh

echo "creating ${SQL_DATABASE}\n"
mysql="mysql -uroot -hlocalhost"
if [ -d "/var/lib/mysql/${SQL_DATABASE}" ]
then 
    echo "all good"
else
    service mariadb start

    sleep 10

    $mysql <<- EOF
		DELETE FROM mysql.user WHERE user NOT IN ('mariadb.sys', 'root') OR host NOT IN ('localhost') ;
		ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
		GRANT ALL ON *.* TO 'root'@'localhost' WITH GRANT OPTION ;
		DROP DATABASE IF EXISTS test ;
		CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\` ;
		CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}' ;
		GRANT ALL ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%' ;
		FLUSH PRIVILEGES ;
EOF

fi
sleep 5
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown
sleep 5
echo "mariadb is successfully set !"
exec mysqld
