#!/bin/bash
#Must have imagemagick installed
# use homebrew on osx or whatever package manager on linux

#establish main variables
app=dhqp
logo=source_logo.png
logo2=source_logo_square.png

images=("appIcon_2x.png" "appIcon.png" "appIconAlt_2x.png" "appIconAlt.png" "appLogo.png" "appLogo_2x.png")
dimensions=("72x72" "36x36" "72x72" "36x36" "160x40" "320x80")
ratio=(0 0 0 0 1 1)

#Nav to folder
cd ../dhqp/static/

#get dimensions from source image
height=$(magick identify -format '%h' source_logo.png)
width=$(magick identify -format '%w' source_logo.png)
echo $logo is $width x $height \(W x H\)

if [ $height -ge $width ]
   then
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
convert source_logo.png -background none -gravity center -extent $extent $logo2

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

cd -
