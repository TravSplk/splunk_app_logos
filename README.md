# splunk_app_logos

Simple script for sizing Splunk app logos. It will take a rectangular image and determine how to make a square version and appropriately resized icons for your app as defined here: https://dev.splunk.com/enterprise/docs/developapps/manageknowledge/configureappproperties/#Add-icons-to-your-app

## Requirements
1. ImageMagick - https://imagemagick.org/

## Instructions
1. Download script file
1. Ensure script is executable `sudo chmod +x ./generate_app_icons.sh`
1. Execute script `./generate_app_icons.sh [source image]`

## Notes
1. This was only tested with `png` files, so no guarantees that it will work with others.