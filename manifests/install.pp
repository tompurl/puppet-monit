class monit::install {
    package { "monit":
        ensure => present,
    }
}
