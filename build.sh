#!/bin/bash

# Automatic Building Script
# for LineageOS
#
# Description:
# Script for making building Android ROMs easier,
# without our ingerention and without additional
# power consuption while building it at night.
#
# Author:
# Krzysztof Czaja
# https://www.czaja.online

# build eagle -p ~/android/lineage -s

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

path="~/android/lineage"
repo_sync=false
ram=4G
shutdown=false

echo "Starting work with Automatic Building Script";

while getopts ":m:p:rsh" option do
	case "${option}" in
		"h") echo "example: build device -m 6G -r rom_name -s" 
		     echo "-m 4G - defines 4GB ram for building,"
		     echo "-p path_to_your_rom_directory - default path is"
		     echo "~/android/lineage. Change it using this argument,"
		     echo "-r - will make repo sync first, then build,"
		     echo "-s - will shutdown your computer after building."
		     exit 1;;

		"m") ram=${OPTARG};;

		"p") path=${OPTARG};;

		"r") repo_sync=true;;

		"s") shutdown=true;;

		":") echo "No argument value for option $OPTARG";;

		 * ) echo "No such argument! For help do build -h.";;
	esac
done

if [ $1 = "" ]; then
	echo "You need to specify device. For help do build -h";;

echo "Entering main directory" > $DIR/log.txt;
cd $path;

echo "Preparing enviroment" >> $DIR/log.txt;
source build/envsetup.sh >> $DIR/log.txt;

if [ repo_sync=true ]; then
	echo "Syncing repos" >> $DIR/log.txt;
	repo sync >> $DIR/log.txt;
fi

echo "Configuring Jack" >> $DIR/log.txt;
export ANDROID_JACK_VM_ARGS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx$ram" >> $DIR/log.txt;

echo "Building ROM for $1";
brunch $1 && echo "Successfull building" || echo "Error while building" && tee lineage_log.txt;

if [ shutdown=true ]; then
	echo "Turning off your computer in 60s." >> $DIR/log.txt;	
	shutdown -h 60s >> $DIR/log.txt;
fi
