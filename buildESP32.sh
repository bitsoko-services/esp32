## Author: Elliot Williams
## Modified by : Alois Mbutura and Felix Omwansa

echo ""
echo "[$0]: Bitsoko ESP32 script initialized"


	##FUNCTION: build development framework 
	build_framework() {
	echo "FUNCTION: build_framework"
	echo "[$0]:  This will build the development framework for the ESP32, set the required path variables and move the resource folders into the project folder."
	
	## Install the esp-idf and set required variables
	## BASE variable-This is where you want the entire toolchain to live
	#The script here is derived from: http://esp-idf.readthedocs.io/en/latest/linux-setup.html

	BASE=$(pwd)

	echo ""
	echo "[$0]:  Checking for system prerequisites."

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
	echo "[$0]:  Get or update IDF"
	if [ -d esp-idf ]
	then 
		echo "[$0]:  Found esp-idf, updating."
		cd esp-idf 
		git pull && git submodule update --recursive 
		cd $BASE
	else  ## not found, get it
		git clone --recursive https://github.com/espressif/esp-idf.git
	fi

	## Perform mandatory removal of any tar files in case of a previous error
	if [ -f *.tar.gz ] || [ -f *.tar.gz.* ]
	then
		echo ""
		echo "[$0]:  Removing residual tar file(s)"
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
	echo "[$0]:  Setup environment variables"
	echo "[$0]:  Exporting environment variables:"
	export IDF_PATH=${BASE}/esp-idf
	echo "[$0]:  export IDF_PATH=${BASE}/esp-idf"
	export PATH=$PATH:${BASE}/xtensa-esp32-elf/bin
	echo "[$0]:  export PATH=$PATH:${BASE}/xtensa-esp32-elf/bin"

		##move the project folders to narra directory:
		mkdir narra

		##eddystone
		mv ble_app_eddystone narra
		
		##nodejs
		mkdir esp32-nodejs-app
		mv listenNode.sh esp32-nodejs-app
		mv listen-notification.js esp32-nodejs-app
		mv gatt_server_notif_switch esp32-nodejs-app
		mv esp32-nodejs-app narra

echo "[$0]: BUILD SUCCESSFUL"
echo ""
pwd
echo ""
ls
echo ""
	##read user action after completing building the framework
	custom_app_instructions
		
	read action
		##eddystone	
		if [ $action = build_eddystone_app ]
		then
			build_eddystone_app
			
		#nodejs_app		
		elif [ $action = build_nodejs_app ]
		then
			build_nodejs_app
			
		#quit	
		elif [ $action = quit ]
		then
		echo ""
		echo "[$0]: Bitsoko ESP32 script terminated"
		echo ""
		fi

}
##end of function
		
		#FUNCTION: compile and flash custom app to the ESP32
		build_app(){
		echo ""
		echo "[$0]:  This compiles and flashes the project into the ESP32."
		echo "[$0]: NOTE: You should run this function from the working directory."

	#compiling and flashing project binaries
		##Allow read and write access to USB device
		echo ""
		echo "[$0]:  Setup access to USB device: "
		sudo chmod a+rw /dev/ttyUSB0

		##configure project
		echo ""
		echo "[$0]:  Run configuration menu"
		make menuconfig

		##erase and flash current project to ESP and run serial monitor to view results
		echo ""
		echo "[$0]:  Erase everything on device then flash the current project"
		make erase_flash flash

echo "[$0]: BUILD SUCCESSFUL"
echo ""
pwd
echo ""
ls
echo ""
	
	}
##end of function

		##FUNCTIONS: building custom apps
		build_eddystone_app(){
		##run path_config to set up environment variables
		. path_config.sh
		cd narra/ble_app_eddystone
		echo ""
		pwd
		echo ""
		ls
		echo ""
		build_app
		make monitor

		
		}

		build_nodejs_app(){
		##run path_config to set up environment variables
		. path_config.sh
		echo ""
		pwd
		echo ""
		ls
		echo ""		
		echo ""

		echo "APP BUILD INSTRUCTIONS"
		echo ""
		echo "[$0]: Run 'listenNode.sh' in the terminal that opens AFTER app has been built successfully. This script will open a serial monitor to show the notification dialog box that detects action on the ESP."
		
		cd narra/esp32-nodejs-app/gatt_server_notif_switch
		build_app
		##open separate terminal  created by the "listenNode.sh"
		gnome-terminal
		make monitor

		}

		##any other build function goes here
		####################################

#Build instructions

		custom_app_instructions(){
			echo ""
			echo "[$0]: 2. Run 'build_eddystone_app' to compile and flash the eddystone project to the ESP32."
			echo ""
			echo "[$0]: 3. Run 'build_nodejs_app' to compile and flash the nodejs_app project to the ESP32."
			echo ""
			echo "[$0]: 4. Run 'quit' to quit."
			echo ""		

}


echo ""
echo "[$0]:  PROJECT BUILD INSTRUCTIONS"
echo ""
echo "NOTE: All commands should be run from the current directory, and custom apps can only be build after the framework has been setup."
echo ""
echo "What would you like to do?"
echo ""
echo "[$0]: 1. Run 'build_framework' to setup the development framework for ESP32 in the working directory."
echo ""
echo "[$0]: 2. Run 'build_eddystone_app' to compile and flash the eddystone project to the ESP32."
echo ""
echo "[$0]: 3. Run 'build_nodejs_app' to compile and flash the nodejs_app project to the ESP32."
echo ""
echo "[$0]: 4. Run 'quit' to quit."
echo ""

	read action
		##framework
		if [ $action = build_framework ]
		then
			build_framework
		
		##eddystone	
		elif [ $action = build_eddystone_app ]
		then
			build_eddystone_app
			
		#nodejs_app		
		elif [ $action = build_nodejs_app ]
		then
			build_nodejs_app
			
		#quit	
		elif [ $action = quit ]
		then
		echo ""
		echo "[$0]: Bitsoko ESP32 script terminated"
		echo ""
		fi


##############

