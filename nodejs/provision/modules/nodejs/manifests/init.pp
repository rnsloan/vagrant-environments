class nodejs {
	
	$packages = ["git"]

	$nodejs = ["nodejs", "nodejs-legacy", "npm"]

	exec { "Update package manager":
		command 	=> "sudo apt-get update",
		path 		=> "/usr/bin/",
		timeout 	=> 0
	}

	package { $packages:
    	ensure   	=> 'installed',
    	require  	=> Exec["Update package manager"]
	}

	#$packages = ["software-properties-common", "make,", "g++" "git"]
	#exec { "Add nodejs repository":
	#	command 	=> "sudo apt-add-repository ppa:chris-lea/node.js",
	#	path 		=> "/usr/bin/",
	#	require  	=> Package[$packages]
	#}

	package { $nodejs:
    	ensure   	=> 'installed',
    	require  	=> Package[$packages]
	}

	#file { "/usr/local/lib/node_modules":
	file { "/usr/local":
  		ensure 		=> directory,
  		group 		=> "vagrant",
  		owner 		=> "vagrant",
  		recurse 	=> true,
  		require  	=> Package[$nodejs]
	}
}