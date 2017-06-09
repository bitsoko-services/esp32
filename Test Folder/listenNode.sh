## Author: Felix Omwansa

##return to project directory
cd .. 

#installs noble
echo ""
echo "[$0]:  installing noble using install_noble.sh..."


. install_noble.sh

##run notification dialog
echo ""
echo "[$0]:  This will open a notification dialog to detect action on the ESP32.sh"
echo ""
sudo node listen-notification.js
