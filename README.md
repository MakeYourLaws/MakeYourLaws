MakeYourLaws.org aims to eventually be an international scale replacement of legislatures, by enabling citizens to participate in online direct democracy (with transferrable proxies). It will bootstrap through existing legal mechanisms for direct action with teeth: ballot propositions and grassroots campaign financing.

This software is in very early alpha stage and not yet usable.

Installation on debian/Ubuntu systems
=====================================

    genkey() { head --bytes 1000 /dev/urandom | sha256sum | cut -f 1 -d ' '; }

    if ! test -e /var/lib/mysql; then
        mysql_rootpw=$(genkey)
        key_database_test=$(genkey)
        key_database_development=$(genkey)

        echo "mysql mysql-server/root_password string $mysql_rootpw" | sudo debconf-set-selections
        echo "mysql mysql-server/root_password_again string $mysql_rootpw" | sudo debconf-set-selections
        sudo apt-get install -qqy mysql-server mysql-client

        echo "passwort: $mysql_rootpw"
        mysql --user root --password=$mysql_rootpw <<EOF
    CREATE DATABASE IF NOT EXISTS myl_test;
    CREATE DATABASE IF NOT EXISTS myl_development;
    CREATE USER myl_test@localhost IDENTIFIED BY '$key_database_test';
    CREATE USER myl_development@localhost IDENTIFIED BY '$key_database_development';
    GRANT ALL ON myl_test.* TO myl_test@localhost;
    GRANT ALL ON myl_development.* TO myl_development@localhost;
    EOF
        echo -e '[mysqld]\nskip-networking' | sudo tee /etc/mysql/conf.d/skip-networking.cnf >/dev/null
        sudo /etc/init.d/mysql restart
    fi

    sudo apt-get install -qqy git rubygems libmysqlclient-dev libxml2-dev libxslt1-dev
    export PATH=/var/lib/gems/1.8/bin/:${PATH}
    sudo gem install bundler
    test -e MakeYourLaws || git clone git://github.com/MakeYourLaws/MakeYourLaws.git
    cd MakeYourLaws
    bundle install


    test -e config/keys/database.root || echo $key_database_test > config/keys/database.root
    test -e config/keys/database.test || echo $key_database_test > config/keys/database.test
    test -e config/keys/database.development || echo $key_database_development > config/keys/database.development
    genkey > config/keys/cookie_secret.test
    genkey > config/keys/cookie_secret.development

    (cd config/keys && touch facebook_id.development facebook_id.test facebook_secret.test facebook_secret.development github_id.test github_secret.test github_id.development github_secret.development google_id.test google_id.development google_secret.test google_secret.development twitter_key.test twitter_key.development twitter_secret.test twitter_secret.development)

    rake db:create # This fails at the moment, see https://github.com/MakeYourLaws/MakeYourLaws/issues/3
    rake db:migrate
    rake

    rails s
