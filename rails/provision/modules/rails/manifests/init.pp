class rails {
	# prerequisites
	require ruby

	$dependencies = ["apache2", "curl", "git", "libmysqlclient-dev", "libsqlite3-dev", "mysql-server", "nodejs"]

	package { $dependencies:
    	ensure   => 'installed'
	}

	package { 'rails':
    	ensure   => 'installed',
    	provider => 'gem'
	}
}