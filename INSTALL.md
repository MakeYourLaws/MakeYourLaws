Initial ruby/rails setup (on OSX)
---------------------------------

    # 1. install xcode: https://itunes.apple.com/us/app/xcode/id497799835
    # install xcode's command line tools: http://guide.macports.org/#installing.xcode

    sudo xcodebuild -license
    xcode-select --install # if OSX 10.9+

    # 2. install MacPorts: http://www.macports.org/install.php

    sudo port install libxml2 libxslt
    sudo port upgrade outdated

    # 3. install mysql: http://dev.mysql.com/downloads/mysql/

    # 4. install redis:  http://redis.io/download

    sudo port install redis

    # server's config is in /server/redis.conf if you want to copy it

    # 5. install RVM:
    \curl -sSL https://get.rvm.io | bash

    # now manually do the stuff it tells you to

    rvm autolibs macports
    rvm get stable
    rvm autolibs macports
    rvm install rbx   # Note: MYL will also run on Ruby 2.1 if you prefer not to use Rubinius.
    rvm reload
    rvm alias create default rbx
    rvm rbx


MYL specific
------------

1. Fork the MYL repo (https://github.com/MakeYourLaws/MakeYourLaws)

2. Get it running locally:

    cd ~/your/workspace/directory
    # git clone git@github.com:YOURUSERNAME/MakeYourLaws.git
    cd MakeYourLaws
    bundle install
    rails s

