#!/bin/bash

#Must have imagemagick installed
# use homebrew on osx or whatever package manager on linux
printf "Splunk App Icon Generator\n"

#check for argument
if [ $# -eq 0 ]
then
   printf "\nusage: generate_app_icons.sh [source image file]\n\n"
   exit 1
else
   logo=$1
   logo2=$(echo "$logo" | sed -E 's/(.+)\.(.+)/\1_square.\2/g')
fi

#verify log file to convert exists
if ! test -f "$logo"; then
   printf "\nError could not locate source image file.\n"
   exit 1
fi

#establish main variables
images=("appIcon_2x.png" "appIcon.png" "appIconAlt_2x.png" "appIconAlt.png" "appLogo.png" "appLogo_2x.png")
dimensions=("72x72" "36x36" "72x72" "36x36" "160x40" "320x80")
ratio=(0 0 0 0 1 1)

#printf "logo=$logo\nlogo2=$logo2\n"
#exit

#get dimensions from source image
height=$(magick identify -format '%h' $logo)
width=$(magick identify -format '%w' $logo)
echo $logo is $width x $height \(W x H\)

if $height -ge $width; then
      #echo "$height is greater than $width"
      sq_dim=$height
   else
      #echo "$width is greater than $height"
      sq_dim=$width
fi

echo $logo with square dimensions is $sq_dim x $sq_dim \(W x H\)

#build square resize
extent=$sq_dim
extent+=x
extent+=$sq_dim

#create square version of logo
printf "Generating $logo2 with $extent dimensions!\n"
convert $logo -background none -gravity center -extent $extent $logo2

#loop through images and sizes
for i in "${!images[@]}"; do 
   outputname=${images[$i]}
   outputdims=${dimensions[$i]}
   outputratio=${ratio[$i]}
  
   if [ $outputratio = "1" ]
   then
      baseimage=$logo
   else
      baseimage=$logo2
   fi
   printf "\nGenerating: $outputname\nSource: $baseimage\nDimensions: $outputdims\n"
   convert $baseimage -resize $outputdims $outputname

done
