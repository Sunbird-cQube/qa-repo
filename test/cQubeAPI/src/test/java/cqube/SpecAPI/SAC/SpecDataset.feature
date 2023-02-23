
Feature: Create the spec dataset in the database

Background: Define the spec dataset API
    Given url "https://cqube-qa.tibilprojects.com/"
    

Scenario Outline: Reading json file and creating spec datasets in database 
  Given path 'spec/dataset'
  * def exp_msg = "Dataset spec created successfully"
  * def exist_msg = "Dataset name already exists"
  * def jsonModel = read('classpath:src/test/java/cqube/Request_Data/SAC/<files>')
  And request jsonModel
  When method POST
  * if (responseStatus == 200 )  karate.call('SpecDataset.feature@valid')
  * if (responseStatus == 400) karate.call('SpecDataset.feature@invalid')
  * if (responseStatus == 500 || responseStatus == 501 || responseStatus == 502 || responseStatus == 503 || responseStatus == 504 ) karate.fail('Server error')
 
 
  Examples:
    | files   | 
    |SAC_stds_atd_cmp_by_block.json|
    |SAC_stds_atd_cmp_by_cluster.json|
    |SAC_stds_atd_cmp_by_district.json|
    |SAC_stds_atd_cmp_by_school.json|
    |SAC_stds_atd_cmp_by_state.json|
    |SAC_stds_avg_atd_by_block.json|
    |SAC_stds_avg_atd_by_cluster.json|
    |SAC_stds_avg_atd_by_district.json|
    |SAC_stds_avg_atd_by_grade.json|
    |SAC_stds_avg_atd_by_school.json|
    |SAC_stds_avg_atd_by_state.json|
    |SAC_stds_avg_atd_cat_wise_by_block.json|
    |SAC_stds_avg_atd_cat_wise_by_cluster.json|
    |SAC_stds_avg_atd_cat_wise_by_district.json|
    |SAC_stds_avg_atd_cat_wise_by_school.json|
    |SAC_stds_avg_atd_cat_wise_by_state.json|
    |SAC_stds_avg_atd_gender_wise_by_block.json|
    |SAC_stds_avg_atd_gender_wise_by_cluster.json|
    |SAC_stds_avg_atd_gender_wise_by_district.json|
    |SAC_stds_avg_atd_gender_wise_by_grade.json|
    |SAC_stds_avg_atd_gender_wise_by_school.json|
    |SAC_stds_avg_atd_gender_wise_by_state.json|
    |SAC_tchs_atd_cmp_by_block.json|
    |SAC_tchs_atd_cmp_by_cluster.json|
    |SAC_tchs_atd_cmp_by_district.json|
    |SAC_tchs_atd_cmp_by_school.json|
    |SAC_tchs_atd_cmp_by_state.json|
    |SAC_tchs_avg_atd_by_block.json|
    |SAC_tchs_avg_atd_by_cluster.json|
    |SAC_tchs_avg_atd_by_district.json|
    |SAC_tchs_avg_atd_by_school.json|
    |SAC_tchs_avg_atd_by_state.json|
    

@valid @ignore
Scenario: Check valid response
    And match response.message == exp_msg
  
@invalid @ignore
Scenario: Check invalid response
    And match response.message == exist_msg 

