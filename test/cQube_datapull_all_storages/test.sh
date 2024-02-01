#!/bin/bash

# Set your OCI configuration profile
OCI_PROFILE="/root/.oci/itadmin@tibilsolutions.com_2023-04-18T10_08_35.916Z.pem"

# Set your OCI namespace
OCI_NAMESPACE="bmpsozm7imnb"

# Set your OCI bucket name
OCI_BUCKET_NAME="oracle-test-bucket"

# Connect to OCI Object Storage
oci os object list \
  --profile $OCI_PROFILE \
  --namespace $OCI_NAMESPACE \
  --bucket-name $OCI_BUCKET_NAME \
  --output table

# Check for the existence of folders
if oci os object list \
  --profile $OCI_PROFILE \
  --namespace $OCI_NAMESPACE \
  --bucket-name $OCI_BUCKET_NAME \
  --query "contains(data, 'emission')" > /dev/null && \
   oci os object list \
  --profile $OCI_PROFILE \
  --namespace $OCI_NAMESPACE \
  --bucket-name $OCI_BUCKET_NAME \
  --query "contains(data, 'process-input')" > /dev/null
then
  echo "Both 'emission' and 'process-input' folders exist in the bucket."
else
  echo "One or both of the folders ('emission' or 'process-input') do not exist in the bucket."
fi

