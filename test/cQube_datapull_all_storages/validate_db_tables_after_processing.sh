#!/bin/bash

# Set your PostgreSQL container name and credentials
config_file="config_files/config.yml"
#repo_url=$(grep 'repository_url' "$config_file" | awk '{print $2}')

#container_name=$(grep 'db_name' "$config_file" | awk '{print $2}')
container_name="postgres_app"
username=$(grep 'db_user' "$config_file" | awk '{print $2}')
database=$(grep 'db_name' "$config_file" | awk '{print $2}')

status_message=()

echo "$container_name : is container name "

# Check if the container exists
if [ ! "$(sudo docker ps -q -f name=$container_name)" ]; then
    echo "$(tput setaf 1)Error: Container '$container_name' does not exist or is not running.$(tput sgr0)"
    status_message+= echo "$(tput setaf 1)Error: Container '$container_name' does not exist or is not running.$(tput sgr0)"
    exit 1
fi

# Fetch the list of tables from the "datasets" and "dimensions" schemas
datasets_tables=($(sudo docker exec -i $container_name psql -U $username -d $database -t -c "SELECT table_name FROM information_schema.tables WHERE table_schema = 'datasets';"))
dimensions_tables=($(sudo docker exec -i $container_name psql -U $username -d $database -t -c "SELECT table_name FROM information_schema.tables WHERE table_schema = 'dimensions';"))

# Combine tables from both schemas
tables=("${datasets_tables[@]}" "${dimensions_tables[@]}")

# Variable to track if any failure occurred
flag=false

# Connect to PostgreSQL container and check each table for records
for table in "${tables[@]}"; do
    echo "Checking records in '$table'"
    count=$(sudo docker exec -i $container_name psql -U $username -d $database -t -c "SELECT count(*) FROM $table;")

    if [ "$count" -eq 0 ]; then
        status_message+= echo "$table"
        echo "$(tput setaf 1)Fail: No records found in '$table'$(tput sgr0)"
        flag=true
    else
        echo "$(tput setaf 2)Pass: Records found in '$table'$(tput sgr0)"
        echo "Count: $count"
    fi

    echo
done

for message in "${status_message[@]}"; do
    echo "$message is not having records"
done

# Display the final result
if [ "$flag" = true ]; then
    echo "$(tput setaf 1) Some of the tables in datasets or dimensions do not have records in the DataBase $(tput sgr0)"
    exit 1
else
    echo "$(tput setaf 2)All checks passed successfully.$(tput sgr0)"
fi

