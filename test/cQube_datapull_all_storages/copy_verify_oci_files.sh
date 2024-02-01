#!/bin/bash

txtreset=$(tput sgr0)     # Text reset
txtred=$(tput setaf 1)    # Red
txtgreen=$(tput setaf 2)  # Green
txtyellow=$(tput setaf 3) # Yellow

config_file="config.yml"
oci_file=$(grep 'oci_fileName' "$config_file" | awk '{print $2}')

echo "$oci_file is file"

sudo su <<EOF
cd /root/ || exit 1
mkdir -p .oci || exit 1
cd .oci || exit 1
EOF

# Step 2: Exit from root and copy the pem file
if sudo cp oci_file/"$oci_file" /root/.oci/; then
    echo -e "$txtgreen Oracle - oci pem File copied successfully to /root/.oci/ folder  $txtreset"
else
    echo -e "$txtred Error: Unable to copy oci file $txtreset"
    exit 1
fi

sudo su <<EOF
ls /root/.oci/

if ls "/root/.oci/$oci_file" >/dev/null 2>&1; then
    echo -e "\e[32m $oci_file is present at /root/.oci/ folder \e[0m" 
else
    echo -e "\e[31mError: $oci_file not found in /root/.oci/ \e[0m"
    exit 1
fi

EOF
