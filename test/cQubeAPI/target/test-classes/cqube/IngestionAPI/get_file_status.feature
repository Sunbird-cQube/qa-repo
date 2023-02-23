

Feature: Test Ingestion PUT Status File API 

Background: define the url 
    Given url "https://cqube-qa.tibilprojects.com/ingestion/file-status"

Scenario: Verify the Get Status with valid request body 
    And params {'filename' : '10.csv','ingestion_type': 'event','ingestion_name': 'event_students_attendance'}
    When method get
    Then status 200
    * print response
    And match response.response[0]['pid'] == '#number'
    And match response.response[0]['file_status'] == '#string'
    And match response.response[0]['created_at'] == '#string'

Scenario: Verify the Re-hit the Get Status File 
    And params {'filename' : '10.csv','ingestion_type': 'event','ingestion_name': 'event_students_attendance'}
    When method get
    Then status 200
    * print response
    Then match response.response[0]['pid'] == '#number'
    Then match response.response[0]['file_status'] != ""
    Then match response.response[0]['created_at'] != ""

Scenario: Verify the Get Status File without file_name 
    * def exp_msg = "must have required property 'filename'"
    When method get
    Then status 400
    And match response.message[0]['message'] == exp_msg
    * print response
    * print response.message[0]['message']

Scenario: Verify the Get Status File without file_name 
    And params {'ingestion_type': 'event','ingestion_name': 'event_students_attendance'}
    * def exp_msg = "must have required property 'filename'"
    When method get
    Then status 400
    And match response.message[0]['message'] == exp_msg
    * print response
    * print response.message[0]['message'] , exp_msg

Scenario: Verify the Get Status File without file_name 
    And params { 'filename' : '10.csv' ,'ingestion_name': 'event_students_attendance'}
    * def exp_msg = "must have required property 'ingestion_type'"
    When method get
    Then status 400
    And match response.message[0]['message'] == exp_msg
    * print response
    * print response.message[0]['message'] , exp_msg

Scenario: Verify the Get Status File without ingestion_name 
    And params { 'filename' : '10.csv' ,'ingestion_type': 'event'}
    * def exp_msg = "must have required property 'ingestion_name'"
    When method get
    Then status 400
    And match response.message[0]['message'] == exp_msg
    * print response
    * print response.message[0]['message'] , exp_msg




            
        


