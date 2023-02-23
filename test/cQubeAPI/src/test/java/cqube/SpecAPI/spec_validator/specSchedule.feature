
Feature: Test Spec Schedule API 
@setup=project
@ignore
Scenario:
    * def actual_request = read('classpath:src/test/java/cqube/SpecAPI/spec_validator/specSchedule_validator.json')

Scenario Outline: ${__row.scenario}

    Given url "https://cqube-qa.tibilprojects.com/"
    Given path '/spec/schedule'
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
    When method POST
    * print response , exp_msg
    * if (responseStatus == 200 && testcase_type == "Valid")  karate.call('specSchedule.feature@valid')
    * if (responseStatus == 400 && testcase_type == "Invalid") karate.call('specSchedule.feature@invalid')
    * if (responseStatus == 500 || responseStatus == 501 || responseStatus == 502 || responseStatus == 503 || responseStatus == 504 ) karate.fail('Internal Server Error')
    * match karate.range(201,300) !contains responseStatus
    * match karate.range(401,451) !contains responseStatus


        Examples:
            | karate.setup('project').actual_request |


@valid @ignore
Scenario: Check valid response
    And match response.message == exp_msg 

@invalid @ignore
Scenario: Check invalid response
    And match response.message[0]['message'] == exp_msg 
   
 



            
        


