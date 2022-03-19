#!/bin/bash
sudo apt update
curl -sL https://deb.nodesource.com/setup_16.x | bash -
sudo apt install nodejs git nginx build-essential apache2-utils -y