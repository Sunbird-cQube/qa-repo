
Feature: Ingestion of SAC Event Data Files
Scenario Outline: upload image
    * def files = "/SAC_Files/<file>"
    Given url 'https://cqube-qa.tibilprojects.com/ingestion/csv'
    And multipart file file = { read: '#(files)', filename: '#(file)', contentType: 'text/csv' }
    * def ingest_name = file.substring(0, file.lastIndexOf('.'));
    * def ingesttype = file.substring(0, file.lastIndexOf('_'));
    * def ingest_type = ingesttype.substring(0, ingesttype.lastIndexOf('_'));
    * def exp_msg = 'File is being processed'
    And multipart field ingestion_type = ingest_type
    And multipart field ingestion_name = ingest_name
    When method post
    * print response
    Then status 200
    And match response.message == exp_msg
    * if (responseStatus == 200 )  karate.call('SAC_IngestEvents.feature@valid')
    * if (responseStatus == 400) karate.call('SAC_IngestEvents.feature@invalid')
    * if (responseStatus == 500 || responseStatus == 501 || responseStatus == 502 || responseStatus == 503 || responseStatus == 504 ) karate.fail('Server error')

        Examples:
        |file|
        |event_students_attendance.csv|
        |event_teachers_attendance.csv|
        


@valid @ignore
Scenario: Check valid response
    And match response.message == exp_msg
  
@invalid @ignore
Scenario: Check invalid response
    And match response containts exist_msg 

