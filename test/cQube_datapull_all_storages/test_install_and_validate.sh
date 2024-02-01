#!/bin/bash

echo " ********************************** Running pre-requisite check lists *************************************"
chmod u+x pre_requisites.sh
. "pre_requisites.sh" 

echo "******************************************** Cloning the repository **************************************** "
chmod u+x repo_clone.sh
. "repo_clone.sh"


echo "$pwd"

echo "********************************************* Verifying the ssl certificates ******************************"
chmod u+x ../cQube/verify_ssl_files.sh
. "../cQube/verify_ssl_files.sh"


echo "********************************************* Verifying the Dimensions files *******************************"
chmod u+x ../cQube/verify_dimension_files.sh
. "../cQube/verify_dimension_files.sh"


#Please add the cQube - input values inside EOF 

sudo ./install.sh << EOF
<<<<<<<<<< Add here generated config data >>>>>>>>>>>>>>>>>>>
EOF


echo "******************************************** Verifying Docker services ********************************************* "
chmod u+x ../cQube/validation_docker_services.sh
. "../cQube/validation_docker_services.sh"

echo "******************************************** Verifying the env files from the Containers *************************** "
chmod u+x ../cQube/check_env_files.sh
. "../cQube/check_env_files.sh"

echo "******************************************** Verifying the Application URL & APIs ***********************************"
chmod u+x ../cQube/verify_app_urls.sh
. "../cQube/verify_app_urls.sh"

sleep 3m

echo "************************************************** Verify the Input files from the buckers ***************************"
chmod u+x ../cQube/verify_files_bucket.sh
. "../cQube/verify_files_bucket.sh"


#echo "******************************************** Validating  Nifi Processor Groups **************************************"
#python3 ../cQube/test_nifi_processors.py 

sleep 2m

echo "******************************************** Verifying db tables **************************************************** "
chmod u+x ../cQube/validate_db_tables.sh
. "../cQube/validate_db_tables.sh"

echo "<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<  Pausing Script Execution to 15minutes till Nifi Processing Completes the Processing >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
sleep 15m

echo "********************************************* Verifying the each dataset tables and dimension tables are having records or not ********************************"
chmod u+x ../cQube/validate_db_tables_after_processing.sh
. "../cQube/validate_db_tables_after_processing.sh"



echo "****************************************************** END OF QA AUTOMATION EXECUTION  ***************************************************************************"
