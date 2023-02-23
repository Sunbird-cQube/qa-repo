
Feature: Ingestion of Dimension Input Data Files
   
Scenario Outline: Ingestion of Dimension Data Files
    * def files = "/SAC_Files/<file>"
    Given url 'https://cqube-qa.tibilprojects.com/ingestion/csv'
    And multipart file file = { read: '#(files)', filename: '#(file)', contentType: 'text/csv' }
    * def ingestionname = file.substring(0, file.lastIndexOf('.'));
    * def ingesttype = file.substring(0, file.lastIndexOf('_'));
    * def exp_msg = 'File is being processed'
    And multipart field ingestion_type = ingesttype
    And multipart field ingestion_name = ingestionname
    When method post
    * print response
    Then status 200
    And match response.message == exp_msg
    * if (responseStatus == 200 )  karate.call('Ingestion_dimensions.feature@valid')
    * if (responseStatus == 400) karate.call('Ingestion_dimensions.feature@invalid')
    * if (responseStatus == 500 || responseStatus == 501 || responseStatus == 502 || responseStatus == 503 || responseStatus == 504 ) karate.fail('Server error')

        Examples:
        |file|
        |dimension_block.csv|
        |dimension_cluster.csv|
        |dimension_district.csv|
        |dimension_school.csv|
        |dimension_state.csv|
        |dimension_master.csv|


@valid @ignore
Scenario: Check valid response
    And match response.message == exp_msg
  
@invalid @ignore
Scenario: Check invalid response
    And match response containts exist_msg 

