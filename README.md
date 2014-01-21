# Monit Puppet Module

## Quick Start

Download the module:

    # Private git server. I hope I don't share this with the world
    $ git clone tom@fs:/gitrepo/tompurl-monit.git modules/monit

Add this to your manifest:

    class { 'monit': }

Visit the page with a console-based web browser (like elinks) from the local
server console:

    $ elinks http://localhost:2812
    # username => admin, pass => monit    

## Overview

This is a **very** simple module that simply installs monit with a lightweight
config file. Any additional configuration information should be placed in files
that are stored in one of the following directories:

* /etc/monit/conf.d
* /etc/monit/monitrc.d  #Seems to be preferred on Debian

## Tested Platforms

Debian 7. No effort has yet been made to make it work with anything else.

## TODO

* Parameterize the following:
    * Web interface credentials
    * Email address?
