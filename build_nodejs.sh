##PART1


		cd $BASE
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
		echo "[$0]: Run 'listenNode.sh' in the terminal that opens AFTER this app has been built successfully. This script will open a serial monitor to show the notification dialog box that detects action on the ESP."
		
		cd narra/esp32-nodejs-app/gatt_server_notif_switch
		. build_app.sh
		cd $BASE

		##open separate terminal to run "listenNode.sh"
		echo ""
		echo "[$0]: Run 'listenNode.sh' in the terminal that opens AFTER this app has been built successfully. This script will open a serial monitor to show the notification dialog box that detects action on the ESP."	
		gnome-terminal
		make monitor
		
	
