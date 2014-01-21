class monit::config inherits monit {
    file { "/etc/monit/monitrc":
        content => template("monit/monitrc.erb"),
        require => Class["monit::install"],
        mode    => 600,
        owner   => root,
        notify  => Class["monit::service"],
    } 

    file { "/etc/default/monit":
        source  => "puppet:///modules/monit/monit-default",
        require => Class["monit::install"],
        mode    => 644,
        owner   => root,
        notify  => Class["monit::service"],
    } 
}
