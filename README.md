# Monit Puppet Module

## Quick Start

Download the module:

    # Private git server. I hope I don't share this with the world
    $ git clone tom@fs:/gitrepo/tompurl-monit.git modules/monit

Add this to your manifest:

    class { 'monit': 
      alert_address => "foo@baz.com"
    }

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

## Why Do I Need An Email Address?

The mail way that monit communicates with you is by email. Please note however
that this module will **not** set up a mail server for you. If you run the
monit software before you configure some type of MTA then you will not be
notified of any issues.

Here's the good news:

* You can still monitor your system using the HTTP interface
* Monit will still actually work if you don't set up an MTA - it just won't
  notify you via email of any issues.

If you need to set up an MTA, might I suggest 
[nullmail](https://forge.puppetlabs.com/akumria/nullmailer "The akumria/nullmailer module at PuppetForge") 
+ [mandrill](http://mandrill.com/)? It's super simple and cheap.

## Tested Platforms

Debian 7. No effort has yet been made to make it work with anything else.
