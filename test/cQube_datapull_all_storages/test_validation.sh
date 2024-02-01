#!/bin/bash



echo "********************************* Validating the Docker services , ENV files , App url & API and Input Files from Bucket *******************************************"

echo "******************************************** Verifying Docker services ********************************************* "
chmod u+x ../cQube/validation_docker_services.sh
. "../cQube/validation_docker_services.sh"

echo "******************************************** Verifying the env files from the Containers *************************** "
chmod u+x ../cQube/check_env_files.sh
. "../cQube/check_env_files.sh"

echo "******************************************** Verifying the Application URL & APIs ***********************************"
chmod u+x ../cQube/verify_app_urls.sh
. "../cQube/verify_app_urls.sh"

echo "************************************************** Verify the Input files from the buckers ***************************"
chmod u+x ../cQube/verify_files_bucket.sh
. "../cQube/verify_files_bucket.sh"

echo "********************************************* Verifying the each dataset tables and dimension tables are having records or not ********************************"
chmod u+x ../cQube/validate_db_tables_after_processing.sh
. "../cQube/validate_db_tables_after_processing.sh"

echo "******************************** Validation Script Execution is Completed. ******************************************************************************************"
