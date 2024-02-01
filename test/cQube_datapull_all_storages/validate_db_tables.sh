#!/bin/bash

# Set your PostgreSQL container name and credentials
config_file="config_files/config.yml"


container_name="postgres_app"

username=$(grep 'db_user' "$config_file" | awk '{print $2}')
database=$(grep 'db_name' "$config_file" | awk '{print $2}')


status_message=()

# Check if the container exists
if [ ! "$(sudo docker ps -q -f name=$container_name)" ]; then
    echo "$(tput setaf 1)Error: Container '$container_name' does not exist or is not running.$(tput sgr0)"
    status_message+= echo "$(tput setaf 1)Error: Container '$container_name' does not exist or is not running.$(tput sgr0)"
    exit 1
fi

# Define the list of schemas
schemas=("emission" "information_schema" "ingestion" "public" "spec" "transformers")

# Variable to track if any failure occurred
flag=false

# Connect to PostgreSQL container and execute SQL queries
for schema in "${schemas[@]}"; do
    echo "Checking tables in '$schema' schema"
    result=$(sudo docker exec -i $container_name psql -U $username -d $database -t -c "SELECT table_name FROM information_schema.tables WHERE table_schema = '$schema';")
    
    if [ -z "$result" ]; then
	status_message+= echo "$schema"
        echo "$(tput setaf 1)Fail: No tables found in '$schema' schema$(tput sgr0)"
        flag=true
    else
        echo "$(tput setaf 2)Pass: Tables found in '$schema' schema$(tput sgr0)"
        echo "$result"
    fi

    echo
done


for message in "${status_message[@]}"; do
    echo "$message is not having tables"
done

# Display the final result
if [ "$flag" = true ]; then
    echo "$(tput setaf 1) Some of Tables are not created in the DataBase $(tput sgr0)"
    exit 1
else
    echo "$(tput setaf 2)All checks passed successfully.$(tput sgr0)"
fi

