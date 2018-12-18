#!/bin/bash

# Get pulic IP
public_ip=$(curl -s https://ipinfo.io/ip)
echo Your public IP is $public_ip

# Get XML response
curl https://ipinfo.io/$public_ip
