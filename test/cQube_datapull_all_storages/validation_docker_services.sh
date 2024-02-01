#!/bin/bash

txtreset=$(tput sgr0) # Text reset
txtred=$(tput setaf 1) # Red
txtgreen=$(tput setaf 10) # Green
txtblue=$(tput setaf 6) # Blue

fail_flag=0

# Function to check if the docker microservice is running or not
check_docker_services_status() {
    echo "${txtblue}Checking if $1 ms is running${txtreset}"
    sudo docker ps | grep "$1"
    if [ $? -eq 0 ]; then
        echo "${txtgreen}$1 ms service is running${txtreset}"
    else
        echo "${txtred}$1 ms service is not running${txtreset}"
        fail_flag=1
    fi
    echo "${txtblue}-----Checking if $1 ms running testing is completed-----${txtreset}"
}

# Function to check if docker network cqube_net is created
check_docker_network() {
    echo "${txtblue}Checking if docker network cqube_net is created${txtreset}"
    sudo docker network ls | grep cqube_net
    if [ $? -eq 0 ]; then
        echo "${txtgreen}docker network is created${txtreset}"
    else
        echo "${txtred}docker network is not created${txtreset}"
        fail_flag=1
    fi
    echo "${txtblue}-----Checking if docker network got created testing is completed-----${txtreset}"
}

# Function to check if the docker volumes got created
check_docker_volume_status() {
    echo "Checking if ansible_$1 volume creation testing started"
    sudo docker volume ls | grep $1
    if [ $? -eq 0 ]; then
        echo "${txtgreen}$1 volume created${txtreset}"
    else
        echo "${txtred}$1 volume not created${txtreset}"
        fail_flag=1
    fi
    echo "${txtblue}-----Checking if ansible_$1 creation testing completed-----${txtreset}"
}

# Function to check if .env is created and not empty
check_env_file_status() {
    echo "${txtblue}Checking if .env is created${txtreset}"
    sudo docker exec -it -u root spec_app sh
    if [ -z "$(cat .env)" ]; then
        echo "${txtred}.env is empty${txtreset}"
        fail_flag=1
    else
        echo "${txtgreen}.env exists and is not empty${txtreset}"
    fi
}

# Function to check if config.ini exists and is not empty
check_config_file_exists_and_has_variables() {
    echo "${txtblue}Checking if config.ini exists and has variables${txtreset}"
    sudo docker exec -it -u root generator_app sh
    if [ -z "$(cat config.ini)" ]; then
        echo "${txtred}config.ini is empty${txtreset}"
        fail_flag=1
    else
        echo "${txtgreen}config.ini exists and is not empty${txtreset}"
    fi
}

# Comparing generator volume mounting with nifi volume mounting
check_generator_nifi_volumes() {
    mkdir source_container_folder
    mkdir destination_container_folder
    sudo docker cp generator_app:/python_app/adapter source_container_folder
    sudo docker cp nifi_app:/opt/nifi/nifi-current/adapter destination_container_folder
    diff -q source_container_folder/adapter destination_container_folder/adapter

    if [ $? -eq 0 ]; then
        echo "${txtgreen}Success: Mounted volumes have the same content${txtreset}"
    else
        echo "${txtred}Error: Mounted volumes have different content${txtreset}"
        fail_flag=1
    fi

    sudo rm -r source_container_folder destination_container_folder
}

echo -e "\033[1;33m Checking monitoring_prometheus App Docker Service\033[0m"
check_docker_services_status monitoring_prometheus
echo -e "\033[1;33m Checking monitoring_pushgateway App Docker Service\033[0m"
check_docker_services_status monitoring_pushgateway
echo -e "\033[1;33m Checking monitoring_nodeexporter App Docker Service\033[0m"
check_docker_services_status monitoring_nodeexporter
echo -e "\033[1;33m Checking monitoring_pushgateway App Docker Service\033[0m"
check_docker_services_status monitoring_pushgateway
echo -e "\033[1;33m Checking monitoring_cadvisor App Docker Service\033[0m"
check_docker_services_status monitoring_cadvisor
echo -e "\033[1;33m Checking monitoring_grafana App Docker Service\033[0m"
check_docker_services_status monitoring_grafana
echo -e "\033[1;33m Checking kong_app App Docker Service\033[0m"
check_docker_services_status kong_app
echo -e "\033[1;33m Checking admin_dashboard_app App Docker Service\033[0m"
check_docker_services_status admin_dashboard_app
echo -e "\033[1;33m Checking csvParser_app App Docker Service\033[0m"
check_docker_services_status csvParser_app
echo -e "\033[1;33m Checking nginx_app App Docker Service\033[0m"
check_docker_services_status nginx_app
echo -e "\033[1;33m Checking Postgres App Docker Service\033[0m"
check_docker_services_status postgres_app
echo -e "\033[1;33m Checking NIFI App Docker Service\033[0m"
check_docker_services_status nifi_app
echo -e "\033[1;33m Checking Ingest App Docker Service\033[0m"
check_docker_services_status ingest_app
echo -e "\033[1;33m Checking Spec App Docker Service\033[0m"
check_docker_services_status spec_app
echo -e "\033[1;33m Checking Geneator App Docker Service\033[0m"
check_docker_services_status generator_app
echo -e "\033[1;33m Checking Nginx App Docker Service\033[0m"
check_docker_services_status nginx_app
echo -e "\033[1;33m Checking Dashboard App Docker Service\033[0m"
check_docker_services_status dashboard_app
echo -e "\033[1;33m Checking Kong App Docker Service\033[0m"
check_docker_services_status kong_app
echo -e "\033[1;33m Checking QueryBuilder App Docker Service\033[0m"
check_docker_services_status querybuilder_app
echo -e "\033[1;33m Checking Keycloak App Docker Service\033[0m"
check_docker_services_status keycloak_app
echo -e "\033[1;33m Checking Network Docker Service\033[0m"
check_docker_network

check_docker_volume_status python_executable_env
check_docker_volume_status adapter_volume
check_generator_nifi_volumes

if [ $fail_flag -eq 1 ]; then
    echo "${txtred}One or more checks failed. Exiting with failure.${txtreset}"
    exit 1
else
    echo "${txtgreen}All checks passed. Proceeding with success.${txtreset}"
fi

