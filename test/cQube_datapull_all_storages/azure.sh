#!/bin/bash

# Azure Storage information
storage_account_name="cqubev5"
storage_account_key="AJYPYssXwXYhnHMRIqciYnBlOaZEXfYMX219UdeQu6E0JrF+ivQAQiglJPWoDVAzQn090+2IULsE+AStXkaoZg=="
container_name="azure-cqube-nvsk"

# Function to check if blob (file) exists in the specified folder
check_blob_existence() {
    local blob_path="$1"
    az storage blob exists --account-name $storage_account_name --account-key $storage_account_key --container-name $container_name --name "$blob_path" --output table
}

list_container_contents() {
    az storage blob list --account-name $storage_account_name --account-key $storage_account_key --container-name $container_name --output table
}

# List contents of the container
list_container_contents

# Check if "emission" folder exists
check_blob_existence "emission"

# Check if "process_input" folder exists
check_blob_existence "process_input"

