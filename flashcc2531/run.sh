#!/bin/bash
echo "Start Router Firmware Flash"
cd /flash_cc2531
if ! ./cc_chipid | grep "ID = b524"; then echo "ChipID not found." && exit 1; fi

echo "Downloading firmware"
if ! wget https://github.com/Koenkk/Z-Stack-firmware/raw/master/router/Z-Stack_Home_1.2/bin/CC2531_router_2020_09_29.zip; then echo "firmware not found" && exit 1; fi

echo "unziping"
if ! 7z x CC2531_router_2020_09_29.zip; then echo "unzip failed" && exit 1; fi

echo "backup firmware"
./cc_read save.hex
if ! cp save.hex /backup/save_$(date +%s).hex; then echo "could not backup firmware" && exit 1; fi

echo "erase"
./cc_erase

echo "flash firmware"
./cc_write router-cc2531-diag.hex

echo "Finished"
