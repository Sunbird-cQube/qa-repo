
Feature: Create the School Statistics Spec Datasets in the database

Background: Define the spec dataset API
    Given url "https://cqube-qa.tibilprojects.com/"
    

Scenario Outline: Reading json file and creating spec datasets in database 
  Given path 'spec/dataset'
  * def exp_msg = "Dataset spec created successfully"
  * def exist_msg = "Dataset name already exists"
  * def jsonModel = read('classpath:src/test/java/cqube/Request_Data/School_Statistics/<files>')
  And request jsonModel
  When method POST
  * if (responseStatus == 200 )  karate.call('School_SpecDataset.feature@valid')
  * if (responseStatus == 400) karate.call('School_SpecDataset.feature@invalid')
  * if (responseStatus == 500 || responseStatus == 501 || responseStatus == 502 || responseStatus == 503 || responseStatus == 504 ) karate.fail('Server error')
 
 
  Examples:
    | files   | 
    |Scl_stats_avg_pupil_tch_ratio_by_block.json|
    |Scl_stats_avg_pupil_tch_ratio_by_cluster.json|
    |Scl_stats_avg_pupil_tch_ratio_by_district.json|
    |Scl_stats_avg_pupil_tch_ratio_by_grade.json|
    |Scl_stats_avg_pupil_tch_ratio_by_school.json|
    |Scl_stats_avg_pupil_tch_ratio_by_state.json|
    |Scl_stats_cat_wise_schools_by_block.json|
    |Scl_stats_cat_wise_schools_by_cluster.json|
    |Scl_stats_cat_wise_schools_by_district.json|
    |Scl_stats_cat_wise_schools_by_state.json|
    |Scl_stats_cwsn_enroll_by_block.json|
    |Scl_stats_cwsn_enroll_by_cluster.json|
    |Scl_stats_cwsn_enroll_by_district.json|
    |Scl_stats_cwsn_enroll_by_grade.json|
    |Scl_stats_cwsn_enroll_by_school.json|
    |Scl_stats_cwsn_enroll_by_state.json|
    |Scl_stats_gender_wise_enroll_by_block.json|
    |Scl_stats_gender_wise_enroll_by_cluster.json|
    |Scl_stats_gender_wise_enroll_by_district.json|
    |Scl_stats_gender_wise_enroll_by_grade.json|
    |Scl_stats_gender_wise_enroll_by_school.json|
    |Scl_stats_gender_wise_enroll_by_state.json|
    |Scl_stats_grade_wise_avg_pupil_tch_ratio_by_block.json|
    |Scl_stats_grade_wise_avg_pupil_tch_ratio_by_cluster.json|
    |Scl_stats_grade_wise_avg_pupil_tch_ratio_by_district.json|
    |Scl_stats_grade_wise_avg_pupil_tch_ratio_by_school.json|
    |Scl_stats_grade_wise_avg_pupil_tch_ratio_by_state.json|
    |Scl_stats_grade_wise_enroll_by_block.json|
    |Scl_stats_grade_wise_enroll_by_cluster.json|
    |Scl_stats_grade_wise_enroll_by_district.json|
    |Scl_stats_grade_wise_enroll_by_school.json|
    |Scl_stats_grade_wise_enroll_by_state.json|
    |Scl_stats_grade_wise_tchs_by_block.json|
    |Scl_stats_grade_wise_tchs_by_cluster.json|
    |Scl_stats_grade_wise_tchs_by_district.json|
    |Scl_stats_grade_wise_tchs_by_school.json|
    |Scl_stats_grade_wise_tchs_by_state.json|
    |Scl_stats_std_cat_wise_enroll_by_block.json|
    |Scl_stats_std_cat_wise_enroll_by_cluster.json|
    |Scl_stats_std_cat_wise_enroll_by_district.json|
    |Scl_stats_std_cat_wise_enroll_by_grade.json|
    |Scl_stats_std_cat_wise_enroll_by_school.json|
    |Scl_stats_std_cat_wise_enroll_by_state.json|
    |Scl_stats_total_enroll_by_block.json|
    |Scl_stats_total_enroll_by_cluster.json|
    |Scl_stats_total_enroll_by_district.json|
    |Scl_stats_total_enroll_by_grade.json|
    |Scl_stats_total_enroll_by_school.json|
    |Scl_stats_total_enroll_by_state.json|
    |Scl_stats_total_schools_by_block.json|
    |Scl_stats_total_schools_by_cluster.json|
    |Scl_stats_total_schools_by_district.json|
    |Scl_stats_total_schools_by_state.json|
    |Scl_stats_total_tchs_by_block.json|
    |Scl_stats_total_tchs_by_cluster.json|
    |Scl_stats_total_tchs_by_district.json|
    |Scl_stats_total_tchs_by_school.json|
    |Scl_stats_total_tchs_by_state.json|
 
    

@valid @ignore
Scenario: Check valid response
    And match response.message == exp_msg
  
@invalid @ignore
Scenario: Check invalid response
    And match response.message == exist_msg 

