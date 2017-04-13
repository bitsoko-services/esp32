############################################################
# Dockerfile to build esp32 container
## Author: Alois Mbutura
## Modified by : Allan Juma

#run with docker run -t -i --device=/dev/ttyUSB0 ubuntu bash
#The script here is derived from: http://esp-idf.readthedocs.io/en/latest/linux-setup.html

############################################################

# Set the base image to Ubuntu
FROM ubuntu:16.04

# File Author / Maintainer
MAINTAINER bitsoko@bitsoko.io

# Update the repository sources list
RUN apt-get update

################## BEGIN INSTALLATION ######################

RUN BASE=$(pwd)

RUN apt-get update && apt-get install -y git make libncurses-dev flex bison gperf python python-serial wget --fix-missing

# Get or update IDF
RUN echo "[$0]:  Get or update IDF"
RUN if [ -d esp-idf ]; then echo "[$0]:  Found esp-idf, updating." && cd esp-idf && git pull && git submodule update --recursive && cd $BASE; else git clone --recursive https://github.com/espressif/esp-idf.git; fi

## Perform mandatory removal of any tar files in case of a previous error
RUN if [ -f *.tar.gz ] || [ -f *.tar.gz.* ]; then echo "[$0]:  Removing residual tar file(s)" && rm *.tar.gz 2>/dev/null && rm *.tar.gz.* 2>/dev/null; fi

## Get 64 bit linux binary toolchain -- this might get out of date when they change blobs:
## Current version 1.22.0-61-gab8375a-5.2.0
RUN if [ -d xtensa-esp32-elf ]; then echo "[$0]:  Found ESP32 binary toolchain. Performing mandatory replacement." && echo "[$0]:  Current version at the making of this makefile 1.22.0-61-gab8375a-5.2.0" && echo "[$0]:  Check current version from http://esp-idf.readthedocs.io/en/latest/linux-setup.html" && rm -rf xtensa-esp32-elf && wget https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-61-gab8375a-5.2.0.tar.gz && tar -xvzf xtensa-esp32-elf-linux64-1.22.0-61-gab8375a-5.2.0.tar.gz; else wget https://dl.espressif.com/dl/xtensa-esp32-elf-linux64-1.22.0-61-gab8375a-5.2.0.tar.gz && tar -xvzf xtensa-esp32-elf-linux64-1.22.0-61-gab8375a-5.2.0.tar.gz && rm *.tar.gz; fi

## Get demo application
RUN echo "[$0]:  Get demo application" && if [ -d esp-idf-template ]; then echo "[$0]:  Found esp-idf-template, updating." && cd esp-idf-template && git pull &&  cd $BASE; else  git clone https://github.com/espressif/esp-idf-template.git; fi

## Setup environment variables:
##  Works for _this_ directory structure.  You will need to change these if you deviate
## Also, you might copy these lines into a separate script  to reset these variables as necessary.

RUN echo "[$0]:  Setup environment variables"

ENV IDF_PATH ${BASE}/esp-idf
RUN echo "[$0]:  export IDF_PATH=${BASE}/esp-idf"


ENV PATH "$PATH:${BASE}/xtensa-esp32-elf/bin"
RUN echo "[$0]:  export PATH=$PATH:${BASE}/xtensa-esp32-elf/bin"

RUN echo ""
RUN echo "[$0]:  IDF demo instructions"
RUN echo "[$0]:  [1] cd $BASE/esp-idf-template and"
RUN echo "[$0]:  [2] Type make menuconfig or make flash to get started"
