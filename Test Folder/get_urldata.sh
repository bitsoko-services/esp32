#Author: Felix Omwansa

##buildESP32_update: get data for broadcast_url from Bitsoko server
##Parsing a json response of a url to a file     
                   
	##installing jq: a command-line JSON processor
	echo ""
	echo "[$0]:  installing jq: a command-line JSON processor"
	echo "[$0]:  Checking for system prerequisites and installing the required toochain..."
	sleep 3
	
	echo ""
	#Archlinux
	if [ $(which pacman) ]
	then
		echo "[$0]:  Found archlinux based system."
		sudo pacman -Sy jq
	fi

	#Ubuntu
	if [ $(which apt-get) ]
	then
		echo "[$0]:  Found Ubuntu based system."
		sudo apt-get update
		sudo apt-get install jq
	fi

	#Any other system goes here

	echo ""
	echo "[$0]:	getting json response from Bitsoko server..."
	sleep 3
	RESP=$(curl -s 'https://bitsoko.io/devices/?dID=46e3e4f0c3f8889d' 2>&1 )

	
	echo ""
	echo "[$0]:	creating json file to store response..."
	sleep 3

	if [ -f test.json ] 
	then
		rm test.json
	fi
	#create json file to store response
	echo "${RESP}" | jq . >> test.json
	
	echo "[$0]:	url data : "
	jq -r '.[].name' test.json
	#prints value of 'name'
	sleep 3

