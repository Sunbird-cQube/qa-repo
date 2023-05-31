import logging
import time

import sys

from selenium.webdriver.common.by import By

sys.path.append('/home/tanushree/Downloads/cQube_v5/')
from Page_of_objects.CqubeUi.homepage import Homepage
from Page_of_objects.CqubeUi import nas
from Testcases.conftest import ConfTest
from Utilities import CustomLogger
from Utilities.ReadProperties import ReadConfig


class TestDashboard:
    homepage = None
    nas = None
    driver = None
    GetData = None

    def __init__(self):
        self.level = None

    @classmethod
    def setup(cls):
        cls.driver = ConfTest.get_driver()
        cls.driver.implicitly_wait(30)
        cls.homepage = Homepage(cls.driver)
        cls.nas = nas(cls.driver)
        cls.homepage.open_cqube_application()
        cls.homepage.open_login_page()
        cls.homepage.test_click_on_state_button()
        cls.nas.click_on_access_nas_menu()
        cls.logger = CustomLogger.setup_logger('Dashboard', ReadConfig.get_logs_directory() + "/Dashboard.log",
                                               level=logging.DEBUG)

    '''This Test script checking the navigation is happening or not '''

    def test_check_navigation_to_nas(self):
        self.logger.info("*************** Tc_cQube Testing Started *****************")
        time.sleep(2)
        if 'nas' in self.driver.current_url and 'National Achievement Survey (NAS)' in self.driver.page_source:
            self.logger.info("******************* nas Dashboard is Displayed ********************")
            assert True
        else:
            self.logger.error("***************nas Dashboard Button is not Working ******************")
            assert False
        self.nas.click_menu()
        self.logger.info("*************** Tc_cQube Testing Ended *****************")

    '''Test Scripts to Click on the district wise performance Tab '''

    def test_click_on_the_District_Wise_Performance_tab_button(self):
        self.logger.info("*************** Tc_cQube Testing started *****************")
        District_Wise_Performance = self.nas.click_district_wise_performance()
        time.sleep(3)
        if "true" == District_Wise_Performance:
            self.logger.info("*********** Tab is selecting ***************")
            assert True
        else:
            self.logger.error("*********** Tab is not selecting ***************")
            assert False
        self.logger.info("*************** Tc_cQube Testing ended *****************")

    '''This Test script checking the A- Button '''

    def test_click_the_a_minus_button(self):
        self.logger.info("*************** Tc_cQube_homepage_003 Testing Started *****************")
        res = self.nas.test_click_on_a_minus_button()
        if res == 0:
            self.logger.info("*********** A- button is Clicked ****************")
        else:
            self.logger.error("*********** A- button is not Clicked *********")
            assert False
        self.logger.info("*************** Tc_cQube_homepage_003 Testing completed *****************")

    '''This Test script checking the A Plus Button '''

    def test_click_the_a_plus_button(self):
        self.logger.info("*************** Tc_cQube_homepage_004 Testing Started *****************")
        res = self.nas.test_click_on_a_plus_button()
        if res == 0:
            self.logger.info("*********** A+ button is Clicked ****************")
        else:
            self.logger.error("*********** A+ button is not Clicked *********")
            assert False
        self.logger.info("*************** Tc_cQube_homepage_004 Testing completed *****************")

    '''This Test script checking Default A  Button'''

    def test_click_the_default_a_button(self):
        self.logger.info("*************** Tc_cQube_homepage_005 Testing Started *****************")
        res = self.nas.test_click_on_a_plus_button()
        if res == 0:
            self.logger.info("*********** A button is Clicked ****************")
        else:
            self.logger.error("*********** A button is not Clicked *********")
            assert False
        self.logger.info("*************** Tc_cQube_homepage_005 Testing completed *****************")

    '''Test Script to Validate the nas - total schools Metric Card'''

    def test_validate_Total_schools_metrics(self):
        self.logger.info("*************** Testing started *****************")
        time.sleep(5)
        self.nas.click_district_wise_performance()
        time.sleep(5)
        card_value = self.nas.get_total_schools_value()
        card_title = self.nas.get_total_schools_label()
        value = "0"
        if card_title is not None:
            self.logger.info("*********** Total schools card values are showing ***************")
            assert True
        else:
            self.logger.error("*************** Total schools card values are Missing ************")
            assert False
        if str(card_value) >= value and card_value is not None:
            self.logger.info("*********** Total schools card values are showing ***************")
            assert True
        else:
            self.logger.error("*************** Total schools card values are Missing ************")
            assert False

    '''Test Script to Validate the nas - total students surveyed Metric Card'''

    def test_validate_total_Students_Surveyed_metrics(self):
        self.logger.info("*************** Testing started *****************")
        time.sleep(5)
        self.nas.click_district_Wise_Performance_tab()
        time.sleep(5)
        card_value = self.nas.get_total_Students_Surveyed_value()
        card_title = self.nas.get_total_Students_Surveyed_label()
        value = "0"
        if card_title is not None:
            self.logger.info("*********** Total schools card values are showing ***************")
            assert True
        else:
            self.logger.error("*************** Total schools card values are Missing ************")
            assert False
        if str(card_value) >= value and card_value is not None:
            self.logger.info("*********** Total schools card values are showing ***************")
            assert True
        else:
            self.logger.error("*************** Total schools card values are Missing ************")
            assert False

    '''Test Script to Validate the nas - total teachers Metric Card'''

    def test_validate_get_total_teachers_metrics(self):
        self.logger.info("*************** Testing started *****************")
        time.sleep(5)
        self.nas.click_district_Wise_Performance_tab()
        time.sleep(5)
        card_value = self.nas.get_total_teachers_value()
        card_title = self.nas.get_total_teachers_label()
        value = "0"
        if card_title is not None:
            self.logger.info("*********** Total schools card values are showing ***************")
            assert True
        else:
            self.logger.error("*************** Total schools card values are Missing ************")
            assert False
        if str(card_value) >= value and card_value is not None:
            self.logger.info("*********** Total schools card values are showing ***************")
            assert True
        else:
            self.logger.error("*************** Total schools card values are Missing ************")
            assert False

    '''This Test script checking full screen button is working or not'''

    def test_full_screen(self):
        self.logger.info("*************** Tc_cQube_nas_010 Testing started *****************")
        self.nas.click_fullscreen_button()
        time.sleep(3)
        is_full_screen = self.driver.execute_script(
            "return window.screen.width == screen.width && window.screen.height == screen.height;")
        print(is_full_screen)
        assert is_full_screen
        self.logger.info("*************** Tc_cQube_nas_010 Testing ended *****************")

    '''This Test script checking download button functionality is working or not'''

    def test_download_button(self):
        p = nas(self)
        self.nas.click_download_button()
        time.sleep(2)
        program_name = self.driver.find_element(By.CLASS_NAME, 'program-title').text
        tab_name = self.driver.find_element(By.XPATH, "//mat-tab-group/mat-tab-header/div/div/div/div").text

        # for without filter download of csv
        self.file_name = p.get_download_dir() + "/" + (program_name + '' + tab_name + self.level).replace(' ',
                                                                                                          '') + '.csv'
        time.sleep(5)
        self.file_name = p.get_download_dir() + "/"
        print(self.file_name)
        # if os.path.isfile(self.file_name):
        #     print("file is downloaded")
        #     os.remove(self.file_name)
        #     assert True
        # else:
        #     print("file is not downloaded")
        #     assert False

    '''This Test script checking logout button is working or not'''

    def test_district_wise_performance_logout_btn(self):
        self.logger.info("*************** Tc_cQube_homepage_010 Testing ended *****************")
        self.nas.click_district_Wise_Performance_tab()
        time.sleep(2)
        self.nas.test_click_logout_button()
        time.sleep(3)
        if 'login' in self.driver.current_url:
            self.logger.info("*******************  nas page is Displayed ********************")
            assert True
        else:
            self.logger.error("*************** nas Button is not Working ******************")
            assert False
        self.logger.info("*************** Tc_cQube_homepage_006 Testing Ended *****************")



    def test_dropdowns_options_grade(self):
        self.logger.info("*************** Tc_cQube_dropdown_011 Testing started *****************")
        self.nas.click_on_access_nas_menu()
        time.sleep(3)
        self.nas.click_district_Wise_Performance_tab()
        time.sleep(4)
        self.nas.click_on_grade()
        time.sleep(2)
        options = self.nas.get_grade_values()
        grade_count = len(options)
        for grade_dropdown in range(grade_count):
            grade = self.nas.get_each_dropdown_value_id(grade_dropdown)
            grade.click()
            time.sleep(4)
            self.nas.click_on_subject()
            time.sleep(2)
            options = self.nas.get_subject_values()
            subject_count = len(options)-1
            for subject_dropdown in range(subject_count):
                subject = self.nas.get_each_dropdown_value_id(subject_dropdown)
                subject.click()
                time.sleep(2)
                self.nas.click_on_learning_outcome()
                time.sleep(2)
                options = self.nas.get_learning_outcome_values()
                print(len(options))
                learning_outcome_count = len(options)-1
                for dropdown in range(1, learning_outcome_count):
                    learning_outcome_id = self.nas.get_each_dropdown_value_id(dropdown)
                    time.sleep(2)
                    learning_outcome_id.click()
                    time.sleep(2)
                    res2 = self.nas.get_map_tooltip_info_validation()
                    # if "Learning Outcome" in res2[0]:
                    #     assert True
                    #     self.logger.info("Selected Option is showing in the map tooltip")
                    # else:
                    #     self.logger.error("Selected Option is not showing in the map tooltip")
                    #     assert False
                    self.nas.click_on_learning_outcome()
                    time.sleep(3)
                self.nas.click_on_subject()
                time.sleep(3)
            self.nas.click_on_grade()
            time.sleep(3)
        self.logger.info("*************** Tc_cQube_nas_011 Testing started *****************")

    def test_click_on_the_grade_and_subject_performance_tab_button(self):
        self.logger.info("*************** Tc_cQube Testing started *****************")
        self.nas.click_grade_and_subject_Performance_tab()
        grade_and_Subject_Performance = self.nas.click_grade_and_subject_performance()
        time.sleep(3)
        if "true" == grade_and_Subject_Performance:
            self.logger.info("*********** Tab is selecting ***************")
            assert True
        else:
            self.logger.error("*********** Tab is not selecting ***************")
            assert False
        self.logger.info("*************** Tc_cQube Testing ended *****************")












    def test_nas_dropdowns_options(self):
        self.logger.info("*************** Tc_cQube_nas_020 Testing started *****************")
        self.nas.click_on_access_nas_menu()
        time.sleep(3)
        self.nas.click_grade_and_subject_performance()
        time.sleep(4)
        self.nas.click_on_grade()
        time.sleep(2)
        options = self.nas.get_grade_values()
        grade_count = len(options)
        for grade_dropdown in range(grade_count):
            grade = self.nas.get_each_dropdown_value_id(grade_dropdown)
            grade.click()
            time.sleep(4)
            self.nas.click_on_subject()
            time.sleep(2)
            options = self.nas.get_subject_values()
            subject_count = len(options)
            for subject_dropdown in range(subject_count):
                subject = self.nas.get_each_dropdown_value_id(subject_dropdown)
                subject.click()
                time.sleep(2)
                data = self.nas.get_data()
                print(len(data))
                if len(data) > 0:
                    self.logger.info("*************** dropdown option is displaying*****************")
                    assert True
                else:
                    self.logger.info("***************  dropdown option is not displaying *****************")
                    assert False
                self.nas.click_on_subject()
                time.sleep(3)
            self.nas.click_on_grade()
            time.sleep(3)
        self.logger.info("*************** Tc_cQube_nas_020 Testing ended *****************")

