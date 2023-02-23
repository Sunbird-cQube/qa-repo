Feature:
@validate @ignore
Scenario:
    Given url api_url
    And request req_json
    When method POST
    * if (responseStatus == 200 )  karate.call('classpath:src/test/java/cqube/helpers/validate_basic_api.feature@validate_response')
    * if (responseStatus == 400 ) karate.call('classpath:src/test/java/cqube/helpers/validate_basic_api.feature@validate_invalid_response')
    * if (responseStatus == 500 || responseStatus == 501 || responseStatus == 502 || responseStatus == 503 || responseStatus == 504 ) karate.fail('Server error')
    * match karate.range(201,300) !contains responseStatus
    * match karate.range(401,451) !contains responseStatus

@validate_response @ignore
Scenario: Check valid response
    * def resp = 
    """
        {
            "message": "#string"
        }
    """
    And match response == resp

@validate_invalid_response @ignore
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
                    "params": {
                        "type": "#string"
                    },
                    "message": "#string"
                }
            ]
        }
    """
    * def result1 =  karate.match(response,resp1)
    * def result2 = karate.match(response,resp2)
    * if (result1.pass == true) karate.call('classpath:cqubeApp/cqube_feature_files/helpers/validate_response1.feature@validate',{"actual_output":response,"expected_output":resp1})
    * if (result2.pass == true) karate.call('classpath:cqubeApp/cqube_feature_files/helpers/validate_response2.feature@validate',{"actual_output":response,"expected_output":resp2})


    


