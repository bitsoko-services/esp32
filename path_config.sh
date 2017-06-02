BASE=$(pwd)

echo "[$0]:  Setup environment variables"
	echo "[$0]:  Exporting environment variables:"
	export IDF_PATH=${BASE}/esp-idf
	echo "[$0]:  export IDF_PATH=${BASE}/esp-idf"
	export PATH=$PATH:${BASE}/xtensa-esp32-elf/bin
	echo "[$0]:  export PATH=$PATH:${BASE}/xtensa-esp32-elf/bin"
