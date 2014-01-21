class monit::service {
    service { "monit":
        ensure => running,
        hasstatus => true, # => IMPORTANT
        require => Class["monit::config"],
    }
}
