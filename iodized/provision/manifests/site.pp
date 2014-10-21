# puppetlabs-nodejs
include nodejs

# puppetlabs-git
include git

package { 'sass':
    ensure   => 'installed',
    provider => 'gem'
}

package { "libssl-dev":
    	ensure   	=> 'installed'
}

exec { "Get Erlang Solutions repo":
		command 	=> "wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb",
		path 		=> "/usr/bin/",
		timeout 	=> 0
}

exec { "Add Erlang Solutions repo":
		command 	=> "sudo dpkg -i erlang-solutions_1.0_all.deb",
		path 		=> "/usr/bin/",
		timeout 	=> 0,
		require  	=> Exec["Get Erlang Solutions repo"]
}

exec { "Update package manager":
		command 	=> "sudo apt-get update",
		path 		=> "/usr/bin/",
		timeout 	=> 0,
		require  	=> Exec["Add Erlang Solutions repo"]
}

package { "erlang":
    	ensure   	=> 'installed',
    	require  	=> [ Exec["Update package manager"], Package["libssl-dev"] ]
}

package { "elixir":
    	ensure   	=> 'installed',
    	require  	=> Package["erlang"]
}

exec { "checkout iodized":
		command 	=> "git clone https://github.com/envato/iodized.git",
		cwd			=> "/home/vagrant/shared",
		path 		=> "/usr/bin/",
		timeout 	=> 0,
		require  	=> Package["git"]
}


