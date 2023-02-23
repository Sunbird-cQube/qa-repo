@event
Feature: Create the spec pipeline in the database

@setup=project
@ignore

Scenario:
    * def jsonModel = read('classpath:src/test/java/cqube/Request_Data/SAC/SAC_pipeline.json')

Scenario Outline: Reading json file and creating spec event in database
    Given url "https://cqube-qa.tibilprojects.com" 
    Given path '/spec/pipeline'

    * def requestbody = __row
    * def exp_msg = "Processor group created successfully"
    * def exist_msg = "Pipeline name already exists"
    And request requestbody
    When method POST
    * print requestbody , response , exp_msg
    * if (responseStatus == 200 )  karate.call('SpecPipeline.feature@valid')
    * if (responseStatus == 400) karate.call('SpecPipeline.feature@invalid')
    * if (responseStatus == 500 || responseStatus == 501 || responseStatus == 502 || responseStatus == 503 || responseStatus == 504 ) karate.fail('Internal Server Error')
    
        Examples:
            |karate.setup('project').jsonModel|
    
    

@valid @ignore
Scenario: Check valid response
    And match response.message == exp_msg
  
@invalid @ignore
Scenario: Check invalid response
    And match response.message == exist_msg 

