##build eddystone project

		
		cd $BASE
		##run path_config to set up environment variables
		. path_config.sh
		cd narra/ble_app_eddystone
		echo ""
		pwd
		echo ""
		ls
		echo ""
		. build_app.sh
		make monitor
		cd $BASE

echo "[$0]: Operation completed."
echo ""
echo "[$0]: Current working directory: "
pwd
echo "[$0]: Current working directory contents: "
ls
echo ""
