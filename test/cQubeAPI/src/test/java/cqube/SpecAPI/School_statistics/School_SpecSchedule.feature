@event
Feature: Create the School Statistics Spec Schedule in the database

Background: Define the spec schedule API
    Given url "https://cqube-qa.tibilprojects.com/"
    * def jsonModel = read('classpath:src/test/java/cqube/Request_Data/<files>')

Scenario Outline: Reading json file and creating spec schedule in database 
  Given path 'spec/schedule'
  And request jsonModel
  When method POST
  * if (responseStatus == 200 )  karate.call('SpecSchedule.feature@valid')
  * if (responseStatus == 400) karate.call('SpecSchedule.feature@invalid')
  * if (responseStatus == 500 || responseStatus == 501 || responseStatus == 502 || responseStatus == 503 || responseStatus == 504 ) karate.fail('Internal Server Error')
 
  Examples:
    | files   | 
    | |
    | |
    | |
    

@valid @ignore
Scenario: Check valid response
    And match response.message == exp_msg
  
@invalid @ignore
Scenario: Check invalid response
    And match response.message == exp_msg 

