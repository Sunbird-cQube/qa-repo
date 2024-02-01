# cQube QA Automation
<h4>Document is defined with execution of one step installation QA code in the detailed and please read the instructions & steps before doing the one step installation</h4>


## QA Automation Folder Structure: 
``` 
 - ssl_certificates
 - config.yml 
 - pre_requisites.sh
 - repo_clone.sh
 - verify_ssl_files.sh
 - check_env_files.sh
 - validate_db_tables.sh
 - validation_docker_services.sh
 - verify_app_urls.sh
 - validate_db_tables_after_processing.sh
 - test_nifi_processors.py
```
<h4><font='carimal'> Test Suites </h4>

```
   - test_config_data_generate.sh 
   - test_install_and_validate.sh
   - test_only_validation.sh
```


## Concise information about shell script defined below:

* <h4>ssl_certificates : Place certificate.crt & private.key files in to this folder before running installation suite.</h4>
* <h4>config.yml : contains basic information like repository url , branch name i.e </h4>
* <h4>pre_requisites.sh : Verify the pre-conditions parameters which are required to install the cQube Application</h4>
* <h4>repo_clone.sh : Verify the cloning of the repository and switching to branch and placing ssl files to folders </h4> 
* <h4>verify_ssl_files.sh : Verify the certificate.crt & private.key files are present or not at ansible/ssl_certificates/</h4>
* <h4>check_env_files : Verify the env files are created or not in containers after one step installation.</h4>
* <h4>validate_db_tables.sh : Verify the DB Schema tables & Datasets tables are created or not.</h4>
* <h4>validation_docker_services.sh : Verify the all the docker container & services status validation.</h4>
* <h4>verify_app_urls.sh : Verify the Application URL & API's are functioning or not.</h4>
* <h4>test_nifi_processors.py : Verify the Nifi Processor Groups status Start & stop when processing is completes.</h5>


## Steps to Execute the One Step Installation Automation Code

1. Run test_config_data_generate.py file to generate the config information and copy paste in side 'test_install_and_validate.sh'.

            python3 test_config_data_generate.py 

2. Place the certificate.crt & private.key inside ssl_certificate folder
3. Fill the config.yml and save it 
4. To Install cQube Application and Validate Then Run 

            bash test_install_and_validate.sh
                
5. Validate the DB , Docker Services & Container Then Run 
             
            test_only_validation.sh


# <h1> Result:
- Green Color Statements are Indicates verfication successfull.
- Red Color Statements are Indicates verification Failed. 








