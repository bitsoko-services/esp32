##compile and flash project binaries to ESP

		echo ""
		echo "[$0]:  This compiles and flashes the project in the working directory into the ESP32."

#compiling and flashing project binaries

		##Allow read and write access to USB device
		echo ""
		echo "[$0]:  Setup access to USB device... "
		sleep 2
		sudo chmod a+rw /dev/ttyUSB0

		##configure project
		echo ""
		echo "[$0]:  Run configuration menu..."
		sleep 2
		make menuconfig

		##erase and flash current project to ESP and run serial monitor to view results
		echo ""
		echo "[$0]:  Erase everything on device then flash the current project"
		sleep 2
		make erase_flash flash


echo "[$0]: Operation completed."
echo ""
echo "[$0]: Current working directory: "
pwd
echo "[$0]: Current working directory contents: "
ls
echo ""
