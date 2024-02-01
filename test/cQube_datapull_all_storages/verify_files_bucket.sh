
#!/bin/bash

txtreset=$(tput sgr0)     # Text reset
txtred=$(tput setaf 1)    # Red
txtgreen=$(tput setaf 2)  # Green
txtyellow=$(tput setaf 3) # Yellow

sudo apt-get install jq -y

config_file="config_files/aws_s3_config.yml"
storage_config="config_files/config.yml"
azure_config_file="config_files/azure_container_config.yml"

# Replace these values with your AWS S3 bucket details
AWS_ACCESS_KEY_ID=$(grep 'aws_access_key' "$config_file" | awk '{print $2}')
AWS_SECRET_ACCESS_KEY=$(grep 'aws_secret_key' "$config_file" | awk '{print $2}')
S3_BUCKET=$(grep 's3_bucket' "$config_file" | awk '{print $2}')
S3_PREFIX="emission"
STORAGE_TYPE=$(grep 'storage_type' "$storage_config" | awk '{print $2}')

azure_account_name=$(grep 'azure_account_name' "$azure_config_file" | awk '{print $2}')
azure_account_key=$(grep 'azure_account_key' "$azure_config_file" | awk '{print $2}')
azure_container=$(grep 'azure_container' "$azure_config_file" | awk '{print $2}')

# MinIO server details
app_url=$(grep 'api_endpoint' "$storage_config" | awk '{print $2}')

MINIO_SERVER="https://$app_url"
MINIO_ACCESS_KEY="minioadmin"
MINIO_SECRET_KEY="minioadmin"

# MinIO bucket details
MINIO_BUCKET="cqube-minio-bucket"
EMISSION_FOLDER="emission"
PROCESS_INPUT_FOLDER="process_input"


if [ "$STORAGE_TYPE" == "aws" ]; then
    # Configure AWS CLI with provided credentials
    aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"
    aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"

    # Use AWS CLI to list objects in the S3 bucket
    object_list=$(aws s3 ls "s3://$S3_BUCKET/$S3_PREFIX" --recursive)

    # Check if the object_list is empty (no files/folders)
    if [ -z "$object_list" ]; then
        echo -e "$txtred No files or folders found in S3 bucket $S3_BUCKET/$S3_PREFIX $txtreset"
    else
        echo -e "$txtgreen Files and folders found in S3 bucket $S3_BUCKET/$S3_PREFIX: $txtreset"
        echo -e "$txtyellow$object_list$txtreset"
    fi

elif [ "$STORAGE_TYPE" == "azure" ]; then
        storage_account_name=$azure_account_name
        storage_account_key=$azure_account_key
        container_name=$azure_container
        # Function to check if blobs with the specified prefix exist in the container
        check_blob_existence() {
        local prefix="$1"
        local exists=$(az storage blob list --account-name $storage_account_name --account-key $storage_account_key --container-name $container_name --prefix "$prefix" --output json | jq -r '. | length > 0')

        if [ "$exists" == "true" ]; then
                echo -e "$txtgreen $prefix folder contains in the blob. $txtreset"
        else
                echo -e "$txtred $prefix folder does not exist in the blob. $txtreset"
        fi
}
        # Check if "emission" folder exists
        check_blob_existence "emission"
        # Check if "process_input" folder exists
        check_blob_existence "process_input"

elif [ "$STORAGE_TYPE" == "local" ]; then
    echo -e "Please Login to the minio bucket and verify the files in the emission folder "

    mc config host add cqube-minio "${MINIO_SERVER}" "${MINIO_ACCESS_KEY}" "${MINIO_SECRET_KEY}" --api S3v4

    # Function to check if a folder exists in the bucket
    function check_folder {
        folder_path=$1
        response=$(mc stat "cqube-minio/${MINIO_BUCKET}/${folder_path}" 2>&1)
        if [[ $? -eq 0 ]]; then
            echo -e "$txtgreen Folder '${folder_path}' exists in the bucket. $txtreset"
        else
            echo -e "$txtred Folder '${folder_path}' does not exist in the bucket. $txtreset"
        fi
    }

    # Check if the bucket exists
    if mc ls "cqube-minio/${MINIO_BUCKET}" &> /dev/null; then
        echo "Connected to MinIO bucket: ${MINIO_BUCKET}"

        # Check if the 'emission' folder exists
        check_folder "${EMISSION_FOLDER}"

        # Check if the 'process-input' folder exists
        check_folder "${PROCESS_INPUT_FOLDER}"
    else
        echo -e "$txtred Failed to connect to MinIO bucket: ${MINIO_BUCKET} $txtreset"
    fi
else
    echo -e "$txtred Invalid storage type. Please specify 'aws' or 'local' or 'azure' or 'oracle' . $txtreset"
fi

