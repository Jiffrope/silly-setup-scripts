#!/bin/bash
# Check for sudo
is_sudo=$(id -u)
if [[ $is_sudo -ne 0 ]] ; then
printf '%s\n' "Please run this script as root or with sudo".
else
printf '%s\n' "Yay, Superuser!"
fi
printf '%s\n' "Heres a random password"
< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-20};echo;
