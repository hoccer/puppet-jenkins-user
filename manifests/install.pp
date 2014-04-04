class jenkins-user::install {
    
    group { "jenkins":
        ensure => present,
        name => "jenkins",
    }

    user { "jenkins":
        ensure => present,
        comment => "Login account for Jenkins CI build",
        gid => "jenkins",
        home => "/home/jenkins",
        managehome => true,
        name => "jenkins",
        shell => "/bin/bash",
        require => Group["jenkins"],
    }

    file { "/home/jenkins":
        ensure => directory,
        mode => 755,
        owner => "jenkins",
        group => "jenkins",
        require => User["jenkins"],
    }

    file { "/home/jenkins/.ssh":
        ensure => directory,
        mode => 700,
        owner => "jenkins",
        group => "jenkins",
        require => File["/home/jenkins"],
    }

    file { "/home/jenkins/.ssh/authorized_keys":
        ensure => present,
        mode => 600,
        owner => "jenkins",
        group => "jenkins",
        require => File["/home/jenkins/.ssh"],
    }

    file {"/home/jenkins/work":
        ensure => directory,
        mode => 700,
        owner => "jenkins",
        group => "jenkins",
        require => File["/home/jenkins"],

    }

    ssh_authorized_key { "jenkins_master":
        ensure => present,
        key => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDZNMBVijZcYuDOugGTo5DkSTGKFDW0s9S+p0rWLfgSwttk6LufM4jmow1JC4yt/Jtt0jOX1RacSoKTJlDk4jxKicWl1pLby6SwIy5tWE/LAD7a1E/aesJmaXKVOBPBNK6uPveDvT1yBITq0DuGwvKZxodz9Ex2r6HeHSjSbmsiTgYxg+A4r7BDMv44RILyOluooKrodda3RSfcmf/lCF1P4yc6hG8N+oP/CxRktfiG10NQWyhrDtfPmcYr/6h4AFbB4TK4cP+LjxanbPh4UTSnIAfTLyFbYCbycmYjlZ5SIfLZ6TYK+JWbJbgKf7+/yc2Rn+7DPUVsCY/m8X9xZRgr",
        name => "root@jenkins",
        type => "ssh-rsa",
        user => "jenkins",
        require => File["/home/jenkins/.ssh/authorized_keys"],
    }

}
