#!/bin/bash
 
###########################################
## Arch Linux Guacamole Installer Script ##
## NForce IT (c)                    2015 ##
## A.R. Winters                          ##
###########################################
 
## Define variables

installer_version=1.4
 
guac_version=0.9.7
mysql_version=5.1.35
 
mysql_username=root
mysql_password=password
 
ssl_country=NL
ssl_state=GR
ssl_city=Groningen
ssl_org=NForceIT
ssl_certname=gateway.nforce-it.nl
 
#System Update
#sudo pacman -Sy 
 
#System Upgrade
#sudo pacman -Syu

# Install syslog-ng
# sudo pacman -S syslog-ng
# sudo systemctl enable syslog-ng
# sudo systemctl start syslog-ng

# Install monospace font [required for Telnet and Ssh connections!]
# sudo pacman -S ttf-inconsolata
 
#Install Tomcat 8
#sudo pacman -S tomcat8
#sudo pacman -S tomcat-native
 
# Install Packages
#sudo pacman -S cairo pango libpng libvncserver git wget rsync openssh mariadb fakeroot
#sudo pacman -S automake

# Configure MySQL
#sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
#sudo systemctl enable mysqld
#sudo systemctl start mysqld
#sudo /usr/bin/mysqladmin -u $mysql_username password $mysql_password

# Install FreeRDP for Guacamole
#git clone https://aur.archlinux.org/freerdp-guacamole.git ~/Packages/freerdp
#cd ~/Packages
#makepkg -s PKGBUILD
#sudo pacman -U ~/Packages/freerdp-guacamole-1.0.2-8-x86_64.pkg.tar.xz
#PkgFileVersion=`ls | grep .x86_64`
#sudo pacman -U $PkgFileVersion

# Download install dependency package-query
#git clone https://aur.archlinux.org/package-query-git.git ~/Packages/package-query
#cd ~/Packages/package-query
#makepkg -s
#PkgVersion=`cat PKGBUILD | sed -n 's/.*\(pkgver=\).*/\0/p'| cut -b8-13`
#PkgFileVersion=`ls | grep .x86_64`
#sudo pacman -U $PkgFileVersion

# Dowload install uuid
#git clone https://aur.archlinux.org/uuid.git ~/Packages/uuid
#cd ~/Packages/uuid
#makepkg -s
#PkgFileVersion=`ls | grep .x86_64`
#sudo pacman -U $PkgFileVersion


#Download and Install libtelnet
#git clone https://aur.archlinux.org/libtelnet.git ~/Packages/libtelnet
#cd  ~/Packages/libtelnet
#makepkg -s
#PkgFileVersion=`ls | grep .x86_64`
#sudo pacman -U $PkgFileVersion
 
#Download and Install Guacamole Server
#git clone https://aur.archlinux.org/guacamole-server.git ~/Packages/guacamole-server
#cd  ~/Packages/guacamole-server
#makepkg -s
#PkgFileVersion=`ls | grep .x86_64`
#sudo pacman -U $PkgFileVersion

#Download and Install Guacamole Client
#sudo pacman -S jdk8-openjdk
#sudo wget http://sourceforge.net/projects/guacamole/files/current/binary/guacamole-$guac_version.war
#git clone https://aur.archlinux.org/guacamole-client.git ~/Packages/guacamole-client
#cd ~/Packages/guacamole-client
#makepkg -s
#PkgFileVersion=`ls | grep .pkg`
#sudo pacman -U $PkgFileVersion
 
# Enable guacd daemon
#sudo systemctl enable guacd 
 
# Create guacamole configuration directory
#sudo mkdir /etc/guacamole
 
# Create guacamole.properties configuration file
cat <<EOF1 > ~/Packages/guacamole.properties
# Hostname and port of guacamole proxy
guacd-hostname: localhost
guacd-port:     4822
 
 
# Auth provider class (authenticates user/pass combination, needed if using the provided login screen)
#auth-provider: net.sourceforge.guacamole.net.basic.BasicFileAuthenticationProvider
#basic-user-mapping: /etc/guacamole/user-mapping.xml
 
# Auth provider class
auth-provider: net.sourceforge.guacamole.net.auth.mysql.MySQLAuthenticationProvider
 
# MySQL properties
mysql-hostname: localhost
mysql-port: 3306
mysql-database: guacamole
mysql-username: guacamole
mysql-password: nforceit
 
lib-directory: /var/lib/guacamole/classpath
EOF1

#
#sudo cp ~/Packages/guacamole.properties /etc/guacamole/guacamole.properties
#sudo mkdir /usr/share/tomcat8/.guacamole
 
# Create a symbolic link of the properties file for Tomcat7
#sudo  ln -s /etc/guacamole/guacamole.properties /usr/share/tomcat8/.guacamole 
 
# Start the Guacamole (guacd) service
#sudo systemctl start guacd 
 
# Restart Tomcat 8
#sudo systemctl start tomcat8
 
########################################
# MySQL Installation and configuration #
########################################
cd ~/Packages/ 
# Download Guacamole MySQL Authentication Module
#wget http://sourceforge.net/projects/guacamole/files/current/extensions/guacamole-auth-jdbc-$guac_version.tar.gz

# Untar the Guacamole MySQL Authentication Module
#tar -xzf guacamole-auth-jdbc-$guac_version.tar.gz
 
# Create Guacamole classpath directory for MySQL Authentication files
#sudo mkdir -p /var/lib/guacamole/classpath
 
# Copy Guacamole MySQL Authentication module files to the created directory
#sudo cp guacamole-auth-jdbc-$guac_version/mysql/guacamole-auth-jdbc-mysql-$guac_version.jar /var/lib/guacamole/classpath/
 
# Download MySQL Connector-J
#sudo wget http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-$mysql_version.tar.gz
 
# Untar the MySQL Connector-J
#sudo tar -xzf mysql-connector-java-$mysql_version.tar.gz
 
# Copy the MySQL Connector-J jar file to the guacamole classpath diretory
#sudo cp mysql-connector-java-$mysql_version/mysql-connector-java-$mysql_version-bin.jar /var/lib/guacamole/classpath/
 
# Provide mysql root password to automate installation
#sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password greenrt"
#sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password greenrt"
 
# Lay down mysql configuration script
cat <<EOF2 > guacamolemysql.sql
#MySQL Guacamole Script

CREATE DATABASE guacamole;

CREATE USER 'guacamole'@'localhost' IDENTIFIED BY 'greenrt';

GRANT SELECT,INSERT,UPDATE,DELETE ON guacamole.* TO 'guacamole'@'localhost';

FLUSH PRIVILEGES;

quit
EOF2
 
# Create Guacamole database and user
#mysql -u $mysql_username --password=$mysql_password < guacamolemysql.sql
 
# Change directory to mysql-auth directory
#cd ~/Packages/guacamole-auth-jdbc-$guac_version/mysql
 
# Run database scripts to create schema and users
#cat schema/*.sql | mysql -u $mysql_username --password=$mysql_password guacamole
#sudo systemctl restart tomcat8

##########################################
# NGINX Installation and configuration #
##########################################
 
# Install Nginx
sudo pacman -S nginx
sudo mkdir -p /var/log/nginx
 
# Create directory to store server key and certificate
sudo mkdir /etc/nginx/ssl
 
# Create self-signed certificate
sudo openssl req -x509 -subj '/C=NL/ST=GR/L=GRONINGEN/O=IT/CN=nfgateway.nforce-it.nl' -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -extensions v3_ca
 
# Add proxy settings to nginx config file (/etc/nginx/sites-enabled/default)
# Borrowed configuration from Eric Oud Ammerveled (http://sourceforge.net/p/guacamole/discussion/1110834/thread/6961d682/#aca9)
sudo mkdir -p /etc/nginx/sites-enabled
cat <<'EOF3' > ~/Packages/default
# Listening on Port 443 (SSL) to secure the traffice between Guacamole traffic and proxy requests to Tomcat8
server {
    listen 443 ssl;
    server_name nfgateway.nforce-it.nl;

# This part is for SSL config only
    ssl on;
    ssl_certificate      /etc/nginx/ssl/nginx.crt;
    ssl_certificate_key  /etc/nginx/ssl/nginx.key;
    ssl_session_cache shared:SSL:10m;
    ssl_ciphers 'AES256+EECDH:AES256+EDH:!aNULL';
    ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
    ssl_stapling on;
    ssl_stapling_verify on;
    ssl_prefer_server_ciphers on;
  # ssl_dhparam /etc/ssl/certs/dhparam.pem;

# Found below settings to be performing best but it will work with your own
    tcp_nodelay    on;
    tcp_nopush     off;
    sendfile       on;
    client_body_buffer_size 10K;
    client_header_buffer_size 1k;
    client_max_body_size 8m;
    large_client_header_buffers 2 1k;
    client_body_timeout 12;
    client_header_timeout 12;
    keepalive_timeout 15;
    send_timeout 10;

# Hosting Guacamole on the local server
    location /guacamole/ {
            proxy_pass http://localhost:8080/guacamole/;
	  # proxy_cookie_path /guacamole/ /;                 # Advised by someone from the dev team; worked fine without it too.
            proxy_buffering off;
            proxy_http_version 1.1;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Upgrade $http_upgrade;
	    proxy_set_header Connection $http_connection;
            access_log /var/log/nginx/guacamole-access.log;
            error_log /var/log/nginx/guacamole-error.log;
	    break;
    }
}
EOF3
sudo cp ~/Packages/default /etc/nginx/sites-enabled/default
 
# Restart nginx service
sudo systemctl restart nginx
 
# Restart tomcat7
sudo systemctl restart tomcat8
 
# Restart guacd
sudo systemctl restart guacd
 
################################################
#           Firewall Configuration             #
################################################
 
