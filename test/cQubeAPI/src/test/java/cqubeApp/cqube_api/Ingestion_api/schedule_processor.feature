Feature: Reschedule the processor execution time 

Background: Define url 
    * def app_url = call read('classpath:/src/test/java/cqubeApp/cqube_api/app_url.feature')
    * def URL = app_url.app_url
    Given url URL
    * def adapter_schedule = "0 41 15 * * ?"
    * def run_code_schedule = "0 45 15 * * ?"


Scenario: Reschedule the Run adapters Code Processor 
    And path '/api/spec/schedule'
    And request {"processor_group_name": "Run_adapters","scheduled_at": '#(adapter_schedule)'}
    When method Post 
    Then match responseStatus == 200
    And match response.message == "Successfully updated the schedule"

Scenario: Reschedule the Run Latest Code Processor 
    And path '/api/spec/schedule'
    And request {"processor_group_name": "Run Latest Code local","scheduled_at": '#(run_code_schedule)'}
    When method Post 
    Then match responseStatus == 200
    And match response.message == "Successfully updated the schedule"

Scenario: Reschedule the Run Student Attendance Code Processor 
    And path '/api/spec/schedule'
    And request {"processor_group_name": "Plugin Student Attendance local","scheduled_at": '#(processing_schedule)'}
    When method Post 
    Then match responseStatus == 200
    And response.message == "Successfully updated the schedule"

Scenario: Reschedule the Run Teachers Attendance Code Processor 
    And path '/api/spec/schedule'
    And request {"processor_group_name": "Plugin Teachers Attendance local","scheduled_at":'#(processing_schedule)'}
    When method Post 
    Then match responseStatus == 200
    And response.message == "Successfully updated the schedule"

Scenario: Reschedule the Run district review Code Processor 
    And path '/api/spec/schedule'
    And request {"processor_group_name": "district-review-meetings-local","scheduled_at": '#(processing_schedule)'}
    When method Post 
    Then match responseStatus == 200
    And response.message == "Successfully updated the schedule"

Scenario: Reschedule the Run block review Code Processor 
    And path '/api/spec/schedule'
    And request {"processor_group_name": "block-review-meetings-local","scheduled_at": '#(processing_schedule)'}
    When method Post 
    Then match responseStatus == 200
    And response.message == "Successfully updated the schedule"

Scenario: Reschedule the Run cluster review Code Processor 
    And path '/api/spec/schedule'
    And request {"processor_group_name": "cluster-review-meetings-local","scheduled_at": '#(processing_schedule)'}
    When method Post 
    Then match responseStatus == 200
    And response.message == "Successfully updated the schedule"
