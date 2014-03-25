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

    # 4. install RVM:
    \curl -sSL https://get.rvm.io | bash

    # now manually do the stuff it tells you to

    rvm autolibs macports
    rvm get stable
    rvm autolibs macports
    rvm install rbx
    rvm reload
    rvm alias create default rbx
    rvm rbx


MYL specific
------------

1. Fork the MYL repo
2. Clone your fork to your local disk
3. cd ~/your/fork/MakeYourLaws
4. Run:

    bundle install
