#!/bin/bash

txtreset=$(tput sgr0) # Text reset
txtred=$(tput setaf 1) # Red
txtgreen=$(tput setaf 10) # Green
txtblue=$(tput setaf 6) # Blue
txtyellow=$(tput setaf 3) # Yellow

overall_status=true

install_basics() {
    sudo apt-get update -y
    sudo apt-get install net-tools -y
}

check_os_version() {
    # Read the value of the VERSION_ID from the os-release file
    VERSION_ID=$(grep DISTRIB_RELEASE /etc/lsb-release | cut -d '=' -f 2)

    # Compare the version with the desired version (22.04)
    if  [[ $VERSION_ID == "22.04" ]]; then
        echo "$txtblue status check1: $txtgreen Operating system version is 22.04. $txtreset"
    else
        echo "$txtblue status check1: $txtred Operating system version is not 22.04. Please make sure to create a VM with Ubuntu 22.04 $txtreset"
        overall_status=false
    fi
}

check_cpu_cores() {
    # Get the number of processing units (CPU cores + threads)
    CPU_CORES=$(nproc)

    if  [ $CPU_CORES -ge "4" ]; then
        echo "$txtblue status check2: $txtgreen Number of CPU cores: $CPU_CORES $txtreset"
    else
         echo "$txtblue status check2: Number of CPU cores is less than the required. Please make sure a 4-core VM is required to deploy cqube $txtreset"
        overall_status=false
    fi
}

check_storage() {
    # Get available disk space in GB (using the -h flag for human-readable output)
    AVAILABLE_SPACE=$(df -h / | awk 'NR==2 {print $4}' | sed 's/G//')

    # Define the threshold (100GB)
    THRESHOLD=100

    # Compare available space with the threshold
    if [ "$AVAILABLE_SPACE" -ge "$THRESHOLD" ]; then
        echo "$txtblue status check3: $txtgreen Available storage is greater than or equal to 100GB. $txtreset"
    else
        echo "$txtblue status check3: $txtred Available storage is less than 100GB. Please make sure to extend the storage to more than or equal to 100GB $txtreset"
	overall_status=false
    fi
}

check_ram() {
    # Get total RAM in GB (using the -h flag for human-readable output)
    TOTAL_RAM=$(free -g | awk '/^Mem:/ {print $2}' | sed 's/G//')

    # Define the threshold (16GB)
    THRESHOLD=15

    # Compare total RAM with the threshold
    if [ "$TOTAL_RAM" -ge "$THRESHOLD" ]; then
        echo "$txtblue status check4: $txtgreen Total RAM is greater than or equal to 16GB. $txtreset"
    else
        echo "$txtblue status check4: $txtred Total RAM is less than 16GB. Please create a VM having a minimum of 16GB RAM $txtreset"
        overall_status=false
    fi
}

check_dimension(){
    echo "$txtblue status check5: $txtyellow If you are opting to pull the data from NVSK instance, Make sure to upload the dimension files into cqube-devops/ansible/dimension_files folder ( Ignore this step if you are selecting access type as NVSK or Others ) $txtreset"
}

check_ssl(){
    echo "$txtblue status check6: $txtyellow If you are opting for public mode of installation, Make sure to upload the SSL certificate files into cqube-devops/ansible/ssl_certificates folder ( Make sure SSL certificates are in the format that supports nginx.) $txtreset"
}

check_port() {
    ports=( 80 443 5432 3000 3001 3002 3003 3005 4200 4201 8000 9000 9001 8080 8096 9090 9091 9092 9100 )

    # Initialize a counter
    counter=7

    # Loop through the list of ports and check if they are running
    for port in "${ports[@]}"; do
        if netstat -tuln | grep ":$port " >/dev/null; then
            echo "$txtblue status check$counter. $txtred Port $port is already running which might affect cqube deployment. $txtreset"
            echo "$txtblue use 'sudo netstat -ntllp' command to get the PID of $port and kill it using 'sudo kill -15 <PID> $txtreset"
            overall_status=false  # Set overall status to false if any port check fails
        else
            echo "$txtblue status check$counter. $txtgreen Port $port is free and can be used to deploy cqube. $txtreset"
        fi
        ((counter++))
    done
}

check_overall_status() {
    if [ "$overall_status" = true ]; then
        echo "$txtgreen Overall status: All checks passed successfully. System is ready for cqube deployment. $txtreset"
    else
        echo -e "\033[1m $txtred Overall status: Some checks failed. Please review the individual status checks for details. $txtreset"
    	exit 1
    fi
}

# Execute the checks
install_basics
check_os_version || overall_status=false
check_cpu_cores || overall_status=false
#check_storage || overall_status=false
check_ram || overall_status=false
check_dimension
check_ssl
check_port || overall_status=false

# Display overall status
check_overall_status

