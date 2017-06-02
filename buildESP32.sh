## Author: Elliot Williams
## Modified by : Alois Mbutura and Felix Omwansa

	build_framework() {
	echo ""
	echo "[$0]:  This builds the development framework for the ESP32, and set required variables."
	echo "[$0]: NOTE: You should run this script from within the destination directory."

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

		##move the project folders to narra directory
		mkdir narra
		mv ble_app_eddystone narra
		#source project files
		git clone https://github.com/asukiaaa/esp32-nodejs-samples.git
		git clone https://github.com/asukiaaa/esp32-idf-samples.git

		mv listenNode.sh esp32-nodejs-samples			
		mv esp32-nodejs-samples narra
		mv esp32-idf-samples narra
}

		
#BUILDAPP FUNCTION: TO BE USEFUL LATER
		build_app(){
		echo ""
		echo "[$0]:  This compiles and flashes the project into the ESP32."
		echo "[$0]: NOTE: You should run this function from the working directory."

	#compiling and flashing project binaries
		##Allow read and write access to USB device
		echo ""
		echo "[$0]:  Setup access to USB device: the ESP"
		sudo chmod a+rw /dev/ttyUSB0

		##configure project
		echo ""
		echo "[$0]:  Run configuration menu"
		make menuconfig

		##erase and flash current project to ESP and run serial monitor to view results
		echo ""
		echo "[$0]:  Erase everything on device then flash the current project"
		make erase_flash flash monitor

	}

		build_flash(){
	#building development framework and flash project in one operation
		build_framework
		build_app
}
####################################
#Build instructions
echo ""
echo "[$0]:  PROJECT BUILD INSTRUCTIONS"
echo "Bitsoko ESP32 script initialized. What would you like to do?"
echo ""

echo "[$0]: 1. Run 'build_framework' to build the development framework for ESP32 in the working directory."
##echo "[$0]: 2. Run 'build_app' to compile and flash project in the working directory into the ESP32."
##echo "[$0]: 3. Run 'build_flash' to development framework and flash project in one operation."
echo "[$0]: 4. Run 'quit' to quit."
echo "[$0]: Run 'buildApp.sh' in esp32-idf-samples/gatt_server_notif_switch to flash the node server project to the ESP32."
echo ""
echo "[$0]: FURTHER PROJECT BUILD INSTRUCTIONS"
echo "[$0]: Run 'listenNode.sh' in esp32-nodejs-samples to open a notification dialog for to detect action on the ESP32.sh."
echo "[$0]: In case of errors of path configurations, run 'path_config.sh' in esp32 to set the required variables then try again."

	read action

		if [ $action = build_framework ]
		then
			build_framework
			exit
		elif [ $action = build_app ]
		then
			build_app
			exit
		elif [ $action = build_flash ]
		then
			build_flash
			exit

		elif [ $action = quit ]
		then
			exit
		fi




