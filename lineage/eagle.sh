#./bin/bashrc.sh

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

$path = "~/android/lineage"
$branch = "lineage"
$revision = "cm-14.1"
$recovery = "twrp"

echo "Starting work with Automatic Building Script";
cd $path;
