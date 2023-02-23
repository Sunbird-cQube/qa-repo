
Feature: Create the spec event in the database

Background: Define the spec event API
    Given url "https://cqube-qa.tibilprojects.com/"
    Given path 'ingestion/csv'
    And header Content-Type = 'text/csv'
    datasource = ""
    * def event_csv = read('classpath:src/test/java/Spec_APIs/Request_Data/event.csv')
    * def dimension_csv = read('classpath:src/test/java/Spec_APIs/Request_Data/dimension.csv')
    * def dataset_csv = read('classpath:src/test/java/Spec_APIs/Request_Data/dataset.csv')

Scenario: Ingest event csv file 
    And params { "ingestion_type" : "event" , "ingestion_name": <datasource>}
    And request event_csv
    When method POST
    Then status 200
    And match response == "Event Added Successfully"
    And response != {}

# Scenario: Ingest dimension csv file 
#     And params { "ingestion_type" : "dimension" , "ingestion_name": <datasource>}
#     And request dimension_csv
#     When method POST
#     Then status 200
#     And match response == "Dimension Added Successfully"
#     And response != {}

# Scenario: Ingest dataset csv file 
#     And params { "ingestion_type" : "dataset" , "ingestion_name": <datasource>}
#     And request dataset_csv
#     When method POST
#     Then status 200
#     And match response == "Dataset Added Successfully"
#     And response != {}
    