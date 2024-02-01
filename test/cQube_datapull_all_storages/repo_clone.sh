#!/bin/bash

txtreset=$(tput sgr0) # Text reset
txtred=$(tput setaf 1) # Red
txtgreen=$(tput setaf 10) # Green
txtblue=$(tput setaf 6) # Blue

# Parse the config file using grep and awk
config_file="config.yml"
repo_url=$(grep 'repository_url' "$config_file" | awk '{print $2}')
branch_name=$(grep 'branch_name' "$config_file" | awk '{print $2}')
git_to=$(grep 'github_token' "$config_file" | awk '{print $2}')

#!/bin/bash

txtreset=$(tput sgr0) # Text reset
txtred=$(tput setaf 1) # Red
txtgreen=$(tput setaf 10) # Green
txtblue=$(tput setaf 6) # Blue


echo "********************* Directory changed for repo clone : $(pwd)************************"

# Parse the config file using grep and awk
config_file="config.yml"
repo_url=$(grep 'repository_url' "$config_file" | awk '{print $2}')
branch_name=$(grep 'branch_name' "$config_file" | awk '{print $2}')

# if storage_type is oracle then it will copy oci pem file and moving into /root/.oci/ folder 
echo "Coping the oci pem file and moving to /root/oci"
STORAGE_TYPE=$(grep 'storage_type' "$config_file" | awk '{print $2}')
echo "STORAGE_TYPE: $STORAGE_TYPE"
if [ "$STORAGE_TYPE" == "oracle" ]; then
    bash ../cQube/copy_verify_oci_files.sh
else
    echo -e "${txtgreen} This is $STORAGE_TYPE Of VSK Installation "
fi

# Check if the repository URL and branch name are not empty
if [ -z "$repo_url" ] || [ -z "$branch_name" ]; then
  echo "${txtred}Error: Repository URL or branch name is not specified in $config_file ${txtreset}"
  exit 1
fi

cd ..

# Clone the repository with authentication
git clone "https://$repo_url"

# Check if the repository was cloned successfully
if [ $? -ne 0 ]; then
  echo "${txtred}Failed to clone repository.${txtreset}"
  exit 1
fi

# Change into the newly cloned repository directory
cd "$(basename "$repo_url" .git)"

# Print current directory
echo "Current Directory: is : $(pwd)"

# Verify that the change was successful
if [ $? -eq 0 ]; then
  echo "${txtgreen}Successfully changed into directory $(basename "$repo_url" .git) ${txtreset}"
else
  echo "${txtred}Failed to change into directory $(basename "$repo_url" .git) ${txtreset}"
  exit 1
fi

# Checkout the specified branch
git checkout "$branch_name"

# Verify if the checkout was successful
if [ $? -eq 0 ]; then
  echo "${txtgreen}Checkout to $branch_name is Successful${txtreset}"
else
  echo "${txtred}Checkout to $branch_name is failed${txtreset}"
fi


# Define the target branch
target_branch=$branch_name

# Get the current branch
current_branch=$(git branch --show-current)

# Check if the current branch matches the target branch
if [ "$current_branch" = "$target_branch" ]; then
  echo "${txtgreen}Switched to $target_branch${txtreset}"
else
  echo "${txtred}Not on $target_branch. Current branch is $current_branch.${txtreset}"
fi

sudo cp ../cQube/ssl_certificates/certificate.crt ansible/ssl_certificates/
sudo cp ../cQube/ssl_certificates/private.key ansible/ssl_certificates/

sleep 2


echo "Moving the dimensions files to ansible/dimension_files "

sudo cp ../cQube/dimensions/district-dimension.data.csv ansible/dimension_files/
sudo cp ../cQube/dimensions/grade-dimension.data.csv ansible/dimension_files/
sudo cp ../cQube/dimensions/medium-dimension.data.csv ansible/dimension_files/
sudo cp ../cQube/dimensions/state-dimension.data.csv ansible/dimension_files/
sudo cp ../cQube/dimensions/subject-dimension.data.csv ansible/dimension_files/


echo " "
echo -e "${txtgreen} Repository Cloned and copied ssl files to respective folders.${txtreset} "

