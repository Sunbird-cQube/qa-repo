

Feature: call the ingestion/file-status API

Background: define the url 
    Given url "https://cqube-qa.tibilprojects.com"

Scenario: "Verify status File API with providing  ingestion_name as invalid "
    Given path '/ingestion/file-status'
    And request {"file_name": "event_students_attendance.csv","ingestion_type": "event","ingestion_name": "students_attendance","status": "Processing"},
    * def result = "No file exists with the given details"
    When method PUT
    Then match responseStatus == 400 
    And match response.message == result
    * print response 


