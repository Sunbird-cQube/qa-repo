@debug
Feature: calling java funcs

Background: Print the message
    * def dataGenerator = Java.type('helpers.DataGenerator')
    * def username = dataGenerator.nonstaticfunction("world")

Scenario: dummy
    * print username

    