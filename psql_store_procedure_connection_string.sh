#!/bin/bash

##################################################################
# Script Name: Store Procedure Script (Remote Connection)        #
# Author     : Sc3p73R                                           #
# Email      : sc3p73r@outlook.com                               #
##################################################################

# PostgreSQL connection string details
CONNECTION_STRING=postgresql://user:'password'@127.0.0.1:5432/db_name

# Log file location
LOG_FILE="/mnt/log.txt"

# Function to get the current timestamp
timestamp() {
  date +"%Y-%m-%d %H:%M:%S"
}

# List of stored procedures to call
PROCEDURES=(
    "update_payment"
    "update_msrn"
    "reverse_msrn"
    "update_srn"
    "reverse_srn"
    "update_gin"
    "reverse_gin"
    "update_bgin"
    "reverse_bgin"
    "update_bgrn"
    "update_bgrn_qty"
    "update_exchange"
    "update_origin"
    "update_sale_order"
    "sale_order_reverse"
    "update_po"
    "update_internal_transfer_date"
)

# Redirect standard output and error to the log file
exec >> "$LOG_FILE" 2>&1

# Start the log with a timestamp
echo "$(timestamp) - Starting procedure execution."

# Iterate through the list of procedures and call each one
for procedure in "${PROCEDURES[@]}"; do
    echo "$(timestamp) - Executing procedure $procedure:"
    psql "$CONNECTION_STRING" -c "CALL $procedure();"
    if [ $? -eq 0 ]; then
        echo "$(timestamp) - Procedure $procedure executed successfully."
    else
        echo "$(timestamp) - Error executing procedure $procedure."
    fi
done

# End the log with a timestamp
echo "$(timestamp) - Procedure execution completed."