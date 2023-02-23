Feature:
@validate @ignore
Scenario:
    * remove req_json.message
    * remove req_json.testcase_type
    Given url api_url
    And request req_json
    When method POST   
    * if (responseStatus == 200 && testcase_type == "valid")  karate.call('classpath:src/test/java/cqube/helpers/validate_datadriven_api.feature@valid_api')
    * if (responseStatus == 400 && testcase_type == "invalid") karate.call('classpath:src/test/java/cqube/helpers/validate_datadriven_api.feature@invalid_api')
    * if (responseStatus == 200 && testcase_type == "invalid") karate.fail('Expected result is not matched with actual result')
    * if (responseStatus == 400 && testcase_type == "valid") karate.fail('Expected result is not matched with actual result')
    * if (responseStatus == 500 || responseStatus == 501 || responseStatus == 502 || responseStatus == 503 || responseStatus == 504 ) karate.fail('Server error')
    * match karate.range(201,300) !contains responseStatus
    * match karate.range(401,451) !contains responseStatus
    

@valid_api @ignore
Scenario: Check valid response
    
    And match response.message == exp_msg

@invalid_api @ignore
Scenario: Check invalid response
    * def resp1 = 
    """
        {
            "message": "#string"
        }
    """
    * def resp2 = 
    """
        {
            "message": [
                {
                    "instancePath": "#ignore",
                    "schemaPath": "#ignore",
                    "keyword": "#ignore",
                    "params": "#ignore",              
                    "message": "#string"
                }
            ]
        }
    """
    * def result1 =  karate.match(response,resp1)
    * def result2 = karate.match(response,resp2)
    * print result1 , result2 , response , resp1 , resp2
    * if (result1.pass == true) karate.call('validate_response1.feature@validate',{"actual_output":response.message,"expected_output":exp_msg})
    * if (result2.pass == true) karate.call('validate_response2.feature@validate',{"actual_output":response.message[0].message,"expected_output":exp_msg})