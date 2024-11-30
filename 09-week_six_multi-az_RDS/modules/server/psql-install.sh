#!/bin/bash
sudo dnf update -y && sudo dnf upgrade -y
#install psql
sudo dnf install -y postgresql-server
sudo postgresql-setup --initdb
sudo systemctl start postgresql
sudo systemctl enable postgresql

