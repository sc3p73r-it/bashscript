#!/bin/bash

#################################################
#      Script Name = Restart.sh			#
#      Author Name = Sc3p73R			#
#      Email       = sc3p73r@outlook.com 	#
#################################################

# Specify the output file
output_file="/mnt/output.log"

# Function to execute a command with verbose output
execute_command() {
  cmd="$1"
  echo "Running: $cmd"
  $cmd >> "$output_file" 2>&1
  status=$?
  if [ $status -eq 0 ]; then
    echo "Command completed successfully."
  else
    echo "Command failed with exit code $status."
  fi
  echo ""
}

# Execute commands with verbose output
execute_command "sudo pkill -U odoo"
execute_command "sudo /opt/tomcat/bin/shutdown.sh"
execute_command "sudo /opt/tomcat/bin/startup.sh"
execute_command "sudo service odoo-server stop"
execute_command "sudo service odoo-server start"
execute_command "sudo service nginx stop"
execute_command "sudo service nginx start"
