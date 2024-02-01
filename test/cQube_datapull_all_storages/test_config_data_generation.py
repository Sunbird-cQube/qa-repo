config_data = []

domain_specific = []
config_generate = []
storage_config_data = []
program_config_data = []

''' start of domain specific file generation '''

access_type = input('Please enter the Access Type as VSK or NVSK or others : ')
if access_type.lower() == 'vsk' or access_type.lower() == 'nvsk' or access_type.lower() == 'others':
    domain_specific.append(access_type.upper())
else:
    print('Please enter the correct access type value ')
    access_type = input('Please enter the Access Type as VSK or NVSK or others : ')
    if access_type.lower() == 'vsk' or access_type.lower() == 'nvsk' or access_type.lower() == 'others':
        domain_specific.append(access_type.upper())

state_code = input('Please enter the State Code : ')
if len(state_code) == 2 and state_code.isalpha() and state_code.isupper():
    domain_specific.append(state_code.upper())
else:
    print('Please enter the correct value ')
    access_type = input('Please enter the State Code : ')
    if len(state_code) == 2 and state_code.isalpha() and state_code.isupper():
        domain_specific.append(state_code.upper())

login_status = input('Do you want to enable login screen for cqube instance i.e enter true or false : ')
if login_status.lower() == 'true' or login_status.lower() == 'false':
    domain_specific.append(login_status)
else:
    print('Please enter the correct value ')
    login_status = input('Do you want to enable login screen for cqube instance i.e enter true or false : ')
    if login_status.lower() == 'true' or login_status.lower() == 'false':
        domain_specific.append(login_status)

pull_status = input("Do you want to pull the data from NVSK server i.e enter true or false ? (valid mostly for 'VSK' "
                    "or 'other' instance type)"
                    " : ")
if pull_status.lower() == 'true' or pull_status.lower() == 'false':
    domain_specific.append(pull_status)
else:
    print('Please enter the correct value ')
    pull_status = input("Do you want to pull the data from NVSK server? (valid mostly for 'VSK' or 'other' instance "
                        "type)  : ")
    if pull_status.lower() == 'true' or pull_status.lower() == 'false':
        domain_specific.append(pull_status)

nvsk_endpoint = input('Please enter the end point to pull the data i.e nvsk.project.com : ')
domain_specific.append(nvsk_endpoint)

domain_specific_config = input("Do you still want to edit the domain specific config.yml file (yes/no)? : ")
if domain_specific_config == 'no' or domain_specific_config == 'NO':
    domain_specific.append(domain_specific_config.lower())
elif domain_specific_config == 'yes' or domain_specific_config == 'YES':
    domain_specific.clear()
    access_type = input('Please enter the Access Type as VSK or NVSK or others : ')
    if access_type.lower() == 'VSK' or access_type.lower() == 'NVSK' or access_type.lower() == 'others':
        domain_specific.append(access_type.lower())
    else:
        print('Please enter the correct access type value ')
        access_type = input('Please enter the Access Type as vsk or NVSK or others: ')
        if access_type.lower() == 'vsk' or access_type.lower() == 'nvsk' or access_type.lower() == 'others':
            domain_specific.append(access_type.lower())

        state_code = input('Please enter the State Code : ')
        if len(state_code) == 2 and state_code.isalpha() and state_code.isupper():
            domain_specific.append(state_code)
        else:
            print('Please enter the correct value ')
            access_type = input('Please enter the State Code : ')
            if len(state_code) == 2 and state_code.isalpha() and state_code.isupper():
                domain_specific.append(state_code)

        login_status = input('Do you want to enable login screen for cqube instance i.e enter true or false : ')
        if login_status.lower() == 'true' or login_status.lower() == 'false':
            domain_specific.append(login_status)
        else:
            print('Please enter the correct value ')
            login_status = input('Do you want to enable login screen for cqube instance i.e enter true or false : ')
            if login_status.lower() == 'true' or login_status.lower() == 'false':
                domain_specific.append(login_status)

        pull_status = input(
            "Do you want to pull the data from NVSK server? (valid mostly for 'VSK' or 'other' instance type) "
            " : ")
        if pull_status.lower() == 'true' or pull_status.lower() == 'false':
            domain_specific.append(pull_status)
        else:
            print('Please enter the correct value ')
            pull_status = input(
                "Do you want to pull the data from NVSK server? (valid mostly for 'VSK' or 'other' instance "
                "type)  : ")
            if pull_status.lower() == 'true' or pull_status.lower() == 'false':
                domain_specific.append(pull_status)

        preview_config = input("Do you still want to edit the domain_specific config.yml file (yes/no)?: ")
        if preview_config.lower() == 'no' or preview_config.upper() == 'NO':
            domain_specific.append(preview_config.lower())
            config_data = list(domain_specific)
        else:
            print("Something went wrong i.e re-run the script ")

''' start of config data file generation '''

mode_of_installation = input('Please enter the mode_of_installation as public or localhost : ')
if mode_of_installation.lower() == 'public' or mode_of_installation.lower() == 'localhost':
    config_generate.append(mode_of_installation.lower())
else:
    print('Please enter the correct access type value ')
    mode_of_installation = input('Please enter the mode_of_installation as public or localhost : ')
    if mode_of_installation.lower() == 'public' or mode_of_installation.lower() == 'localhost':
        config_generate.append(mode_of_installation.lower())

storage_type = input('Please enter the storage_type as local or aws or oracle or azure : ')
if storage_type.lower() == 'local' or storage_type.lower() == 'aws' or storage_type.lower() == 'azure' or storage_type.lower() == 'oracle':
    config_generate.append(storage_type.lower())
else:
    print('Please enter the correct access type value ')
    storage_type = input('Please enter the storage_type aws or local or azure or oracle : ')
    if storage_type.lower() == 'local' or storage_type.lower() == 'aws' or storage_type.lower() == 'oracle' or storage_type.lower() == 'azure':
        config_generate.append(storage_type.lower())

api_endpoint = input('Please enter the api endpoint i.e abc-project.com : ')
config_generate.append(api_endpoint)

cert_filename = input('Please enter the certificate filename: ')
if cert_filename.lower() == 'certificate.crt':
    config_generate.append(cert_filename.lower())
else:
    print('Please enter the correct access type value ')
    cert_filename = input('Please enter the certificate filename: ')
    if cert_filename.lower() == 'certificate.crt':
        config_generate.append(cert_filename.lower())

private_key = input('Please enter the private_key filename: ')
if private_key.lower() == 'private.key':
    config_generate.append(private_key.lower())
else:
    print('Please enter the correct access type value ')
    private_key = input('Please enter the private key filename: ')
    if private_key.lower() == 'private.key':
        config_generate.append(private_key.lower())

db = input("Do you still want to edit db credentials (yes/no)? : ")
if db.lower() == 'no':
    config_generate.append(db.lower())
elif db.lower() == 'yes' or db.upper() == 'YES':
    db_user = input('Please please enter the db_user : ')
    config_generate.append(db_user)
    db_name = input('Please please enter the db_name : ')
    config_generate.append(db_name)
    db_password = input('Please please enter the db_password - contain a capital , lower , a numbers and special '
                        'characters i.e Admin@123 : ')
    config_generate.append(db_password)

read_user = input("Do you still want to edit the readonly db credentials (yes/no)? : ")
if read_user.lower() == 'no' or read_user.upper() == 'NO':
    config_generate.append(read_user.lower())
elif read_user.lower() == 'yes' or read_user.upper() == 'YES':
    db_user = input('Please please enter the readonly_db_user : ')
    config_generate.append(db_user)
    db_password = input('Please please enter the readonly_db_password - contain a capital , lower , a numbers and '
                        'special'
                        'characters i.e Admin@123 : ')
    config_generate.append(db_password)

keycloak_creds = input("Do you still want to edit the keycloak credentials (yes/no)? : ")
if keycloak_creds.lower() == 'no' or keycloak_creds.upper() == 'NO':
    config_generate.append(keycloak_creds)
elif keycloak_creds.lower() == 'yes' or keycloak_creds.upper() == 'YES':
    user_name = input('Please please enter the keycloak username : ')
    config_generate.append(user_name)
    password = input('Please please enter the keycloak_password - contain a capital , lower , a numbers and '
                     'special'
                     'characters i.e Admin@123 : ')
    config_generate.append(password)

final_preview = input("Do you still want to edit the config.yml file (yes/no)? :")
if final_preview == 'no' or final_preview == 'NO':
    config_generate.append(final_preview)
elif final_preview == 'yes' or final_preview == 'YES':
    config_generate.clear()
    mode_of_installation = input('Please enter the mode_of_installation as public or localhost : ')
    if mode_of_installation.lower() == 'public' or mode_of_installation.lower() == 'localhost':
        config_generate.append(mode_of_installation.lower())
    else:
        print('Please enter the correct mode of installation type value ')
        mode_of_installation = input('Please enter the mode_of_installation as public or localhost : ')
        if mode_of_installation.lower() == 'public' or mode_of_installation.lower() == 'localhost':
            config_generate.append(mode_of_installation.lower())

    storage_type = input('Please enter the storage_type as local or aws  : ')
    if storage_type.lower() == 'local' or storage_type.lower() == 'aws':
        config_generate.append(storage_type.lower())
    else:
        print('Please enter the correct storage type value ')
        storage_type = input('Please enter the storage_type as local : ')
        if storage_type.lower() == 'local':
            config_generate.append(storage_type.lower())

    api_endpoint = input('Please enter the api endpoint i.e abc-project.com : ')
    config_generate.append(api_endpoint)

    cert_filename = input('Please enter the certificate filename: ')
    if cert_filename.lower() == 'certificate.crt':
        config_generate.append(cert_filename.lower())
    else:
        print('Please enter the correct certificate.crt file name ')
        cert_filename = input('Please enter the certificate filename: ')
        if cert_filename.lower() == 'certificate.crt':
            config_generate.append(cert_filename.lower())

    private_key = input('Please enter the private_key filename: ')
    if private_key.lower() == 'private.key':
        config_generate.append(private_key.lower())
    else:
        print('Please enter the correct private.key file name ')
        private_key = input('Please enter the private key filename: ')
        if private_key.lower() == 'private.key':
            config_generate.append(private_key.lower())

    db = input("Do you still want to edit db credentials (yes/no)? : ")
    if db.lower() == 'no':
        config_generate.append(db.lower())
    elif db.lower() == 'yes' or db.upper() == 'YES':
        db_user = input('Please please enter the db_user : ')
        config_generate.append(db_user)
        db_name = input('Please please enter the db_name : ')
        config_generate.append(db_name)
        db_password = input('Please please enter the db_password - contain a capital , lower , a numbers and special '
                            'characters i.e Admin@123 : ')
        config_generate.append(db_password)

    read_user = input("Do you still want to edit the readonly db credentials (yes/no)? : ")
    if read_user.lower() == 'no' or read_user.upper() == 'NO':
        config_generate.append(read_user.lower())
    elif read_user.lower() == 'yes' or read_user.upper() == 'YES':
        db_user = input('Please please enter the readonly_db_user : ')
        config_generate.append(db_user)
        db_password = input('Please please enter the readonly_db_password - contain a capital , lower , a numbers and '
                            'special'
                            'characters i.e Admin@123 : ')
        config_generate.append(db_password)

    keycloak_creds = input("Do you still want to edit the keycloak credentials (yes/no)? : ")
    if keycloak_creds.lower() == 'no' or keycloak_creds.upper() == 'NO':
        config_generate.append(keycloak_creds)
    elif keycloak_creds.lower() == 'yes' or keycloak_creds.upper() == 'YES':
        user_name = input('Please please enter the keycloak username : ')
        config_generate.append(user_name)
        password = input('Please please enter the keycloak_password - contain a capital , lower , a numbers and '
                         'special'
                         'characters i.e Admin@123 : ')
        config_generate.append(password)

if 'aws' in config_generate:
    aws_access = input("please enter the aws_access_key: ")
    storage_config_data.append(aws_access)
    aws_secrete = input("please enter the aws_secret_key: ")
    storage_config_data.append(aws_secrete)
    status = input("s3 bucket is already exist with the s3-cqube-edu if you want to continue with the same bucket "
                   "enter no or you want to create new bucket enter yes .enter yes or no (yes/no)?")
    if status.lower() == 'no' or status.upper() == 'NO':
        storage_config_data.append(status.lower())
    elif status.lower() == 'yes' or status.upper() == 'YES':
        storage_config_data.append(status.lower())
        bucket_name = input("please enter the unique  s3 bucket name: ")
        storage_config_data.append(bucket_name)

    verify = input("Do you still want to edit the aws_s3_config.yml file (yes/no)? ")
    if verify.lower() == 'no' or verify.upper() == 'NO':
        storage_config_data.append(verify.lower())
    elif verify.lower() == 'yes' or verify.upper() == 'YES':
        storage = []
        aws_access = input("please enter the aws_access_key: ")
        storage.append(aws_access)
        aws_secrete = input("please enter the aws_secret_key: ")
        storage.append(aws_secrete)
        status = input("s3 bucket is already exist with the s3-cqube-edu if you want to continue with the same bucket "
                       "enter no or you want to create new bucket enter yes .enter yes or no (yes/no)?")
        if status.lower() == 'no' or status.upper() == 'NO':
            storage.append(status.lower())
        elif status.lower() == 'yes' or status.upper() == 'YES':
            bucket_name = input("please enter the unique  s3 bucket name: ")
            storage.append(bucket_name)
            verify = input("Do you still want to edit the aws_s3_config.yml file (yes/no)? ")
            storage.append(verify.lower())
        storage_config_data = list(storage)

if 'azure' in config_generate:
    connection_string = input("please enter the connection string (Hint: Enter Azure connection string): ")
    storage_config_data.append(connection_string)
    account_key = input("please enter the azure account key (Hint: Enter Azure account key): ")
    storage_config_data.append(account_key)
    account_name = input("please enter the azure account name (Hint: Enter Azure account name): ")
    storage_config_data.append(account_name)
    bucket_exist = input("azure container azure-cqube-edu is already exists. if you want to continue with the same "
                         "azure container enter no or you want to create new container enter yes .enter yes or no ("
                         "yes/no)?: ")
    if bucket_exist.lower() == 'yes' or bucket_exist.upper() == 'YES':
        storage_config_data.append(bucket_exist.lower())
        bucket_name = input("please enter the azure blob container: ")
        storage_config_data.append(bucket_name)
    else:
        storage_config_data.append(bucket_exist)
    azure_cred_status = input("Currently cQube azure_container_config.yml is entered. Follow Installation process "
                              "with above config values.If you want to edit config value please enter yes or no to continue.: ")
    if azure_cred_status.lower() == 'no' or azure_cred_status.upper() == 'NO':
        storage_config_data.append(azure_cred_status)
    else:
        storage_config_data.clear()
        connection_string = input("please re-enter the connection string (Hint: Enter Azure connection string): ")
        storage_config_data.append(connection_string)
        account_key = input("please re-enter the azure account key (Hint: Enter Azure account key): ")
        storage_config_data.append(account_key)
        account_name = input("please re-enter the azure account name (Hint: Enter Azure account name): ")
        storage_config_data.append(account_name)
        bucket_exist = input("azure container azure-cqube-edu is already exists. if you want to continue with the same "
                             "azure container enter no or you want to create new container enter yes .enter yes or no ("
                             "yes/no)?: ")
        if bucket_exist.lower() == 'yes' or bucket_exist.upper() == 'YES':
            storage_config_data.append(bucket_exist.lower())
            bucket_name = input("please re-enter the azure blob container: ")
            storage_config_data.append(bucket_name)
        else:
            storage_config_data.append(bucket_exist)
        azure_cred_status = input("Currently cQube azure_container_config.yml is entered. Follow Installation process "
                                  "with above config values.If you want to edit config value please enter yes.: ")
        storage_config_data.append(azure_cred_status)

if 'oracle' in config_generate:
    oci_location = input("Enter a location for your config [/root/.oci/config]: ")
    storage_config_data.append(oci_location)
    user_ocid = input("Enter a user OCID: ")
    storage_config_data.append(user_ocid)
    tenency = input("Enter a tenancy OCID: ")
    storage_config_data.append(tenency)
    region = input("Enter a region by index or name(e.g. ap-mumbai-1 ) : ")
    storage_config_data.append(region)
    path_con = input("Do you want to generate a new API Signing RSA key pair? (If you decline you will be asked to "
                     "supply the path to an existing key.) [Y/n] ")
    storage_config_data.append('n')
    oci_path = input("Enter the location of your API Signing private key file: ")
    storage_config_data.append(oci_path)
    oracle_space = input("please enter the oracle name space  (Hint: Enter the oracle Name space) : ")
    storage_config_data.append(oracle_space)
    oracle_bucket = input("please enter the oracle storage bucket name  (Hint: Enter oracle bucket_name): ")
    storage_config_data.append(oracle_bucket)
    status = input("Do you still want to edit the oracle_storage_config.yml file (yes/no)?: ")
    if status.lower() == 'no' or status.upper() == 'NO':
        storage_config_data.append(status.lower())
    else:
        storage_config_data.remove(oracle_space)
        storage_config_data.remove(oracle_bucket)
        print(storage_config_data)
        storage_config_data.append(status.lower())
        oracle_space = input("please enter the oracle name space  (Hint: Enter the oracle Name space) : ")
        storage_config_data.append(oracle_space)
        oracle_bucket = input("please enter the oracle storage bucket name  (Hint: Enter oracle bucket_name): ")
        storage_config_data.append(oracle_bucket)
        status = input("Do you still want to edit the oracle_storage_config.yml file (yes/no)?: ")
        storage_config_data.append(status.lower())

program_selector = input("Do you still want to edit the program_selector.yml file (yes/no)? : ")
if program_selector.lower() == 'no' or program_selector.upper() == 'NO':
    program_config_data.append(program_selector.lower())
elif program_selector.lower() == 'yes' or program_selector.upper() == 'YES':
    program_config_data.clear()
    teacher_attendance = input("Do you want to enable teacherAttendance program i.e enter true or false : ")
    if teacher_attendance.lower() == 'true':
        program_config_data.append(teacher_attendance)
        login = input("Do you want to enable login screen for teacherAttendance program i.e public or private: ")
        if login.lower() == 'public' or login.lower() == 'private':
            program_config_data.append(login.lower())
        else:
            program_config_data.append(teacher_attendance.lower())

    pgi = input("Do you want to enable pgi program i.e enter true or false : ")
    if pgi.lower() == 'true':
        program_config_data.append(pgi.lower())
        login = input("Do you want to enable login screen for pgi program i.e public or private: ")
        if login.lower() == 'public' or login.lower() == 'private':
            program_config_data.append(login.lower())
        else:
            program_config_data.append(pgi.lower())

    pmPoshan = input("Do you want to enable pmPoshan program i.e enter true or false : ")
    if pgi.lower() == 'true':
        program_config_data.append(pmPoshan.lower())
        login = input("Do you want to enable login screen for pmPoshan program i.e public or private: ")
        if login.lower() == 'public' or login.lower() == 'private':
            program_config_data.append(login.lower())
        else:
            program_config_data.append(pmPoshan.lower())

    udise = input("Do you want to enable udise program i.e enter true or false : ")
    if pgi.lower() == 'true':
        program_config_data.append(udise.lower())
        login = input("Do you want to enable login screen for udise program i.e public or private: ")
        if login.lower() == 'public' or login.lower() == 'private':
            program_config_data.append(login.lower())
        else:
            program_config_data.append(udise.lower())

    nas = input("Do you want to enable nas program i.e enter true or false : ")
    if pgi.lower() == 'true':
        program_config_data.append(nas.lower())
        login = input("Do you want to enable login screen for nas program i.e public or private: ")
        if login.lower() == 'public' or login.lower() == 'private':
            program_config_data.append(login.lower())
        else:
            program_config_data.append(nas.lower())

    diksha = input("Do you want to enable diksha program i.e enter true or false : ")
    if pgi.lower() == 'true':
        program_config_data.append(diksha.lower())
        login = input("Do you want to enable login screen for diksha program i.e public or private: ")
        if login.lower() == 'public' or login.lower() == 'private':
            program_config_data.append(login.lower())
        else:
            program_config_data.append(diksha.lower())

    nishtha = input("Do you want to enable nishtha program i.e enter true or false : ")
    if pgi.lower() == 'true':
        program_config_data.append(nishtha.lower())
        login = input("Do you want to enable login screen for nishtha program i.e public or private: ")
        if login.lower() == 'public' or login.lower() == 'private':
            program_config_data.append(login.lower())
        else:
            program_config_data.append(nishtha.lower())

    final_programs = input("Do you still want to edit the program_selector.yml file (yes/no)? :")
    if final_programs.lower() == 'no':
        program_config_data.append(final_programs.lower())
    elif final_programs.lower() == 'yes':
        program_config_data.clear()
        teacher_attendance = input("Do you want to enable teacherAttendance program i.e enter true or false : ")
        if teacher_attendance.lower() == 'true':
            config_data.append(teacher_attendance)
            login = input("Do you want to enable login screen for teacherAttendance program i.e public or private: ")
            if login.lower() == 'public' or login.lower() == 'private':
                config_data.append(login.lower())
            else:
                config_data.append(teacher_attendance.lower())

        pgi = input("Do you want to enable pgi program i.e enter true or false : ")
        if pgi.lower() == 'true':
            config_data.append(pgi.lower())
            login = input("Do you want to enable login screen for pgi program i.e public or private: ")
            if login.lower() == 'public' or login.lower() == 'private':
                config_data.append(login.lower())
            else:
                config_data.append(pgi.lower())

        pmPoshan = input("Do you want to enable pmPoshan program i.e enter true or false : ")
        if pgi.lower() == 'true':
            config_data.append(pmPoshan.lower())
            login = input("Do you want to enable login screen for pmPoshan program i.e public or private: ")
            if login.lower() == 'public' or login.lower() == 'private':
                config_data.append(login.lower())
            else:
                config_data.append(pmPoshan.lower())

        udise = input("Do you want to enable udise program i.e enter true or false : ")
        if pgi.lower() == 'true':
            config_data.append(udise.lower())
            login = input("Do you want to enable login screen for udise program i.e public or private: ")
            if login.lower() == 'public' or login.lower() == 'private':
                config_data.append(login.lower())
            else:
                config_data.append(udise.lower())

        nas = input("Do you want to enable nas program i.e enter true or false : ")
        if pgi.lower() == 'true':
            config_data.append(nas.lower())
            login = input("Do you want to enable login screen for nas program i.e public or private: ")
            if login.lower() == 'public' or login.lower() == 'private':
                config_data.append(login.lower())
            else:
                config_data.append(nas.lower())

        diksha = input("Do you want to enable diksha program i.e enter true or false : ")
        if pgi.lower() == 'true':
            config_data.append(diksha.lower())
            login = input("Do you want to enable login screen for diksha program i.e public or private: ")
            if login.lower() == 'public' or login.lower() == 'private':
                config_data.append(login.lower())
            else:
                config_data.append(diksha.lower())

        nishtha = input("Do you want to enable nishtha program i.e enter true or false : ")
        if pgi.lower() == 'true':
            config_data.append(nishtha.lower())
            login = input("Do you want to enable login screen for nishtha program i.e public or private: ")
            if login.lower() == 'public' or login.lower() == 'private':
                config_data.append(login.lower())
            else:
                config_data.append(nishtha.lower())

print()

print("******************************* COPY BELOW CONTENTS AND PASTE IT IN INSTALLATION FILE "
      "*****************************************")

config_data = domain_specific + config_generate + storage_config_data + program_config_data
if len(config_data) > 0:
    for i in range(len(config_data)):
        print(config_data[i])
else:
    print('Configuration file is not generated and Re-run the script')

