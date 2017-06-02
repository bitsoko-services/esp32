deps_config := \
	/home/omwansa/Desktop/BITSOKO/ESP32/TestFolder/esp32/esp-idf/components/aws_iot/Kconfig \
	/home/omwansa/Desktop/BITSOKO/ESP32/TestFolder/esp32/esp-idf/components/bt/Kconfig \
	/home/omwansa/Desktop/BITSOKO/ESP32/TestFolder/esp32/esp-idf/components/esp32/Kconfig \
	/home/omwansa/Desktop/BITSOKO/ESP32/TestFolder/esp32/esp-idf/components/ethernet/Kconfig \
	/home/omwansa/Desktop/BITSOKO/ESP32/TestFolder/esp32/esp-idf/components/fatfs/Kconfig \
	/home/omwansa/Desktop/BITSOKO/ESP32/TestFolder/esp32/esp-idf/components/freertos/Kconfig \
	/home/omwansa/Desktop/BITSOKO/ESP32/TestFolder/esp32/esp-idf/components/log/Kconfig \
	/home/omwansa/Desktop/BITSOKO/ESP32/TestFolder/esp32/esp-idf/components/lwip/Kconfig \
	/home/omwansa/Desktop/BITSOKO/ESP32/TestFolder/esp32/esp-idf/components/mbedtls/Kconfig \
	/home/omwansa/Desktop/BITSOKO/ESP32/TestFolder/esp32/esp-idf/components/openssl/Kconfig \
	/home/omwansa/Desktop/BITSOKO/ESP32/TestFolder/esp32/esp-idf/components/spi_flash/Kconfig \
	/home/omwansa/Desktop/BITSOKO/ESP32/TestFolder/esp32/esp-idf/esp32-idf-samples/gatt_server_notif_switch/main/Kconfig \
	/home/omwansa/Desktop/BITSOKO/ESP32/TestFolder/esp32/esp-idf/components/bootloader/Kconfig.projbuild \
	/home/omwansa/Desktop/BITSOKO/ESP32/TestFolder/esp32/esp-idf/components/esptool_py/Kconfig.projbuild \
	/home/omwansa/Desktop/BITSOKO/ESP32/TestFolder/esp32/esp-idf/components/partition_table/Kconfig.projbuild \
	/home/omwansa/Desktop/BITSOKO/ESP32/TestFolder/esp32/esp-idf/Kconfig

include/config/auto.conf: \
	$(deps_config)


$(deps_config): ;
