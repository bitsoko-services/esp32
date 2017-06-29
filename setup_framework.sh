
##build development framework 

	echo ""
	echo "[$0]:  This will build the development framework for the ESP32, set the required path variables and move the project resource folders into the narra directory."


	## Install the esp-idf and set required variables
	## BASE variable-This is where you want the entire toolchain to live
	#The script here is derived from: http://esp-idf.readthedocs.io/en/latest/linux-setup.html

	BASE=$(pwd)	#set the working directory

	echo ""
	echo "[$0]:  Checking for system prerequisites."
	sleep 2
	echo ""

	#Archlinux
	if [ $(which pacman) ]
	then
		echo "[$0]:  Found archlinux based system."
		sudo pacman -S --needed gcc git make ncurses flex bison gperf python2-pyserial wget 2>/dev/null
	fi

	#Ubuntu
	if [ $(which apt-get) ]
	then
		echo "[$0]:  Found Ubuntu based system."
		sudo apt-get update
		sudo apt-get install git make libncurses-dev flex bison gperf python python-serial wget 2>/dev/null
	fi

	#Any other system goes here

	# Get or update IDF
	echo ""
	echo "[$0]:  Get or update IDF.."
	sleep 2
	
	if [ -d esp-idf ]
	then 
		echo "[$0]:  Found esp-idf, updating..."
		cd esp-idf 
		git pull && git submodule update --recursive 
		cd $BASE
	else  ## not found, get it
		echo "[$0]:  esp-idf not found. getting... "
		git clone --recursive https://github.com/espressif/esp-idf.git
	fi

	## Perform mandatory removal of any tar files in case of a previous error
	if [ -f *.tar.gz ] || [ -f *.tar.gz.* ]
	then
		echo ""
		echo "[$0]:  Removing residual tar file(s)"
		sleep 2
		rm *.tar.gz 2>/dev/null
		rm *.tar.gz.* 2>/dev/null
	fi

	## Get 64 bit linux binary toolchain -- this might get out of date when they change blobs:
	## Current version 1.22.0-61-gab8375a-5.2.0
	echo ""
	echo "[$0]:  Get 64 bit linux binary toolchain -- this might get out of date when they change blobs"

	if [ -d xtensa-esp32-elf ]
	then 
		echo "[$0]:  Found ESP32 binary toolchain. Performing mandatory replacement."
		echo "[$0]:  Current version at the making of this makefile 1.22.0-61-gab8375a-5.2.0"
		echo "[$0]:  Check current version from http://esp-idf.readthedocs.io/en/latest/linux-setup.html"
		rm -rf xtensa-esp32-elf
		wget https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-61-gab8375a-5.2.0.tar.gz
		tar -xvzf xtensa-esp32-elf-linux64-1.22.0-61-gab8375a-5.2.0.tar.gz
	#	rm *.tar.gz 2>/dev/null && rm *.tar.gz.* 2>/dev/null
	else
		wget https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-61-gab8375a-5.2.0.tar.gz
		tar -xvzf xtensa-esp32-elf-linux64-1.22.0-61-gab8375a-5.2.0.tar.gz
		rm *.tar.gz 2>/dev/null && rm *.tar.gz.* 2>/dev/null
	fi

	## Setup environment variables:
	echo ""
	echo "[$0]:  Setting up environment variables and exporting.. "
	sleep 2s
	export IDF_PATH=${BASE}/esp-idf
	echo "[$0]:  export IDF_PATH=${BASE}/esp-idf"
	export PATH=$PATH:${BASE}/xtensa-esp32-elf/bin
	echo "[$0]:  export PATH=$PATH:${BASE}/xtensa-esp32-elf/bin"

		if [ -d narra ]
		then 
		echo "[$0]:  Found narra folder, no update required."
		sleep 2

		else ##move the project folders to narra directory:
		mkdir narra
		tee ~/esp32-nodejs-app ~/ble_app_eddystone < ~/build_app.sh >/dev/null
		#find ~/esp32-nodejs-app ~/ble_app_eddystone -maxdepth 0 -exec cp build_app.sh {} \;

 
		##eddystone
		mv ble_app_eddystone narra
		
		##nodejs
		mkdir esp32-nodejs-app
		mv package.json esp32-nodejs-app
		mv install_noble.sh esp32-nodejs-app
		mv listen-notification.js esp32-nodejs-app
		mv listenNode.sh gatt_server_notif_switch
		mv gatt_server_notif_switch esp32-nodejs-app
		mv esp32-nodejs-app narra
		fi

echo "[$0]: Setup of development framework has been completed.."
echo ""
echo "[$0]: Current working directory: "
pwd
echo "[$0]: Current working directory contents: "
ls
echo ""

