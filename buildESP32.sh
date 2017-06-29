
## Author: Elliot Williams
## Modified by : Alois Mbutura and Felix Omwansa
#v2 of Bitsoko buildESP32 script: edited to separate functional blocks into separate scrip files

echo ""
echo "[$0]: Bitsoko ESP32 script initialized"
echo "[$0]:  BUILD INSTRUCTIONS:"

	##print instructions	
	. action_prompts.sh
	finished=false


	while [ "$finished" != "true" ]; do
		read action
		##framework
		if [ $action = 1 ]
		then
		. setup_framework.sh 
		. action_prompts.sh
		finished=false
		continue

		##eddystone	
		elif [ $action = 2 ]
		then
		. build_eddystone.sh
		. action_prompts.sh			
		finished=false

		#nodejs_app		
		elif [ $action = 3 ]
		then
		. build_nodejs.sh
		. action_prompts.sh			
		finished=false

		#quit	
		elif [ $action = 4 ]
		then
		echo ""
		echo "[$0]: Bitsoko ESP32 script terminated"
		echo ""
		sleep 3
		break
		fi

	done

#########################################
