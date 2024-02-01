#!/bin/bash

txtreset=$(tput sgr0) # Text reset
txtred=$(tput setaf 1) # Red
txtgreen=$(tput setaf 10) # Green
txtblue=$(tput setaf 6) # Blue


check_ingest_app(){
# Connect to Docker container
sudo docker exec -it ingest_app sh -c '

# Inside the Docker container

# Check if .env file exists
if [ -e .env ]; then
    echo -e "${txtgreen}The .env file is present in the ingest_app  container.${txtreset}"
else
    echo "${txtred}Error: The .env file is not found in the ingest_app container.${txtreset}"
fi

# Exit from Docker container
exit
'
# Continue with the rest of the script after exiting the container
echo "${txtgreen}Back outside the Ingest_App Docker container. Continue with the rest of the script.${txtreset}"
}


check_spec_app(){
# Connect to Docker container
sudo docker exec -it spec_app sh -c '

# Inside the Docker container

# Check if .env file exists
if [ -e .env ]; then
    echo -e "${txtgreen}The .env file is present in the spec_app container.${txtreset}"
else
    echo "${txtred}Error: The .env file is not found in the spec_app container.${txtreset}"
fi

# Exit from Docker container
exit
'
# Continue with the rest of the script after exiting the container
echo "${txtgreen}Back outside the Spec_App Docker container. Continue with the rest of the script.${txtreset}"
}


txtred=$(tput setaf 1)
txtgreen=$(tput setaf 2)
txtreset=$(tput sgr0)

check_nifi_app(){
    # Connect to Docker container
    sudo docker exec -it nifi_app bash -c '

    # Inside the Docker container

    # Print current directory
    echo "Current Directory: $(pwd)"

    # Check if ansible folder exists
    if [ -e adapter ]; then
        echo -e "${txtgreen}The ansible folder is present in the nifi_app  container.${txtreset}"
    else
        echo "${txtred}Error: The ansible folder is not found in the nifi_app container.${txtreset}"
    fi

    # Exit from Docker container
    exit
    '
    
    # Continue with the rest of the script after exiting the container
    echo "${txtgreen}Back outside the Nifi_App Docker container. Continue with the rest of the script.${txtreset}"
}


check_admin_dashboard_app(){
# Connect to Docker container
sudo docker exec -it admin_dashboard_app sh -c '

# Inside the Docker container

# Check if .env file exists
if [ -e .env ]; then
    echo -e "${txtgreen}The .env file is present in the admin_dashboard container.${txtreset}"
else
    echo "${txtred}Error: The .env file is not found in the admin_dashboard container.${txtreset}"
fi

# Exit from Docker container
exit
'
# Continue with the rest of the script after exiting the container
echo "${txtgreen}Back outside the Admin Dashboard Docker container. Continue with the rest of the script.${txtreset}"
}


check_generator_app(){
    # Connect to Docker container
    sudo docker exec -it generator_app bash -c '

    # Inside the Docker container

    # Print current directory
    echo "Current Directory: $(pwd)"

    # Check if ansible folder exists
    if [ -e adapter ]; then
        echo -e "${txtgreen}The ansible folder is present in the generator_app container.${txtreset}"
    else
        echo "${txtred}Error: The ansible folder is not found in the generator_app container.${txtreset}"
    fi

    # Exit from Docker container
    exit
    '

    # Continue with the rest of the script after exiting the container
    echo "${txtgreen}Back outside the Generator_App Docker container. Continue with the rest of the script.${txtreset}"
}


check_querybuilder_app(){
# Connect to Docker container
sudo docker exec -it querybuilder_app sh -c '

# Inside the Docker container

# Check if .env file exists
if [ -e .env ]; then
    echo -e "${txtgreen}The .env file is present in the querybuilder_app container.${txtreset}"
else
    echo "${txtred}Error: The .env file is not found in the querybuilder_app container.${txtreset}"
fi

# Exit from Docker container
exit
'
# Continue with the rest of the script after exiting the container
echo "${txtgreen}Back outside the queryBuilder_App Docker container. Continue with the rest of the script.${txtreset}"
}


check_ingest_app
check_spec_app
check_nifi_app
check_admin_dashboard_app
check_generator_app
check_querybuilder_app


