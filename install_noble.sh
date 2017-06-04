## Author: Felix Omwansa

#This script installs noble : A Node.js BLE (Bluetooth Low Energy) central module.
echo ""
echo "[$0]: This script installs noble : A Node.js BLE (Bluetooth Low Energy) central module."
echo "[$0]: "

## If you already have Node installed, you might want to remove it. Some Node.js tools might execute Node.js as Node instead of Node.js, causing conflicts.
## Checking if node is on your system:

echo "[$0]: "
echo "[$0]: Checking if node is on your system... "

  if which node > /dev/null
    then
        # add deb.nodesource repo commands 
        # install node
	echo "[$0]: node is missing, installing node... "
	echo "[$0]: "

	## Install Node.js with Ubuntu Package Manager
	sudo apt-get install nodejs 
    else
        echo "[$0]: node is installed, skipping..."
	echo ""
    fi

##Then install the Node package manager, npm:
	sudo apt-get install npm

## Installing Prerequisites: Ubuntu/Debian/Raspbian
echo "[$0]: Installing Prerequisites for Ubuntu/Debian/Raspbian system..."
echo ""
sudo apt-get install bluetooth bluez libbluetooth-dev libudev-dev

## Create a symbolic link for node, as many Node.js tools use this name to execute.

	##perform check to verify
	echo ""
	echo "[$0]: perform check to verify if symbolic link file for node exists..."
	if [ -f /usr/bin/node ]
	then 
		echo "[$0]:  /usr/bin/node exists, breaking operation..."
		echo ""
	else  ## create symbolic link for node
		sudo ln -s /usr/bin/nodejs /usr/bin/node
	fi

## Install noble
echo "[$0]: Installating noble... "
echo ""
npm install noble

echo "[$0]: Installation complete. "
echo ""

##

  
