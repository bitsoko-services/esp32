## Author: Felix Omwansa

## If you already have Node installed, you might want to remove it. Some Node.js tools might execute Node.js as Node instead of Node.js, causing conflicts.


## Checking if node is on your system:

echo "[$0]: "
echo "[$0]: Checking if node is on your system: "

  if which node > /dev/null
    then
        # add deb.nodesource repo commands 
        # install node
	echo "[$0]: node is missing, installing node... "
	echo "[$0]: "

	## Install Node.js with Ubuntu Package Manager
	sudo apt-get install nodejs 

	##Then install the Node package manager, npm:
	sudo apt-get install npm

    else
        echo "[$0]: node is installed, skipping..."
    fi


## If you found the old Node package installed, run this command to completely remove it:
## sudo apt-get remove --purge node 

## Create a symbolic link for node, as many Node.js tools use this name to execute.
## this might be unnecessary if file exists

	##perform check to verify
	echo ""
	echo "[$0]: perform check to verify if symbolic link file for node exists:"
	if [ -f /usr/bin/node ]
	then 
		echo "[$0]:  /usr/bin/node exists, breaking operation..."

	else  ## create symbolic link for node
		sudo ln -s /usr/bin/nodejs /usr/bin/node
	fi


##Now both the Node and npm commands shoulde be working
