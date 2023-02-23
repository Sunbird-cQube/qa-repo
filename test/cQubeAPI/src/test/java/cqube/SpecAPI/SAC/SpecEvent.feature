
Feature: Create the spec event in the database

Background: Define the spec event API
    Given url "https://cqube-qa.tibilprojects.com/"
    

Scenario Outline: Reading json file and creating spec event in database 
  Given path 'spec/event'
  * def exp_msg = "Event spec created successfully"
  * def exist_msg = "Event name already exists"
  * def jsonModel = read('classpath:src/test/java/cqube/Request_Data/SAC/<files>')
  And request jsonModel
  When method POST
  * if (responseStatus == 200 )  karate.call('SpecEvent.feature@valid')
  * if (responseStatus == 400) karate.call('SpecEvent.feature@invalid')
  * if (responseStatus == 500 || responseStatus == 501 || responseStatus == 502 || responseStatus == 503 || responseStatus == 504 ) karate.fail('Internal Server Error')
 
  Examples:
    | files   | 
    |event_students_attendance.json|
    |event_teachers_attendance.json|
    
    

@valid @ignore
Scenario: Check valid response
    And match response.message == exp_msg
  
@invalid @ignore
Scenario: Check invalid response
    And match response.message == exist_msg
    * print response 

