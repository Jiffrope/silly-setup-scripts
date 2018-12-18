#!/bin/bash

# Clear the screen
clear

# Blurb
printf '%s\n' "This script will update your Ubuntu Repos in sources.list to your chosen country code."
printf '%s\n' "Press [CTRL+C] if you don't want to update your repos."
printf '%s\n'

# Geolocate country from public IP
country_code=$(curl -s https://ipinfo.io/country | tr '[:upper:]' '[:lower:]')
printf '%s\n'
printf '%s\n' "Your public IP shows that your country code is "$country_code"."

# Make user choose to use geolocated country code
read -e -p "Do you want to use \""$country_code"\" to find your local Ubuntu Repo? [Y/n]" country_code_yn

# User chooses geolocated country code
if [[ $country_code_yn == "Y" || $country_code_yn == "y" || $country_code_yn == "" ]] ; then
sudo sed -i 's|http://archive|http://'$country_code'.archive|g' /etc/apt/sources.list

else read -p "Not using Geolocated Country Code. Enter your desired two character country code: " man_country_code

# Check if user entered anything
if [[ -z "$man_country_code" ]]; then
printf '%s\n' "No country code entered. Exiting."
exit 1

else sudo sed -i 's|http://archive|http://'$man_country_code'.archive|g' /etc/apt/sources.list
fi
fi
# Run apt get update
printf '%s\n'
printf '%s\n' "Done. Updating your local apt list of available packages."
printf '%s\n'
sudo apt update
