
Feature: demo call

Background: define url 
    * def result = call read('classpath:src/test/java/helpers/calfun.feature')
    
Scenario: call java method 
    * def username = result.username
    * print username
  

