# Monit Puppet Module

Very simple module for installing and configuring monit.

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

## monit class parameters

| Parameter           | Type    | Default     | Description |
| :--------------     | :------ |:----------- | :---------- |
| alert_address       | boolean | true        | Set this to remove or purge all sudoers configs |
| package             | string  | OS specific | Set package name _(for unsupported platforms)_ |
| package_ensure      | string  | present     | latest, absent, or a specific package version |
| package_source      | string  | OS specific | Set package source _(for unsupported platforms)_ |
| purge               | boolean | true        | Purge unmanaged files from config_dir |
| config_file         | string  | OS specific | Set config_file _(for unsupported platforms)_ |
| config_file_replace | boolean | true        | Replace config file with module config file |
| config_dir          | string  | OS specific | Set config_dir _(for unsupported platforms)_ |
| source              | string  | OS specific | Set source _(for unsupported platforms)_ |

---

Manage sudo configuration via Puppet

## Usage


### Install sudo with default sudoers

#### Purge current sudo config
```puppet
    class { 'sudo': }
```

#### Purge sudoers.d directory, but leave sudoers file as it is
```puppet
    class { 'sudo':
      config_file_replace => false,
    }
```

#### Leave current sudo config as it is
```puppet
    class { 'sudo':
      purge               => false,
      config_file_replace => false,
    }
```

### Adding sudoers configuration

#### Using Code

```puppet
    class { 'sudo': }
    sudo::conf { 'web':
      source => 'puppet:///files/etc/sudoers.d/web',
    }
    sudo::conf { 'admins':
      priority => 10,
      content  => "%admins ALL=(ALL) NOPASSWD: ALL",
    }
    sudo::conf { 'joe':
      priority => 60,
      source   => 'puppet:///files/etc/sudoers.d/users/joe',
    }
```

#### Using Hiera

A hiera hash may be used to assemble the sudoers configuration.
Hash merging is also enabled, which supports layering the configuration settings.

Examples using:
- YAML backend
- an environment called __production__
- a __/etc/puppet/hiera.yaml__ hierarchy configuration:

```yaml
:hierarchy:
  - "%{environment}"
  - "defaults"
```

##### Load module

###### Using Puppet version 3+

Load the module via Puppet Code or your ENC.

```puppet
    include sudo
```

###### Using Puppet version 2.7+

After [Installing Hiera](http://docs.puppetlabs.com/hiera/1/installing.html):

- Load the `sudo` and `sudo::configs` modules via Puppet Code or your ENC.

```puppet
    include sudo
    include sudo::configs
```

##### Configure Hiera YAML __(defaults.yaml)__

These defaults will apply to all systems.

```yaml
sudo::configs:
    'web':
        'source'    : 'puppet:///files/etc/sudoers.d/web'
    'admins':
        'content'   : "%admins ALL=(ALL) NOPASSWD: ALL"
        'priority'  : 10
    'joe':
        'priority'  : 60
        'source'    : 'puppet:///files/etc/sudoers.d/users/joe'
```

##### Configure Hiera YAML __(production.yaml)__

This will only apply to the production environment.
In this example we are:
- inheriting/preserving the __web__ configuration
- overriding the __admins__ configuration
- removing the __joe__ configuration

```yaml
sudo::configs:
    'admins':
        'content'   : "%prodadmins ALL=(ALL) NOPASSWD: ALL"
        'priority'  : 10
    'joe':
        'ensure'    : 'absent'
        'source'    : 'puppet:///files/etc/sudoers.d/users/joe'
```

If you have Hiera version >= 1.2.0 and enable [Hiera Deeper Merging](http://docs.puppetlabs.com/hiera/1/lookup_types.html#deep-merging-in-hiera--120) you may conditionally override any setting.

In this example we are:
- inheriting/preserving the __web__ configuration
- overriding the __admins:content__ setting
- inheriting/preserving the __admins:priority__ setting
- inheriting/preserving the __joe:source__ and __joe:priority__ settings
- removing the __joe__ configuration

```yaml
sudo::configs:
    'admins':
        'content'   : "%prodadmins ALL=(ALL) NOPASSWD: ALL"
    'joe':
        'ensure'    : 'absent'
```

##### Set a custom name for the sudoers file

In some edge cases, the automatically generated sudoers file name is insufficient. For example, when an application generates a sudoers file with a fixed file name, using this class with the purge option enabled will always delete the custom file and adding it manually will generate a file with the right content, but the wrong name. To solve this, you can use the ```sudo_file_name``` option to manually set the desired file name. 

```puppet
sudo::conf { "foreman-proxy":
    ensure          => "present",
    source          => "puppet:///modules/sudo/foreman-proxy",
    sudo_file_name  => "foreman-proxy",
}
```

### sudo::conf / sudo::configs notes
* You can pass template() through content parameter.
* One of content or source must be set.

## sudo class parameters

| Parameter           | Type    | Default     | Description |
| :--------------     | :------ |:----------- | :---------- |
| alert_address       | string  | none        | The address to which monit will send notifications |
| smtp_host           | string  | none        | The host names for your SMTP server |
| smtp_port           | int     | none        | Duh :) |
| smtp_user_name      | string  | none        | The username for your SMTP account |
| smtp_password       | string  | none        | The password associated with the $smtp_user_name value |
| web_username        | string  | admin       | The username that you want to use to log into monitweb |
| web_password        | string  | monit       | The password that you want to use with monitweb |
