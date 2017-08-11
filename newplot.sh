#!/bin/bash

#------------------------------------------------------------------------------
# Name:		newplot
# version:	0.1
# Purpose:	Create sample plot script for gnuplot
# Author: 	Jerry Weng yangyang.weng@gmail.com
# License:	GNU General Public License v3.0
# 			https://www.gnu.org/licenses/gpl-3.0.en.html
#------------------------------------------------------------------------------

# takes a string and returns true if it seems to represent "yes"
function isYes() {
  local x=$1
  [ $x = "y" ] && echo $TRUE; return
  [ $x = "Y" ] && echo $TRUE; return
  [ $x = "yes" ] && echo $TRUE; return
echo $FALSE
}

# Default answer of creating new plot script
_name="plot"
_grid="y"
_format="png"
_font="Verdana,10"
_output="output."

# Collect information
read -e -p "Name of your script: " -i ${_name} name
read -p "Description: " description
read -p "Title: " title
read -p "xlabel: " xlabel
read -p "ylabel: " ylabel
read -e -p "grid [y/n]: " -i ${_grid} grid
read -e -p "Format: " -i ${_format} format
read -e -p "Font: " -i ${_font} font
read -e -p "Output name: " -i ${_output}${format} output

# Check whether script name exist
if [[ -e ${name}.gp ]]
then
	echo ""
	read -e -p "${name}.gp is exist. Do you want to overwrite? [y/n]" overwrite

	if [ "$(isYes ${overwrite})" = "$TRUE" ]; then
		rm ${name}.gp
	fi
fi

# Add desription to script if exist
if [[ -n ${description} ]]
then
	echo "# ${description}" >> ${name}.gp
fi

# Create plot script
cat <<EOT >> ${name}.gp
reset
set title '${title}'
set xlabel '${xlabel}'
set ylabel '${ylabel}'
set term ${format} enhanced font '${font}'
set output '${output}'
EOT

# Setup grid as user decided
if [[ -n ${grid} ]]
then
	echo "set grid" >> ${name}.gp
fi

# Success information
echo ""
echo "Your plot is created!!"