

Feature: Create the Spec transformer in the database

# Background: Define the spec transformer API
#     Given url "https://cqube-qa.tibilprojects.com/ingestion/csv"

# Scenario: Verify the scenario
#   # * def file = karate.readAsString('classpath:src/test/java/cqube/Request_Data/event_test_data.csv')
#   # * def file = read("classpath:src/test/java/cqube/Request_Data/event_test_data.csv")
#   # And multipart file myFile = { read: "classpath:src/test/java/cqube/Request_Data/event_test_data.csv" }
#   # * def = karate.read("classpath:src/test/java/cqube/Request_Data/event_test_data.csv")
#   And multipart file myFile = { read: "event_test_data.csv" , filename: 'event_test_data.csv', contentType: 'text/csv' }

#   And request {'ingestion_type': 'event','ingestion_name': 'event_students_attendance'}
#   When method POST
#   * def exp_msg = "CSV Uploaded Successfully"
#   Then match responseStatus == 200
#   And match response.message == exp_msg

Scenario: 
  * def responseResult = 
  """{
          "message": [
              {
                  "instancePath": "",
                  "schemaPath": "#/required",
                  "keyword": "required",
                  "params": {
                      "missingProperty": "ingestion_name"
                  },
                  "message": "must have required property 'ingestion_name'"
              }
          ]
      }"""
  * print responseResult.message[0]['message']