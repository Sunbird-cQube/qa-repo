
# Scenario: sleep methods 
#     # * def sleep = function(pause){ java.lang.Thread.sleep(pause*1000) }
#     # * print 'before'
#     # * call sleep 5
#     # * print 'after'
#     * def file = "dimension_district.csv"
#     * def fileName = file.substring(0, file.lastIndexOf('.'));
#     * def ingest_type = fileName.substring(0, fileName.lastIndexOf('_'));
#     * def body = {"file":'#(file)',"ingestion_type": '#(ingest_type)' , "ingestion_name":'#(fileName)'}
#     * print body

#   from a csv file

#   Scenario Outline:
#     Given url 'https://cqube-qa.tibilprojects.com/ingestion/csv'
#     * multipart file myFile = { read: '<fileName>', filename: '<fileName>', contentType: 'multipart/form-data' }
#     * multipart field message = 'file'
#     When method post
#     Then status 200
#     Examples:
#       | fileName = read('classpath:/SAC_Files/dimension_block.csv') |

# Scenario: upload image
#     Given url 'https://cqube-qa.tibilprojects.com/ingestion/csv'
#     And multipart file file = { read: 'dimension_block.csv', filename: 'dimension_block.csv', contentType: 'text/csv' }
#     And multipart field ingestion_type = "dimension"
#     And multipart field ingestion_name = "dimension_block"
#     When method post
#     * print response
#     Then status 200

Feature: scenario outline using a dynamic table

# Background: define file paths 
    # * def files = "/SAC_Files/dimension_block.csv"
Scenario Outline: upload image
    * def files = "/SAC_Files/<file>"
    * print files
    # Given url 'https://cqube-qa.tibilprojects.com/ingestion/csv'
    # And multipart file file = { read: '#(files)', filename: '#(file)', contentType: 'text/csv' }
    * def ingestionname = file.substring(0, file.lastIndexOf('.'));
    * def ingesttype = file.substring(0, file.lastIndexOf('_'));
    * def ingest = ingesttype.substring(0, ingesttype.lastIndexOf('_'));
    * def ingest_type = ingest.substring(0, ingest.lastIndexOf('_'));
    * print ingestionname , ingest_type
    # And multipart field ingestion_type = ingesttype
    # And multipart field ingestion_name = ingestionname
    # When method post
    # * print response
    # Then status 200
        Examples:
        |file|
        |event_school_statistics_students.csv|
        # |event_school_statistics_teachers_attendance.csv|
        # |dimension_cluster.csv|
        # |dimension_school.csv|
        # |dimension_state.csv|
        # |dimension_master.csv|