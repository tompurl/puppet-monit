# Monit Puppet Module

## Quick Start

Download the module and put it in your "modules" folder:

    $ git clone tom@git@github.com:tompurl/puppet-monit.git

Add this to your manifest:

    class { 'monit': 
      alert_address  => "foo@baz.com",
      smtp_host      => "smtp.mandrillapp.com",
      smtp_port      => 587,
      smtp_user_name => "foo@baz.com",
      smtp_password  => "thisIsReallyClever",
      email_hostname => $fqdn,
    }

Visit the page with a console-based web browser (like elinks) from the local
server console:

    $ elinks http://localhost:2812
    # username => admin, pass => monit    

You can change the username and password by setting the following parameters:

* ``web_username``
* ``web_password``

## Overview

This is a **very** simple module that simply installs monit with a lightweight
config file. Any additional configuration information should be placed in files
that are stored in one of the following directories:

* /etc/monit/conf.d
* /etc/monit/monitrc.d  #Seems to be preferred on Debian

## Why Do I Need An Email Address?

The main way that monit communicates with you is by email. I recommend
[mandrill](http://mandrill.com/) as a good, simple SMTP service.

## Tested Platforms

Debian 7 on x64 and Raspbian. No effort has yet been made to make it work with
anything else.
