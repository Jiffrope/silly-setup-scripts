#!/bin/bash
# Check if suer is already setup
read -e -p "Is there already a non-root user with sudo privileges? [Y/n]" existing_yn

# Check to setup SSH for existing user
if [[ $existing_yn == "Y" || $existing_yn == "y" || $existing_yn == "" ]] ; then
read -e -p "Do you want to setup SSH and SFTP for that user? [Y/n]" existing_ssh_yn
if [[ $existing_ssh_yn == "Y" || $existing_ssh_yn == "y" || $existing_ssh_yn == "" ]] ; then
read -e -p "Is it for the user that is currently logged in? [Y/n]" current_ssh_yn
if [[ $current_ssh_yn == "Y" || $current_ssh_yn == "y" || $current_ssh_yn == "" ]] ; then

# Setup SSH for current user
home_directory="$(eval echo ~${USER})"
mkdir --parents "${home_directory}/.ssh"
chmod 0700 "${home_directory}/.ssh"
# Commented out as copying root's authorized key ain't setup
#chmod 0600 "${home_directory}/.ssh/authorized_keys"
chown --recursive "${USER}":"${USER}" "${home_directory}/.ssh"
else

# Get chosen username
read -e -p "Which user do you want SSH and SFTP setup for?" chosen_user_ssh

# Setup SSH for chosen username
home_directory="$(eval echo ~${chosen_user_ssh})"
mkdir --parents "${home_directory}/.ssh"
chmod 0700 "${home_directory}/.ssh"
# Commented out as copying root's authorized key ain't setup
#chmod 0600 "${home_directory}/.ssh/authorized_keys"
chown --recursive "${chosen_user_ssh}":"${chosen_user_ssh}" "${home_directory}/.ssh"

# Exit
fi
fi

# Create new sudo user with user selected username
else
read -e -p "Enter your new username" username
useradd --create-home --shell "/bin/bash" -- groups sudo "${username}"
chage --lastday o "${username}"
home_directory="$(eval echo ~${username})"
mkdir --parents "${home_directory}/.ssh"
chmod 0700 "${home_directory}/.ssh"
# Commented out as copying root's authorized key ain't setup
#chmod 0600 "${home_directory}/.ssh/authorized_keys"
chown --recursive "${username}":"${username}" "${home_directory}/.ssh"
fi
printf '%s\n' "Adding SSH to UFW and enabling firewall"

# Add SSH rule to UFW and enable
# Check for superuser privileges first
is_sudo=$(id -u)
if [[ $is_sudo == "0" ]] ; then
ufw allow OpenSSH
ufw enable
else
sudo ufw allow OpenSSH
sudo ufw enable
fi
