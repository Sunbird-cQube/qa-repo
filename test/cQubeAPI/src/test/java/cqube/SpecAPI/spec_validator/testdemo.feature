Feature: "Response Validator"

Background: define the url 
    # Given url "https://cqube-qa.tibilprojects.com/spec/event"
    * def request_data = read('classpath:src/test/java/cqube/SpecAPI/spec_validator/demo.json')

Scenario: validate response 
    # *  print request_data 
    * remove request_data.dimension 
    * print request_data