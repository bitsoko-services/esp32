## Author: Elliot Williams
## Modified by : Alois Mbutura

## BASE variable-This is where you want the entire toolchain to live
## You should run this script from within the destination directory, or redefine the BASE variable to fit your lifestyle.

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
	rm *.tar.gz
	rm *.tar.gz.*
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
	tar xvzf xtensa-esp32-elf-linux64-1.22.0-61-gab8375a-5.2.0.tar.gz && \
	rm *.tar.gz && rm *.tar.gz.*
else
	wget https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-61-gab8375a-5.2.0.tar.gz
	tar xvzf xtensa-esp32-elf-linux64-1.22.0-61-gab8375a-5.2.0.tar.gz && \
	rm xtensa-esp32-elf-linux64-1.22.0-61-gab8375a-5.2.0.tar.gz
fi

## Get demo application
echo ""
echo "[$0]:  Get demo application"
if [ -d esp-idf-template ]
then 
	echo "[$0]:  Found esp-idf-template, updating."
	cd esp-idf-template 
	git pull 
	cd $BASE
else  ## not found, get it
	git clone https://github.com/espressif/esp-idf-template.git
fi

## Setup environment variables:
##  Works for _this_ directory structure.  You will need to change these if you deviate
## Also, you might copy these lines into a separate script  to reset these variables as necessary.

echo ""
echo "Setup environment variables"
echo "[$0]:  Exporting environment variables:"
export IDF_PATH=${BASE}/esp-idf
echo "[$0]:  export IDF_PATH=${BASE}/esp-idf"
export PATH=$PATH:${BASE}/xtensa-esp32-elf/bin
echo "[$0]:  export PATH=$PATH:${BASE}/xtensa-esp32-elf/bin"

echo ""
echo "[$0]:  IDF demo instructions"
echo "[$0]:  [1] cd $BASE/esp-idf-template and"
echo "[$0]:  [2] Type make menuconfig or make flash to get started"
