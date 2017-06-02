## Author: Felix Omwansa
 
echo ""
echo "[$0]: This file should be run in the directory where the project is located. 
Paste and run it in the directory, although this is done automatically from buildESP32.sh"

##Allow read and write access to USB device
echo ""
echo "[$0]:  Setup access to USB device"
sudo chmod a+rw /dev/ttyUSB0

##configure project
echo ""
echo "[$0]:  Run configuration menu"
make menuconfig

##erase and flash current project to ESP and run serial monitor to view results
echo ""
echo "[$0]:  Erase everything on device then flash the current project"
make erase_flash flash monitor


