#! /bin/sh
#Bitsoko script for intel edison
################################
clone(){
	#Remove any folders and held contents recursively and non interactively.
	echo "Removing stale folders..."
        rm -rf ~/bitsoko ~/bitsoko_lite
	echo "Making new directory"
	mkdir ~/bitsoko_lite
	cd ~/bitsoko_lite
	echo "changing working directory, now cloning"
	git clone https://github.com/bitsoko-services/hardware
        echo "successfully setup bitsoko lite"
}
################################
install_deps(){
	#Install sockets node lib ver 1.3.7
	echo "Retreiving node prerequisites, kindly wait..."
	npm install socket.io@1.3.7
	#Check for git and install if lacking
	echo "Checking for git prerequisite, kindly wait..."
	if [ -f /usr/bin/git ]
	then
	#Do nothing
	else:
		if [ opkg install git ]
		then
			#Do nothing
else
			echo "src all http://iotdk.intel.com/repos/2.0/iotdk/all" >> /etc/opkg/base-feeds.conf
			echo "src x86 http://iotdk.intel.com/repos/2.0/iotdk/x86" >> /etc/opkg/base-feeds.conf
			echo "src i586 http://iotdk.intel.com/repos/2.0/iotdk/i586" >> /etc/opkg/base-feeds.conf
			opkg update
			opkg install git
		fi
	fi
}
################################
run_webpage(){
if [[ "$(ping -c 1 8.8.8.8 | grep '100% packet loss' )" != "" ]];
then
	echo "Network absent"
	exit 1
else
	echo "Network is present"
	echo "Available ip addresses on this computer"
	ifconfig | awk '/inet addr/{print substr($2,6)}'
	echo "Starting webserver demo"
	node ~/bitsoko_lite/hardware/intel_edison/webpage.js
fi
}
################################
echo "Bitsoko lite script Initialized. what would you like to do? clone or quit or install_deps or run-webpage"
read action

if [ $action = clone ]
then
	clone
	exit
elif [ $action = install_deps ]
then
	install_deps
	exit
elif [ $action = quit ]
then
	exit
elif [ $action = run-webpage ]
then
	run_webpage
fi
