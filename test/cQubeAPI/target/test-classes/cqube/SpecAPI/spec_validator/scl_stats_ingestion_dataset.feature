
Feature: Validate the School Statistics Ingestion Dataset API

@setup=project
@ignore
Scenario:
    * def actual_request = read('classpath:src/test/java/cqube/SpecAPI/spec_validator/scl_stats_ingestion_dataset.json')

Scenario Outline: ${__row.scenario}

    Given url "https://cqube-qa.tibilprojects.com"
    Given path '/ingestion/dataset'
    * def exp_msg = __row.message
    * def req_json = __row
    * remove __row.scenario
    * remove req_json.message
    * def invalid_record_count = __row.invalid_record_count
    * def valid_record_count = __row.valid_record_count
    * remove req_json.invalid_record_count 
    * remove req_json.valid_record_count
    * print invalid_record_count , valid_record_count , __row.scenario
    And request req_json
    When method POST
    * print req_json , response
    Then match responseStatus == 200 
    And match response.message == exp_msg 
    And match response.invalid_record_count == invalid_record_count
    And match response.valid_record_count == valid_record_count

        Examples:
            | karate.setup('project').actual_request |

 



            
        


