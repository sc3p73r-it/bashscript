#!/bin/bash

##################################################################
# Script Name: Store Procedure Script                            #
# Author     : Sc3p73R                                           #
# Email      : sc3p73r@outlook.com                               #
##################################################################

# PostgreSQL connection details
PG_USER="YOUR_USER"
PG_PASSWORD="YOUR_PASSWORD"
PG_DATABASE="DATABASE_NAME"

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
    psql -U $PG_USER -d $PG_DATABASE -c "CALL $procedure();"
    if [ $? -eq 0 ]; then
        echo "$(timestamp) - Procedure $procedure executed successfully."
    else
        echo "$(timestamp) - Error executing procedure $procedure."
    fi
done

# End the log with a timestamp
echo "$(timestamp) - Procedure execution completed."