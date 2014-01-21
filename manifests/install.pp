class monit::install {
    package { "monit":
        ensure => present,
        require => Class["vagrant_pre"],
    }
}
