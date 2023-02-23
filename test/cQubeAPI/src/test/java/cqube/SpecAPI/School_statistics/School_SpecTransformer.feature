
Feature: Create the School Statistics Spec transformer in the database

@setup=project
@ignore
Scenario: Define the spec transformer API
    * def jsonModel = read('classpath:src/test/java/cqube/Request_Data/School_Statistics/School_Statistics_Transformer.json')

Scenario Outline: Verify the scenario
  Given url "https://cqube-qa.tibilprojects.com/spec/transformer"
  * def reqbody = __row
  * print reqbody
  * def exp_msg = "Transformer created successfully"
  And request reqbody
  When method POST
  Then match responseStatus == 200
  * print response
  * if (responseStatus == 200 )  karate.call('School_SpecTransformer.feature@valid')
  * if (responseStatus == 400) karate.call('School_SpecTransformer.feature@invalid')
  * if (responseStatus == 500 || responseStatus == 501 || responseStatus == 502 || responseStatus == 503 || responseStatus == 504 ) karate.fail('Internal Server Error')

    Examples:
      |karate.setup('project').jsonModel|

@valid @ignore
Scenario: Check valid response
    And match response.message == exp_msg
    
@invalid @ignore
Scenario: Check invalid response
    And match response.message == exp_msg 
  