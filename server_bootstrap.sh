#!/bin/bash

# Liberally assembled from:
# https://www.linode.com/stackscripts/view/?StackScriptID=1635
# https://www.linode.com/stackscripts/view/?StackScriptID=2253
# https://www.linode.com/stackscripts/view/?StackScriptID=2438
# https://www.linode.com/stackscripts/view/?StackScriptID=1
# https://www.linode.com/stackscripts/view/?StackScriptID=123


# TODO for this script:
# - auto install the rails app from the github repo, run cap production deploy:setup
# - set up nginx to point to deployment app and eventual static site
# - create logrotate file to the deployed app logs

# TODO manually:
# - setup reverse DNS on Linode control panel


echo -n "Hostname (eg foo.com): "
read NEW_HOSTNAME
echo -n "Ruby environment (eg production): "
read R_ENV
echo "Deployment user (eg deploy or yourappname): "
read DEPLOY_USER
echo -n "SSH public key for deploy user (ssh-dss a3jro83r93...): "
read DEPLOY_SSHKEY
echo -n "Ruby version for RVM (eg 1.9.2): "
read RUBY
echo -n "Redis version (eg 2.4.4): "
read REDIS_VERSION
# echo -n "Github repo for the rails app: "
# read GITHUB_REPO
echo -n "Password for deploy user (will have sudo): "
read -s DEPLOY_PASSWORD
echo -n "MySQL root password: "
read -s DB_PASSWORD


echo "That's it. Now we run..."

sleep 3

# System related utilities
# My ref: http://www.linode.com/?r=aadfce9845055011e00f0c6c9a5c01158c452deb
# Thanks!

function lower {
    # helper function
    echo $1 | tr '[:upper:]' '[:lower:]'
}

function system_get_codename {
    echo `lsb_release -sc`
}

function system_get_release {
    echo `lsb_release -sr`
}

function system_add_user {
    # $1 - username
    # $2 - password
    # $3 - groups
    USERNAME=`lower $1`
    PASSWORD=$2
    SUDO_GROUP=$3
    SHELL="/bin/bash"
    useradd --create-home --shell "$SHELL" --user-group --groups "$SUDO_GROUP" "$USERNAME"
    echo "$USERNAME:$PASSWORD" | chpasswd
}

function system_add_system_user {
    # $1 - username
    # $2 - home
    USERNAME=`lower $1`
    HOME_DIR=$2
    if [ -z "$HOME_DIR" ]; then
        useradd --system --no-create-home --user-group $USERNAME
    else
        useradd --system --no-create-home --home-dir "$HOME_DIR" --user-group $USERNAME
    fi;
}

function system_get_user_home {
    # $1 - username
    cat /etc/passwd | grep "^$1:" | cut --delimiter=":" -f6
}

function system_user_add_ssh_key {
    # $1 - username
    # $2 - ssh key
    USERNAME=`lower $1`
    USER_HOME=`system_get_user_home "$USERNAME"`
    sudo -u "$USERNAME" mkdir "$USER_HOME/.ssh"
    sudo -u "$USERNAME" touch "$USER_HOME/.ssh/authorized_keys"
    sudo -u "$USERNAME" echo "$2" >> "$USER_HOME/.ssh/authorized_keys"
    chmod 0600 "$USER_HOME/.ssh/authorized_keys"
}

function system_sshd_edit_bool {
    # $1 - param name
    # $2 - Yes/No
    VALUE=`lower $2`
    if [ "$VALUE" == "yes" ] || [ "$VALUE" == "no" ]; then
        sed -i "s/^#*\($1\).*/\1 $VALUE/" /etc/ssh/sshd_config
    fi
}

function system_sshd_permitrootlogin {
    system_sshd_edit_bool "PermitRootLogin" "$1"
}

function system_sshd_passwordauthentication {
    system_sshd_edit_bool "PasswordAuthentication" "$1"
}

function system_sshd_pubkeyauthentication {
    system_sshd_edit_bool "PubkeyAuthentication" "$1"
}

function system_sshd_passwordauthentication {
    system_sshd_edit_bool "PasswordAuthentication" "$1"
}

function system_enable_universe {
    sed -i 's/^#\(.*deb.*\) universe/\1 universe/' /etc/apt/sources.list
    aptitude update
}

function system_update_locale_en_US_UTF_8 {
    aptitude -y install locales
    locale-gen en_US.UTF-8
    dpkg-reconfigure locales
    update-locale LANG=en_US.UTF-8
}

function system_update_hostname {
    # $1 - system hostname
    if [ ! -n "$1" ]; then
        echo "system_update_hostname() requires the system hostname as its first argument"
        return 1;
    fi
    echo $1 > /etc/hostname
    hostname -F /etc/hostname
    echo -e "\n127.0.0.1 $1.local $1\n" >> /etc/hosts
}

function system_security_fail2ban {
    aptitude -y install fail2ban
}

function system_security_ufw_install {
    aptitude -y install ufw
}

function system_security_ufw_configure_basic {
    # see https://help.ubuntu.com/community/UFW
    ufw logging on    

    ufw default deny

    ufw allow ssh
    ufw allow http
    ufw allow https

    ufw enable
}

function system_security_logcheck {
    aptitude -y install logcheck logcheck-database
}
 

# StackScript Bash Library
#
# Copyright (c) 2010 Linode LLC / Christopher S. Aker <caker@linode.com>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without modification, 
# are permitted provided that the following conditions are met:
#
# * Redistributions of source code must retain the above copyright notice, this
# list of conditions and the following disclaimer.
#
# * Redistributions in binary form must reproduce the above copyright notice, this
# list of conditions and the following disclaimer in the documentation and/or
# other materials provided with the distribution.
#
# * Neither the name of Linode LLC nor the names of its contributors may be
# used to endorse or promote products derived from this software without specific prior
# written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
# EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
# OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
# SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
# TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
# DAMAGE.

###########################################################
# System
###########################################################

function system_update {
    apt-get update
    apt-get -y install aptitude
    aptitude -y full-upgrade
}

function system_primary_ip {
    # returns the primary IP assigned to eth0
    echo $(ifconfig eth0 | awk -F: '/inet addr:/ {print $2}' | awk '{ print $1 }')
}

function get_rdns {
    # calls host on an IP address and returns its reverse dns

    if [ ! -e /usr/bin/host ]; then
        aptitude -y install dnsutils > /dev/null
    fi
    echo $(host $1 | awk '/pointer/ {print $5}' | sed 's/\.$//')
}

function get_rdns_primary_ip {
    # returns the reverse dns of the primary IP assigned to this system
    echo $(get_rdns $(system_primary_ip))
}

###########################################################
# Postfix
###########################################################

function postfix_install_loopback_only {
    # Installs postfix and configure to listen only on the local interface. Also
    # allows for local mail delivery

    echo "postfix postfix/main_mailer_type select Internet Site" | debconf-set-selections
    echo "postfix postfix/mailname string localhost" | debconf-set-selections
    echo "postfix postfix/destinations string localhost.localdomain, localhost" | debconf-set-selections
    aptitude -y install postfix
    /usr/sbin/postconf -e "inet_interfaces = loopback-only"
    #/usr/sbin/postconf -e "local_transport = error:local delivery is disabled"

    touch /tmp/restart-postfix
}


###########################################################
# Apache
###########################################################

function apache_install {
    # installs the system default apache2 MPM
    aptitude -y install apache2

    a2dissite default # disable the interfering default virtualhost

    # clean up, or add the NameVirtualHost line to ports.conf
    sed -i -e 's/^NameVirtualHost \*$/NameVirtualHost *:80/' /etc/apache2/ports.conf
    if ! grep -q NameVirtualHost /etc/apache2/ports.conf; then
        echo 'NameVirtualHost *:80' > /etc/apache2/ports.conf.tmp
        cat /etc/apache2/ports.conf >> /etc/apache2/ports.conf.tmp
        mv -f /etc/apache2/ports.conf.tmp /etc/apache2/ports.conf
    fi
}

function apache_tune {
    # Tunes Apache's memory to use the percentage of RAM you specify, defaulting to 40%

    # $1 - the percent of system memory to allocate towards Apache

    if [ ! -n "$1" ];
        then PERCENT=40
        else PERCENT="$1"
    fi

    aptitude -y install apache2-mpm-prefork
    PERPROCMEM=10 # the amount of memory in MB each apache process is likely to utilize
    MEM=$(grep MemTotal /proc/meminfo | awk '{ print int($2/1024) }') # how much memory in MB this system has
    MAXCLIENTS=$((MEM*PERCENT/100/PERPROCMEM)) # calculate MaxClients
    MAXCLIENTS=${MAXCLIENTS/.*} # cast to an integer
    sed -i -e "s/\(^[ \t]*MaxClients[ \t]*\)[0-9]*/\1$MAXCLIENTS/" /etc/apache2/apache2.conf

    touch /tmp/restart-apache2
}

function apache_virtualhost {
    # Configures a VirtualHost

    # $1 - required - the hostname of the virtualhost to create 

    if [ ! -n "$1" ]; then
        echo "apache_virtualhost() requires the hostname as the first argument"
        return 1;
    fi

    if [ -e "/etc/apache2/sites-available/$1" ]; then
        echo /etc/apache2/sites-available/$1 already exists
        return;
    fi

    mkdir -p /srv/www/$1/public_html /srv/www/$1/logs

    echo "<VirtualHost *:80>" > /etc/apache2/sites-available/$1
    echo "    ServerName $1" >> /etc/apache2/sites-available/$1
    echo "    DocumentRoot /srv/www/$1/public_html/" >> /etc/apache2/sites-available/$1
    echo "    ErrorLog /srv/www/$1/logs/error.log" >> /etc/apache2/sites-available/$1
    echo "    CustomLog /srv/www/$1/logs/access.log combined" >> /etc/apache2/sites-available/$1
    echo "</VirtualHost>" >> /etc/apache2/sites-available/$1

    a2ensite $1

    touch /tmp/restart-apache2
}

function apache_virtualhost_from_rdns {
    # Configures a VirtualHost using the rdns of the first IP as the ServerName

    apache_virtualhost $(get_rdns_primary_ip)
}


function apache_virtualhost_get_docroot {
    if [ ! -n "$1" ]; then
        echo "apache_virtualhost_get_docroot() requires the hostname as the first argument"
        return 1;
    fi

    if [ -e /etc/apache2/sites-available/$1 ];
        then echo $(awk '/DocumentRoot/ {print $2}' /etc/apache2/sites-available/$1 )
    fi
}

###########################################################
# mysql-server
###########################################################

function mysql_install {
    # $1 - the mysql root password

    if [ ! -n "$1" ]; then
        echo "mysql_install() requires the root pass as its first argument"
        return 1;
    fi

    echo "mysql-server-5.1 mysql-server/root_password password $1" | debconf-set-selections
    echo "mysql-server-5.1 mysql-server/root_password_again password $1" | debconf-set-selections
    apt-get -y install mysql-server mysql-client

    echo "Sleeping while MySQL starts up for the first time..."
    sleep 5
}

function mysql_tune {
    # Tunes MySQL's memory usage to utilize the percentage of memory you specify, defaulting to 40%

    # $1 - the percent of system memory to allocate towards MySQL

    if [ ! -n "$1" ];
        then PERCENT=40
        else PERCENT="$1"
    fi

    sed -i -e 's/^#skip-innodb/skip-innodb/' /etc/mysql/my.cnf # disable innodb - saves about 100M

    MEM=$(awk '/MemTotal/ {print int($2/1024)}' /proc/meminfo) # how much memory in MB this system has
    MYMEM=$((MEM*PERCENT/100)) # how much memory we'd like to tune mysql with
    MYMEMCHUNKS=$((MYMEM/4)) # how many 4MB chunks we have to play with

    # mysql config options we want to set to the percentages in the second list, respectively
    OPTLIST=(key_buffer sort_buffer_size read_buffer_size read_rnd_buffer_size myisam_sort_buffer_size query_cache_size)
    DISTLIST=(75 1 1 1 5 15)

    for opt in ${OPTLIST[@]}; do
        sed -i -e "/\[mysqld\]/,/\[.*\]/s/^$opt/#$opt/" /etc/mysql/my.cnf
    done

    for i in ${!OPTLIST[*]}; do
        val=$(echo | awk "{print int((${DISTLIST[$i]} * $MYMEMCHUNKS/100))*4}")
        if [ $val -lt 4 ]
            then val=4
        fi
        config="${config}\n${OPTLIST[$i]} = ${val}M"
    done

    sed -i -e "s/\(\[mysqld\]\)/\1\n$config\n/" /etc/mysql/my.cnf

    touch /tmp/restart-mysql
}

function mysql_create_database {
    # $1 - the mysql root password
    # $2 - the db name to create

    if [ ! -n "$1" ]; then
        echo "mysql_create_database() requires the root pass as its first argument"
        return 1;
    fi
    if [ ! -n "$2" ]; then
        echo "mysql_create_database() requires the name of the database as the second argument"
        return 1;
    fi

    echo "CREATE DATABASE $2;" | mysql -u root -p$1
}

function mysql_create_user {
    # $1 - the mysql root password
    # $2 - the user to create
    # $3 - their password

    if [ ! -n "$1" ]; then
        echo "mysql_create_user() requires the root pass as its first argument"
        return 1;
    fi
    if [ ! -n "$2" ]; then
        echo "mysql_create_user() requires username as the second argument"
        return 1;
    fi
    if [ ! -n "$3" ]; then
        echo "mysql_create_user() requires a password as the third argument"
        return 1;
    fi

    echo "CREATE USER '$2'@'localhost' IDENTIFIED BY '$3';" | mysql -u root -p$1
}

function mysql_grant_user {
    # $1 - the mysql root password
    # $2 - the user to bestow privileges 
    # $3 - the database

    if [ ! -n "$1" ]; then
        echo "mysql_create_user() requires the root pass as its first argument"
        return 1;
    fi
    if [ ! -n "$2" ]; then
        echo "mysql_create_user() requires username as the second argument"
        return 1;
    fi
    if [ ! -n "$3" ]; then
        echo "mysql_create_user() requires a database as the third argument"
        return 1;
    fi

    echo "GRANT ALL PRIVILEGES ON $3.* TO '$2'@'localhost';" | mysql -u root -p$1
    echo "FLUSH PRIVILEGES;" | mysql -u root -p$1

}

###########################################################
# PHP functions
###########################################################

function php_install_with_apache {
    aptitude -y install php5 php5-mysql libapache2-mod-php5
    touch /tmp/restart-apache2
}

function php_tune {
    # Tunes PHP to utilize up to 32M per process

    sed -i'-orig' 's/memory_limit = [0-9]\+M/memory_limit = 32M/' /etc/php5/apache2/php.ini
    touch /tmp/restart-apache2
}

###########################################################
# Wordpress functions
###########################################################

function wordpress_install {
    # installs the latest wordpress tarball from wordpress.org

    # $1 - required - The existing virtualhost to install into

    if [ ! -n "$1" ]; then
        echo "wordpress_install() requires the vitualhost as its first argument"
        return 1;
    fi

    if [ ! -e /usr/bin/wget ]; then
        aptitude -y install wget
    fi

    VPATH=$(apache_virtualhost_get_docroot $1)

    if [ ! -n "$VPATH" ]; then
        echo "Could not determine DocumentRoot for $1"
        return 1;
    fi

    # download, extract, chown, and get our config file started
    cd $VPATH
    wget http://wordpress.org/latest.tar.gz
    tar xfz latest.tar.gz
    chown -R www-data: wordpress/
    cd $VPATH/wordpress
    cp wp-config-sample.php wp-config.php
    chown www-data wp-config.php
    chmod 640 wp-config.php

    # database configuration
    WPPASS=$(randomString 20)
    mysql_create_database "$DB_PASSWORD" wordpress
    mysql_create_user "$DB_PASSWORD" wordpress "$WPPASS"
    mysql_grant_user "$DB_PASSWORD" wordpress wordpress

    # configuration file updates
    for i in {1..4}
        do sed -i "0,/put your unique phrase here/s/put your unique phrase here/$(randomString 50)/" wp-config.php
    done

    sed -i 's/database_name_here/wordpress/' wp-config.php
    sed -i 's/username_here/wordpress/' wp-config.php
    sed -i "s/password_here/$WPPASS/" wp-config.php

    # http://downloads.wordpress.org/plugin/wp-super-cache.0.9.8.zip
}

###########################################################
# Other niceties!
###########################################################

function goodstuff {
    # Installs the REAL vim, wget, less, and enables color root prompt and the "ll" list long alias

    aptitude -y install wget vim less
    sed -i -e 's/^#PS1=/PS1=/' /root/.bashrc # enable the colorful root bash prompt
    sed -i -e "s/^#alias ll='ls -l'/alias ll='ls -al'/" /root/.bashrc # enable ll list long alias <3
}


###########################################################
# utility functions
###########################################################

function restartServices {
    # restarts services that have a file in /tmp/needs-restart/

    for service in $(ls /tmp/restart-* | cut -d- -f2-10); do
        /etc/init.d/$service restart
        rm -f /tmp/restart-$service
    done
}

function randomString {
    if [ ! -n "$1" ];
        then LEN=20
        else LEN="$1"
    fi

    echo $(</dev/urandom tr -dc A-Za-z0-9 | head -c $LEN) # generate a random string
}

function log {
  echo "### $1 -- `date '+%D %T'`"
}

function system_install_logrotate {
  apt-get -y install logrotate
}

function set_default_environment {
  cat >> /etc/environment << EOF
RAILS_ENV=$R_ENV
RACK_ENV=$R_ENV
EOF
}

function user_ssh_keygen {
  # $1 - username
  sudo -u $1 -i -- "ssh-keygen -N '' -f ~/.ssh/id_rsa -t rsa -q"
}

function create_deployment_user {
  system_add_user $DEPLOY_USER $DEPLOY_PASSWORD "users,sudo"
  system_user_add_ssh_key $DEPLOY_USER "$DEPLOY_SSHKEY"
  system_update_locale_en_US_UTF_8
  user_ssh_keygen $DEPLOY_USER
  # cp ~/.gemrc /home/$DEPLOY_USER/
  # chown $DEPLOY_USER:$DEPLOY_USER /home/$DEPLOY_USER/.gemrc
}

function install_essentials {
  aptitude -y install build-essential libpcre3-dev libssl-dev libcurl4-openssl-dev libreadline5-dev libxml2-dev libxslt1-dev libmysqlclient-dev openssh-server git-core
  goodstuff
}

function set_nginx_boot_up {
  wget "https://raw.github.com/ivanvanderbyl/rails-nginx-passenger-ubuntu/master/nginx/nginx" -O /etc/init.d/nginx
  chmod +x /etc/init.d/nginx
  /usr/sbin/update-rc.d -f nginx defaults
  cat > /etc/logrotate.d/nginx << EOF
/opt/nginx/logs/* {
        daily
        missingok
        rotate 52
        compress
        delaycompress
        notifempty
        create 640 nobody root
        sharedscripts
        postrotate
                [ ! -f /opt/nginx/logs/nginx.pid ] || kill -USR1 `cat /opt/nginx/logs/nginx.pid`
        endscript
}
EOF
  /etc/init.d/nginx start
}

function set_production_gemrc {
  cat > ~/.gemrc << EOF
verbose: true
bulk_treshold: 1000
install: --no-ri --no-rdoc --env-shebang
benchmark: false
backtrace: false
update: --no-ri --no-rdoc --env-shebang
update_sources: true
EOF
}


function install_nodejs {
  apt-get -y install python-software-properties
  add-apt-repository ppa:chris-lea/node.js
  apt-get -y update
  apt-get -y install nodejs nodejs-dev
}

function install_redis {
  cd /usr/local/src
  wget http://redis.googlecode.com/files/redis-$REDIS_VERSION.tar.gz
  tar xvzf redis-$REDIS_VERSION.tar.gz
  cd redis-$REDIS_VERSION
  make
  make install
  mkdir -p /var/lib/redis
  mkdir -p /var/log/redis
  adduser --system  --disabled-login --disabled-password --home /var/lib/redis  --group redis
  chown redis.redis /var/lib/redis
  chown redis.redis /var/log/redis
  /usr/sbin/update-rc.d -f redis-server defaults
  wget "https://github.com/ijonas/dotfiles/raw/master/etc/init.d/redis-server" -O /etc/init.d/redis-server
  chmod +x /etc/init.d/redis-server
  cd ~/
  wget "http://download.redis.io/redis-stable/redis.conf" -O /etc/redis.conf.example
  cat > /etc/redis.conf << EOF
daemonize yes
pidfile /var/run/redis.pid
port 6379
timeout 0
loglevel verbose
logfile /var/log/redis/redis.log
databases 16
save 900 1
save 300 10
save 60 10000
rdbcompression yes
dbfilename dump.rdb
dir ./
slave-serve-stale-data yes
appendonly no
appendfsync everysec
no-appendfsync-on-rewrite no
auto-aof-rewrite-percentage 100
auto-aof-rewrite-min-size 64mb
slowlog-log-slower-than 10000
slowlog-max-len 1024
vm-enabled no
vm-swap-file /tmp/redis.swap
vm-max-memory 0
vm-page-size 32
vm-pages 134217728
vm-max-threads 4
hash-max-zipmap-entries 512
hash-max-zipmap-value 64
list-max-ziplist-entries 512
list-max-ziplist-value 64
set-max-intset-entries 512
zset-max-ziplist-entries 128
zset-max-ziplist-value 64
activerehashing yes
EOF

  /etc/init.d/redis-server start
}


function install_bluepill {
  gem install bluepill
  echo "local6.* /var/log/bluepill.log" > /etc/rsyslog.d/bluepill.conf
  sed -i '/\/var\/log\/messages/i/var/log/bluepill.log' /etc/logrotate.d/rsyslog
  mkdir -p /var/bluepill/pids /var/bluepill/socks
  echo "$DEPLOY_USER    ALL=(ALL) NOPASSWD:/usr/local/bin/bluepill" >> /etc/sudoers
}

function install_juggernaut {
  curl http://npmjs.org/install.sh | sh # install Node.js package manager
  npm install -g juggernaut
  gem install juggernaut
  adduser --system --disabled-login --disabled-password --home /var/lib/juggernaut  --group juggernaut
  cat > /etc/init/juggernaut.conf << EOF
description "juggernaut2"
 
# used to be: start on startup
# until we found some mounts weren't ready yet while booting:
start on started mountall
stop on shutdown
 
# Automatically Respawn:
respawn
respawn limit 99 5
 
script
    # Not sure why $HOME is needed, but we found that it is:
    export HOME="/var/lib/juggernaut"
 
    exec /usr/bin/node /usr/lib/node_modules/juggernaut/server.js >> /var/log/juggernaut.log 2>&1
end script
 
post-start script
   # Optionally put a script here that will notifiy you node has (re)started
   # /root/bin/hoptoad.sh "node.js has started!"
end script

EOF
   chmod +x /etc/init/juggernaut.conf
   ufw allow 8080 # juggernaut server
   ufw allow 843 # flash policy socket
   start jugggernaut
}


exec &> /root/stackscript.log

log "Updating System..."
system_enable_universe
system_update

log "Installing essentials...includes goodstuff"
install_essentials

log "Setting hostname to $NEW_HOSTNAME"
system_update_hostname $NEW_HOSTNAME

log "Creating deployment user $DEPLOY_USER"
create_deployment_user

log "Setting basic security settings"
# system_security_fail2ban 
system_security_ufw_install
system_security_ufw_configure_basic
system_sshd_permitrootlogin No
system_sshd_passwordauthentication No
system_sshd_pubkeyauthentication Yes
/etc/init.d/ssh restart

log "installing log_rotate"
system_install_logrotate

log "Installing and tunning MySQL"
mysql_install "$DB_PASSWORD" && mysql_tune 40

log "Installing RVM and Ruby dependencies" >> $logfile
apt-get -y install curl git-core bzip2 build-essential zlib1g-dev libssl-dev
apt-get -y install bison openssl libreadline5 zlib1g-dev libsqlite3-0 libsqlite3-dev sqlite3 libxml2-dev
apt-get -y install libxslt1-dev libxslt-ruby

log "Installing RVM system-wide"
sudo bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)
cat >> /etc/profile <<'EOF'
# Load RVM if it is installed,
#  first try to load  user install
#  then try to load root install, if user install is not there.
if [ -s "$HOME/.rvm/scripts/rvm" ] ; then
  . "$HOME/.rvm/scripts/rvm"
elif [ -s "/usr/local/rvm/scripts/rvm" ] ; then
  . "/usr/local/rvm/scripts/rvm"
fi
EOF

echo LANG=en_US.UTF-8 >> /etc/environment

source /etc/profile

log "Installing Ruby $RUBY"

rvm install $RUBY
rvm use $RUBY --default

log "Updating Ruby gems"
set_production_gemrc
gem update --system


log "Instaling Phusion Passenger and Nginx"
gem install passenger
passenger-install-nginx-module --auto --auto-download --prefix=/opt/nginx

log "Setting up Nginx to start on boot and rotate logs"
set_nginx_boot_up

log "Setting Rails/Rack defaults"
set_default_environment

log "Install Bundler"
gem install bundler

log "Install Node.js"
install_nodejs

log "Install Bluepill"
install_bluepill

log "Install Redis"
install_redis

log "Install Juggernaut"
install_juggernaut

# TODO: make juggernaut autorun

log "Installing Chef"
gem install chef
log "Configuring Chef solo"
mkdir /etc/chef
cat >> /etc/chef/solo.rb <<EOF
file_cache_path "/tmp/chef"
cookbook_path "/tmp/chef/cookbooks"
role_path "/tmp/chef/roles"
EOF

log "Restarting Services"
restartServices
