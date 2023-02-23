
Feature: Test Ingestion PUT Status File API 
@setup=project
@ignore
Scenario:
    * def actual_request = read('classpath:src/test/java/cqube/IngestionAPI/put_status_validation.json')
    * def result = call read('classpath:src/test/java/cqube/IngestionAPI/call_putstatus.feature')    
Scenario Outline: ${__row.scenario}
    
    Given url "https://cqube-qa.tibilprojects.com/"
    Given path '/ingestion/file-status'
    * def api_url = "https://cqube-qa.tibilprojects.com/ingestion/file-status"
    * def testcase_type = __row.testcase_type
    * def exp_msg = __row.message
    * def req_json = __row
    * remove __row.scenario
    * remove req_json.message
    * remove req_json.testcase_type
    * print testcase_type 
    * print exp_msg
    * print req_json
    And request req_json
    When method PUT
    * print responseStatus , response , exp_msg
    * if (responseStatus == 200 && testcase_type == "valid")  karate.call('Ingestion_statusFile_put.feature@valid')
    * if (responseStatus == 400 && testcase_type == "invalid") karate.call('Ingestion_statusFile_put.feature@invalid')
    * if (responseStatus == 500 || responseStatus == 501 || responseStatus == 502 || responseStatus == 503 || responseStatus == 504 ) karate.fail('Internal Server Error')
    * match karate.range(201,300) !contains responseStatus
    * match karate.range(401,451) !contains responseStatus
    

        Examples:
            | karate.setup('project').actual_request |


@valid @ignore
Scenario: Check valid response
    * print response.message == exp_msg 
    And match response.message == exp_msg 

@invalid @ignore
Scenario: Check invalid response
    * print response.message[0]['message'] == exp_msg 
    And match response.message[0]['message'] == exp_msg 
   
 



            
        


