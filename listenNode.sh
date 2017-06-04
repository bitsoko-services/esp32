## Author: Felix Omwansa

echo ""
echo "[$0]:  This will open a notification dialog to detect action on the ESP32.sh"

cd .. 

#installs noble
. install_noble.sh


##run notification dialog
sudo node listen-notification.js
