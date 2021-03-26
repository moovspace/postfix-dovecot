# Postfix dovecot mysql smtp
Postfix dovecot mail server mailbox aliases in mysql database. Smtp server virtual aliases in mysql, mariadb database.

# Postfix

### Postfix, dovecot install
```
sudo apt install postfix dovecot-core dovecot-imapd dovecot-pop3d dovecot-lmtpd mysql-server
sudo apt install dovecot-mysql postfix-mysql
```

### User
```
groupadd -g 5000 vmail
useradd -g vmail -u 5000 vmail -d /var/mail

# mail folder !!!
chown -R root:vmail /var/mail
chmod -R 770 /var/mail
```

# Mysql server

### Mysql root user
```
# root user password
sudo mysqladmin -uroot password "toor"

# or
sudo mysql

SET PASSWORD FOR 'root'@'localhost' = PASSWORD('toor');
SET PASSWORD FOR 'root'@'127.0.0.1' = PASSWORD('toor');
FLUSH PRIVILEGES;
```

### Mysql mailuser and db
```
sudo mysqladmin -p create mailserver

sudo mysql -p mailserver

GRANT SELECT ON mailserver.* TO 'mailuser'@'127.0.0.1' IDENTIFIED BY 'mailuserpass';
FLUSH PRIVILEGES;
```

### Mysql import
```
sudo mysql -uroot -p < sql/mailserver.sql

sudo service mysql restart
```

# Dovecot settings see
https://www.siemaszko.info/serwer-email-z-postfix-dovecot-na-bazie-mysql-debian-lub-ubuntu/

### Dovectot permissions
```
# dovecot
chown -R vmail:dovecot /etc/dovecot
chmod -R o-rwx /etc/dovecot
```

# Errors

### If errors install
```
sudo apt install dovecot-mysql postfix-mysql
```

### Postfix dynamic maps configuration file debian 10 (error was here)
/etc/postfix/dynamicmaps.cf
```
tcp /usr/lib/postfix/dict_tcp.so            dict_tcp_open
mysql   /usr/lib/postfix/postfix-mysql.so   dict_mysql_open 
#mysql  /usr/lib/postfix/dict_mysql.so      dict_mysql_open 
# sqlite  /usr/lib/postfix/dict_sqlite.so   dict_sqlite_open    
```

### Email dir
```
# mail folder !!!
chown -R root:vmail /var/mail
chmod -R 770 /var/mail
```

### Logs
```
cat /var/log/mail.log

tail -f /var/log/mail.log
```

# Restart
```
sudo service postfix restart
sudo service dovecot restart
sudo service mysql restart
```

### Send local email
```
sudo apt install mailutils

echo "hello message" | mail -s "test message subject" email1@example.com
```

# References
- https://www.siemaszko.info/serwer-email-z-postfix-dovecot-na-bazie-mysql-debian-lub-ubuntu/
- https://serverfault.com/questions/861050/postfix-unsupported-dictionary-type-mysql
