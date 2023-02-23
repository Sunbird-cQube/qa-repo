

Feature: Feature name

Scenario:  test it 
    * def response = {"message": "Invalid dataset name"}
    * print 'size:', response.length



Scenario: test 2  
    * def response = {"message": [{"instancePath": "/ingestion_name","schemaPath": "#/properties/ingestion_name/shouldnotnull","keyword": "shouldnotnull","params": {},"message": "must pass \"shouldnotnull\" keyword validation"}]}
    * print 'size:', response.length
