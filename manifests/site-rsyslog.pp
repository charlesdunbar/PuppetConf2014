node puppet {
  class {'rsyslog':
    ssl => true,
  }

  class { '::rsyslog::client':
    log_local  => 'true',
    server     => 'rsyslog',
    ssl_ca     => "/var/lib/puppet/ssl/certs/ca.pem",
  }
}

node rsyslog {
  class {'rsyslog':
    ssl => true,
  }

  class { '::rsyslog::server':
    server_dir => '/srv/log/',
    ssl_ca     => "/var/lib/puppet/ssl/certs/ca.pem",
    ssl_cert   => "/var/lib/puppet/ssl/certs/${::fqdn}.pem",
    ssl_key    => "/var/lib/puppet/ssl/private_keys/${::fqdn}.pem",
  }
}

node client {
  class {'rsyslog':
    ssl => true,
  }

  class { '::rsyslog::client':
    log_local  => 'true',
    server     => 'rsyslog',
    ssl_ca     => "/var/lib/puppet/ssl/certs/ca.pem",
  }
}

node elk {
  class {'rsyslog':
    ssl => true,
  }

  class { '::rsyslog::client':
    log_local  => 'true',
    server     => 'rsyslog',
    ssl_ca     => "/var/lib/puppet/ssl/certs/ca.pem",
  }
}
