
Feature: Create the Spec Dimension in the database

Background: Define the spec dimension API
    Given url "https://cqube-qa.tibilprojects.com/"

Scenario Outline: Reading json file and creating spec dimension in database 
  * def jsonModel = read('classpath:src/test/java/cqube/Request_Data/SAC/<files>')
  Given path 'spec/dimension'
  * def exp_msg = "Dimension spec created successfully"
  * def exist_msg = "Dimension name already exists"
  And request jsonModel
  When method POST
  * if (responseStatus == 200 )  karate.call('SpecDimension.feature@valid')
  * if (responseStatus == 400) karate.call('SpecDimension.feature@invalid')
  * if (responseStatus == 500 || responseStatus == 501 || responseStatus == 502 || responseStatus == 503 || responseStatus == 504 ) karate.fail('Server error')
 
 
  Examples:
    | files   | 
    |dimension_block.json|
    |dimension_cluster.json|
    |dimension_district.json|
    |dimension_master.json|
    |dimension_school.json|
    |dimension_state.json|
    

@valid @ignore
Scenario: Check valid response
    And match response.message == exp_msg
  
@invalid @ignore
Scenario: Check invalid response
    And match response.message == exist_msg 

