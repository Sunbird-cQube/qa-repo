
@event
Feature: Create the School Statistics spec pipeline in the database

@setup=project
@ignore

Scenario:
    * def jsonModel = read('classpath:src/test/java/cqube/Request_Data/School_Statistics/School_Statistics_Pipeline.json')

Scenario Outline: Reading json file and creating spec event in database
    Given url "https://cqube-qa.tibilprojects.com" 
    Given path '/spec/pipeline'
    * def requestbody = __row
    * print requestbody
    * def exp_msg = "Processor group created successfully"
    * def exist_msg = "Pipeline name already exists"
    And request requestbody
    When method POST
    * print response
    * if (responseStatus == 200 )  karate.call('School_SpecPipeline.feature@valid')
    * if (responseStatus == 400) karate.call('School_SpecPipeline.feature@invalid')
    * if (responseStatus == 500 || responseStatus == 501 || responseStatus == 502 || responseStatus == 503 || responseStatus == 504 ) karate.fail('Internal Server Error')
    
        Examples:
            |karate.setup('project').jsonModel|
    
    

@valid @ignore
Scenario: Check valid response
    And match response.message == exp_msg
  
@invalid @ignore
Scenario: Check invalid response
    And match response.message == exist_msg 

