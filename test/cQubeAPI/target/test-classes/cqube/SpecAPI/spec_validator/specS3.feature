
Feature: Test Spec S3 API 
@setup=project
@ignore
Scenario:
    * def actual_request = read('classpath:src/test/java/cqube/SpecAPI/spec_validator/s3_validation.json')

Scenario Outline: ${__row.scenario}

    Given url "https://cqube-qa.tibilprojects.com/"
    Given path '/spec/s3'
    * def api_url = "https://cqube-qa.tibilprojects.com/spec/s3"
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
    * print responseStatus , response , exp_msg
    * if (testcase_type == null && exp_msg == null) karate.call('classpath:src/test/java/cqube/helpers/validate_basic_api.feature@validate',{"api_url":api_url,"request_body":req_json})
    * if (testcase_type != null && exp_msg != null) karate.call('classpath:src/test/java/cqube/helpers/validate_datadriven_api.feature@validate',{"api_url":api_url,"request_body":req_json,"testcase_type":testcase_type,"exp_msg":exp_msg})


        Examples:
            | karate.setup('project').actual_request |

 



            
        


