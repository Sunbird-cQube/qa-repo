import time

import requests
import yaml

with open('config_files/config.yml', 'r') as file:
    config_data = yaml.safe_load(file)

# Access the 'storage_type' value from the configuration
storage_type = config_data.get('storage_type')
print(f'Storage type: {storage_type}')

nifi_host = 'http://127.0.0.1'
nifi_port = 8096


def get_nifi_root_pg():
    """ Fetch nifi root processor group ID"""
    res = requests.get(f'{nifi_host}:{nifi_port}/nifi-api/process-groups/root', verify=True)
    if res.status_code == 200:
        global nifi_root_pg_id
        nifi_root_pg_id = res.json()['component']['id']
        # print(nifi_root_pg_id)
        return res.json()['component']['id']
    else:
        return res.text


def get_processor_group_info(processor_group_name):
    """
    Get processor group details
    """
    nifi_root_pg_id = get_nifi_root_pg()
    pg_list = requests.get(f'{nifi_host}:{nifi_port}/nifi-api/flow/process-groups/{nifi_root_pg_id}')
    if pg_list.status_code == 200:
        # Iterate over processGroups and find the required processor group details
        for i in pg_list.json()['processGroupFlow']['flow']['processGroups']:
            if i['component']['name'] == processor_group_name:
                global processor_group
                processor_group = i
                return i
    else:
        return 'failed to list the processor groups'


def get_processor_group_ports(processor_group_name):
    # Get processor group details
    global pg_source
    pg_source = get_processor_group_info(processor_group_name)
    pg_details = requests.get(f"{nifi_host}:{nifi_port}/nifi-api/flow/process-groups/{pg_source['component']['id']}")
    if pg_details.status_code != 200:
        return pg_details.text
    else:
        return pg_details


def get_nifi_status(processor_group_name):
    status = []
    id = get_processor_group_ports(processor_group_name)

    response = id.json()['processGroupFlow']['flow']['processors']
    for i in response:
        status.append(i['component']['state'])
    return status


def verify_processor_running_status(process_group, processor_group_name):
    count = 0
    for i in process_group:
        if i == "RUNNING":
            count = count + 1
        elif i == 'STOPPED':
            continue
    if count == len(process_group):
        print(processor_group_name, ' - All Nifi Processor Groups are Running')
        pass
    else:
        print(processor_group_name, " Processors are Not Running ", count, len(process_group))
        assert False


def verify_processor_status_stop_status(process_group, processor_group_name):
    count = 0
    for i in process_group:
        if i == "STOPPED":
            count = count + 1
        elif i == 'RUNNING':
            continue
    if count == len(process_group):
        print(processor_group_name, ' - Nifi Processor Groups Are In STOPPED! ')
        pass
    else:
        print(processor_group_name, " Processor Groups Are in RUNNING! ", count, len(process_group))
        assert False


#Run_adapters = get_nifi_status('Run_adapters')
#onestep_data_ingestion = get_nifi_status('onestep_dataingestion_' + storage_type)
#pm_poshan = get_nifi_status('pm_poshan_' + storage_type)
#udise = get_nifi_status('udise_' + storage_type)
#nas = get_nifi_status('nas_' + storage_type)

#print(" Run Adapter Processor Group is Scheduling After 7 min's - Program Paused (7 min's) ")
#time.sleep(7 * 60)
#verify_processor_running_status(Run_adapters, 'Run_adapters')

#print(" One Step Data Ingestion Processor Group is Scheduling After 2 min's - Program Paused (2 min's) ")
#time.sleep(2 * 60)
#verify_processor_running_status(onestep_data_ingestion, 'onestep_dataingestion_' + storage_type)

print("Nifi Work Flow is in progress - pausing python script to 15 mins ")
time.sleep(15 * 60)
#onestep_data_ingestion = get_nifi_status('onestep_dataingestion_' + storage_type)
#while 'STOPPED' in onestep_data_ingestion:
   # verify_processor_running_status(udise, 'udise_' + storage_type)
   # time.sleep(2 * 60)
  #  verify_processor_status_stop_status(udise, 'udise_' + storage_type)

 #   verify_processor_running_status(pm_poshan, 'pm_poshan_' + storage_type)
 #   time.sleep(2 * 60)
 #   verify_processor_status_stop_status(pm_poshan, 'pm_poshan_' + storage_type)

#    verify_processor_running_status(nas, 'nas_' + storage_type)
#    time.sleep(2 * 60)
#    verify_processor_status_stop_status(nas, 'nas_' + storage_type)


verify_processor_status_stop_status(udise, 'udise_' + storage_type)
verify_processor_status_stop_status(pm_poshan, 'pm_poshan_' + storage_type)
verify_processor_status_stop_status(nas, 'nas_' + storage_type)

print("******************************** NIFI VALIDATION IS COMPLETED ***************************************")

