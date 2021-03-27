# Postfix dovecot mysql smtp
Postfix dovecot mail server mailbox aliases in mysql database. Smtp server virtual aliases in mysql, mariadb database.

# Postfix

### Postfix, dovecot install
```
sudo apt install postfix dovecot-core dovecot-imapd dovecot-pop3d dovecot-lmtpd mariadb-server
sudo apt install postfix-mysql dovecot-mysql
```

### Unpack to dir
Extract to /
```
mkdir -p /home/username/sample
tar -xzf postfix-dovecot.tar.gz -C /home/username/sample --same-owner
```

### User
```
sudo groupadd -g 5000 vmail
sudo useradd -g vmail -u 5000 vmail -d /var/mail

# Mail folder
sudo chown -R root:vmail /var/mail
sudo chmod -R 770 /var/mail

sudo chown -R vmail:vmail /home/maile
sudo chmod -R 770 /home/maile

sudo chown -R postfix:root /var/spool/postfix/private
sudo chmod -R 770 /var/spool/postfix/private

sudo chown -R root:root /etc/postfix
sudo chmod -R 750 /etc/postfix

sudo chown -R vmail:dovecot /etc/dovecot
sudo chmod -R 760 /etc/dovecot
```

# Mysql server

### Mysql root user password
```
# root user password
sudo mysqladmin -uroot password "toor"

# login
sudo mysql -u root -p
```

### Secure mysql server
```bash
# Change root user
GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY 'toor' WITH GRANT OPTION
GRANT ALL ON *.* TO 'root'@'127.0.0.1' IDENTIFIED BY 'toor' WITH GRANT OPTION

# Mysql_secure_installation
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')
DELETE FROM mysql.user WHERE User=''
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%'

# Reload
FLUSH PRIVILEGES
```

### Mysql mailuser and db
```
# Create db
sudo mysqladmin -u root -p create mailserver

# Login to
sudo mysql -u root -p mailserver

# Create mailuser
GRANT SELECT ON mailserver.* TO 'mailuser'@'localhost' IDENTIFIED BY 'mailuserpass';
GRANT SELECT ON mailserver.* TO 'mailuser'@'127.0.0.1' IDENTIFIED BY 'mailuserpass';
FLUSH PRIVILEGES;
```

### Mysql import
```
sudo mysql -u root -p < sql/mailserver.sql
sudo service mysql restart
```

# Errors

### If errors install
```
sudo apt install postfix-mysql dovecot-mysql
```

### Postfix dynamic maps configuration file debian 10 (error was here)
/etc/postfix/dynamicmaps.cf
```
tcp /usr/lib/postfix/dict_tcp.so            dict_tcp_open
mysql   /usr/lib/postfix/postfix-mysql.so   dict_mysql_open 
# mysql  /usr/lib/postfix/dict_mysql.so      dict_mysql_open 
# sqlite  /usr/lib/postfix/dict_sqlite.so   dict_sqlite_open    
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

### Send email
```
# Install mail
sudo apt install mailutils net-tools dnsutils

# Send email
echo "Hello message" | mail -s "Test message subject" email2@example.com
echo "Hello message" | mail -s "Test message subject" email1@example.com
echo "Hello message" | mail -s "Test message subject" alias@example.com

# Show logs
sudo cat /var/log/mail.log
sudo tail -f /var/log/mail.log
```

### Firewall
Smtp ports 25,465,587,110,995,143,993
```
# Show working services ports
sudo netstat -tulpn

# Open ports
sudo ufw allow 25,465,587,995,993
sudo ufw reload
sudo ufw status numbered
```

# References
- https://www.siemaszko.info/serwer-email-z-postfix-dovecot-na-bazie-mysql-debian-lub-ubuntu
- https://www.linode.com/docs/guides/email-with-postfix-dovecot-and-mysql
- https://serverfault.com/questions/861050/postfix-unsupported-dictionary-type-mysql
