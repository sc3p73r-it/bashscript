#!/bin/bash

# Function to install Zabbix 6.0 using a Bash script.
install_zabbix_6.0() {
    # Add Zabbix repository key.
    wget https://repo.zabbix.com/zabbix/6.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.0-4+ubuntu22.04_all.deb
    dpkg -i zabbix-release_6.0-4+ubuntu22.04_all.deb
    
    # Update package lists.
    sudo apt update

    # Install Zabbix server, frontend, agent, and database.
    sudo apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent -y
    
    # Create a MySQL database for Zabbix.
    sudo mysql -uroot -e "create database zabbix character set utf8 collate utf8_bin;"
    sudo mysql -uroot -e "create user zabbix@localhost identified by 'P@ssw0rd';"
    sudo mysql -uroot -e "grant all privileges on zabbix.* to zabbix@localhost;"
    
    # Import initial schema and data to the database.
    sudo zcat /usr/share/doc/zabbix-sql-scripts/mysql/create.sql.gz | sudo mysql -uzabbix -pP@ssw0rd zabbix

    # Configure Zabbix server.
    sudo sed -i 's/# DBPassword=/DBPassword=P@ssw0rd/' /etc/zabbix/zabbix_server.conf

    # Start Zabbix server and agent services.
    sudo systemctl restart zabbix-server zabbix-agent apache2

    # Enable Zabbix server and agent services to start on boot.
    sudo systemctl enable zabbix-server zabbix-agent apache2

    echo "Zabbix 6.0 has been successfully installed."
}

# Call the function to install Zabbix 6.0.
install_zabbix_6.0
