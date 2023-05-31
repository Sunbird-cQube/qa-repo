import logging
import os
import time
import re

from selenium.webdriver.common.alert import Alert

from Page_of_objects.CqubeUi.homepage import Homepage
from Page_of_objects.CqubeUi.summary_statistics import Summarystatistics
from Page_of_objects.CqubeUi.teacher_attendance import Teacherattendance
from Page_of_objects.CqubeUi.udise import Udise
from Testcases.conftest import ConfTest
from Utilities import CustomLogger
from Utilities.ReadProperties import ReadConfig


class TestUdise:
    homepage = None
    summarystatistics = None
    teacherattendance = None
    udise = None
    driver = None

    @classmethod
    def setup(cls):
        cls.driver = ConfTest.get_driver()
        cls.driver.implicitly_wait(30)
        cls.homepage = Homepage(cls.driver)
        cls.summarystatistics = Summarystatistics(cls.driver)
        cls.teacherattendance = Teacherattendance(cls.driver)
        cls.udise = Udise(cls.driver)
        cls.homepage.open_cqube_application()
        cls.homepage.open_login_page()
        cls.summarystatistics.test_click_on_state_button()
        cls.udise.test_click_on_udise_menu()
        cls.logger = CustomLogger.setup_logger('udise', ReadConfig.get_logs_directory() +
                                               "/udise.log", level=logging.DEBUG)

    def test_udise_page(self):
        self.logger.info("*************** Tc_cQube_udise_001 Testing started *****************")
        time.sleep(5)
        if "UDISE+" in self.driver.page_source:
            print("Udise is displaying")
            self.logger.info("*********** udise page is displaying ****************")
        else:
            print("udise page is not displaying")
            self.logger.error("*********** udise page is not displaying ****************")
        self.logger.info("*************** Tc_cQube_udise_001 Testing ended *****************")

    # district_wise_performance
    """Check whether Average_Teachers_Reporting_Attendance tab is opening or not"""

    def test_click_on_the_district_wise_performance_tab_button(self):
        self.logger.info("*************** Tc_cQube_udise_002 Testing started *****************")
        district_wise_performance = self.udise.click_district_wise_performance()
        if "true" == district_wise_performance:
            print("district_wise_performance tab is opening")
            self.logger.info("*********** Tab is selecting ***************")
        else:
            self.logger.error("*********** Tab is not selecting ***************")
            assert False
        self.logger.info("*************** Tc_cQube_udise_002 Testing ended *****************")

    def test_home_button(self):
        self.logger.info("*************** Tc_cQube_udise Testing Started *****************")
        self.homepage.click_homebutton()
        if 'Please select your role' in self.driver.page_source:
            print("Home_button is working")
            self.logger.info("*********** Home_button is working *********")
        else:
            self.logger.error("*********** Home_button is not working *********")
            print("Home_button is not working")
            assert False
        self.logger.info("*************** Tc_cQube_udise Testing ended *****************")

    def test_click_the_a_minus_button(self):
        self.logger.info("*************** Tc_cQube_udise_004 Testing started *****************")
        res = self.homepage.test_click_on_a_minus_button()
        if res == 0:
            self.logger.info("*********** A- button is Clicked ****************")
            print("A- button is clicked")
        else:
            self.logger.error("*********** A- button is not Clicked *********")
            print("A- button is not clicked")
            assert False
        self.logger.info("*************** Tc_cQube_udise_004 Testing ended *****************")

    '''This Test script checking the A Plus Button '''

    def test_click_the_a_plus_button(self):
        self.logger.info("*************** Tc_cQube_udise_005 Testing started *****************")
        res = self.homepage.test_click_on_a_plus_button()
        if res == 0:
            self.logger.info("*********** A+ button is Clicked ****************")
            print("A+ button is clicked and working as expected")
        else:
            self.logger.error("*********** A+ button is not Clicked *********")
            print("A+ button is clicked and not working")
            assert False
        self.logger.info("*************** Tc_cQube_udise_005 Testing Ended *****************")

    '''This Test script checking Default A  '''

    def test_click_the_default_a_button(self):
        self.logger.info("*************** Tc_cQube_udise_006 Testing started *****************")
        res = self.homepage.test_click_on_a_plus_button()
        if res == 0:
            self.logger.info("*********** A button is Clicked ****************")
            print("A button is clicked and its working ")
        else:
            self.logger.error("*********** A button is not Clicked *********")
            print("A button is clicked and it is not working")
            assert False
        self.logger.info("*************** Tc_cQube_udise_006 Testing Ended *****************")

    def test_logout(self):
        self.logger.info("*************** Tc_cQube_udise_007 Testing Started *****************")
        time.sleep(5)
        self.homepage.click_logout()
        if "login" in self.driver.current_url:
            print("Logout button is working")
            self.logger.info("*********** Logout button is working *********")
        else:
            self.logger.error("*********** Logout button is not working *********")
            print("Logout button is not working")
            assert False
        self.logger.info("*************** Tc_cQube_udise_007 Testing ended *****************")

    def test_validate_total_students_metrics(self):
        self.logger.info("*************** Tc_cQube_udise_008 Testing started *****************")
        total_students = self.udise.get_Total_Students_value()
        total_students_value = re.sub(self.udise.L, "", total_students)
        total_students_text = self.udise.get_Total_Students_text()
        if total_students_text is not None:
            print("Total_Students Card Value is showing")
            self.logger.info("*********** Total_Students Card Value is showing ***************")
        else:
            print("Total_Students Card Value is Missing")
            self.logger.error("*************** Total_Students Card Value is Missing ************")
            assert False
        if float(total_students_value) >= 0 and total_students_value is not None:
            print("Total_Students Card Values is showing")
            self.logger.info("*********** Total_Students Card Values is showing ***************")
        else:
            print("Total_Students Card Value is not showing")
            self.logger.error("*************** Total_Students Card Values is Missing ************")
            assert False
        self.logger.info("*************** Tc_cQube_udise_008 Testing Ended. *****************")

    def test_validate_ptr_metrics(self):
        self.logger.info("*************** Tc_cQube_udise_008 Testing started *****************")
        ptr = self.udise.get_PTR_value()
        ptr_value = re.sub(self.udise.L, "", ptr)
        ptr_text = self.udise.get_PTR_text()
        if ptr_text is not None:
            print("infrastructure Card Value is showing")
            self.logger.info("*********** infrastructure Card Value is showing ***************")
        else:
            print("infrastructure Card Value is Missing")
            self.logger.error("*************** infrastructure Card Value is Missing ************")
            assert False
        if float(ptr_value) >= 0 and ptr_value is not None:
            print("infrastructure Card Values is showing")
            self.logger.info("*********** infrastructure Card Values is showing ***************")
        else:
            print("infrastructure Card Value is not showing")
            self.logger.error("*************** infrastructure Card Values is Missing ************")
            assert False
        self.logger.info("*************** Tc_cQube_udise_008 Testing Ended. *****************")

    def test_validate_schools_with_toilets_metrics(self):
        self.logger.info("*************** Tc_cQube_udise_008 Testing started *****************")
        schools_with_toilets = self.udise.get_schools_with_toilets_value()
        schools_with_toilets_value = re.sub(self.udise.L, "", schools_with_toilets)
        schools_with_toilets_text = self.udise.get_schools_with_toilets_text()
        if schools_with_toilets_text is not None:
            print("schools_with_toilets Card Value is showing")
            self.logger.info("*********** schools_with_toilets Card Value is showing ***************")
        else:
            print("schools_with_toilets Card Value is Missing")
            self.logger.error("*************** schools_with_toilets Card Value is Missing ************")
            assert False
        if float(schools_with_toilets_value) >= 0 and schools_with_toilets_value is not None:
            print("schools_with_toilets Card Values is showing")
            self.logger.info("*********** schools_with_toilets Card Values is showing ***************")
        else:
            print("schools_with_toilets Card Value is not showing")
            self.logger.error("*************** schools_with_toilets Card Values is Missing ************")
            assert False
        self.logger.info("*************** Tc_cQube_udise_008 Testing Ended. *****************")

    def test_validate_schools_having_electricity_metrics(self):
        self.logger.info("*************** Tc_cQube_udise_008 Testing started *****************")
        schools_having_electricity = self.udise.get_schools_having_electricity_value()
        schools_having_electricity_value = re.sub(self.udise.L, "", schools_having_electricity)
        schools_having_electricity_text = self.udise.get_schools_having_electricity_text()
        if schools_having_electricity_text is not None:
            print("schools_with_toilets Card Value is showing")
            self.logger.info("*********** schools_having_electricity Card Value is showing ***************")
        else:
            print("schools_having_electricity Card Value is Missing")
            self.logger.error("*************** schools_having_electricity Card Value is Missing ************")
            assert False
        if float(schools_having_electricity_value) >= 0 and schools_having_electricity_value is not None:
            print("schools_having_electricity Card Values is showing")
            self.logger.info("*********** schools_having_electricity Card Values is showing ***************")
        else:
            print("schools_having_electricity Card Value is not showing")
            self.logger.error("*************** schools_having_electricity Card Values is Missing ************")
            assert False
        self.logger.info("*************** Tc_cQube_udise_008 Testing Ended. *****************")

    def test_validate_schools_having_drinking_water_metrics(self):
        self.logger.info("*************** Tc_cQube_udise_008 Testing started *****************")
        schools_having_drinking_water = self.udise.get_schools_having_drinking_water_value()
        schools_having_drinking_water_value = re.sub(self.udise.L, "", schools_having_drinking_water)
        schools_having_drinking_water_text = self.udise.get_schools_having_drinking_water_text()
        if schools_having_drinking_water_text is not None:
            print("schools_having_drinking_water Card Value is showing")
            self.logger.info("*********** schools_having_drinking_water Card Value is showing ***************")
        else:
            print("schools_having_drinking_water Card Value is Missing")
            self.logger.error("*************** schools_having_drinking_water Card Value is Missing ************")
            assert False
        if float(schools_having_drinking_water_value) >= 0 and schools_having_drinking_water_value is not None:
            print("schools_having_drinking_water Card Values is showing")
            self.logger.info("*********** schools_having_drinking_water Card Values is showing ***************")
        else:
            print("schools_having_drinking_water Card Value is not showing")
            self.logger.error("*************** schools_having_drinking_water Card Values is Missing ************")
            assert False
        self.logger.info("*************** Tc_cQube_udise_008 Testing Ended. *****************")

    def test_legend(self):
        self.logger.info("*************** Tc_cQube_NCF_012 Testing started *****************")
        self.udise.click_dropdown()
        time.sleep(2)
        options = self.udise.get_metrics_dropdown_values()
        for dropdown in range(len(options)):
            opts = self.udise.get_each_dropdown_value_id(dropdown)
            opt_text = opts.text
            opts.click()
            time.sleep(3)
            legend = self.udise.get_legend_text()
            if opt_text in legend:
                print("Metric in  dropdown and legend is same")
                self.logger.info("*********** Metric in  dropdown and legend is same **************")
            else:
                self.logger.error("*********** Metric in  dropdown and legend is not same **************")
                assert False
            self.udise.click_dropdown()
            time.sleep(2)
        self.logger.info("*************** Tc_cQube_NCF_012 Testing started *****************")

    def test_check_map_on_page(self):
        self.logger.info("*************** Tc_cQube_NCF_007 Testing started *****************")
        map_info = self.udise.get_map_information()
        if len(map_info) > 0:
            print("Map is present on the udise page")
            self.logger.info("*********** Map is present on the udise page ***************")
        else:
            self.logger.error("*********** Map is not present on the udise page ***************")
            assert False
        self.logger.info("*************** Tc_cQube_NCF_007 Testing ended *****************")

    """ Check whether each dropdown is selecting and selected metric is displaying is tooltip"""

    # def test_selection_of_each_metric(self):
    #     self.logger.info("*************** Tc_cQube_NCF_011 Testing started *****************")
    #     self.udise.click_dropdown()
    #     time.sleep(2)
    #     options = self.udise.get_metrics_dropdown_values()
    #     for dropdown in range(len(options)):
    #         opts = self.udise.get_each_dropdown_value_id(dropdown)
    #         opt_text = opts.text
    #         print(opt_text, 'is selected')
    #         opts.click()
    #         time.sleep(2)
    #         result = self.udise.get_map_tooltip_info_validation()
    #         print(opt_text, result)
    #         # if opt_text in result[0]:
    #         #     self.logger.info("*************** Metrics dropdown wise showing Map Result "
    #         #                      "********************")
    #         #     print("Metrics dropdown wise showing Map Result")
    #         # else:
    #         #     self.logger.error("*********** Metrics dropdown wise not showing Map Result **************")
    #         #     # assert False
    #         self.udise.click_dropdown()
    #         time.sleep(2)
    #     self.logger.info("*************** Tc_cQube_NCF_011 Testing ended *****************")

    def test_download_csv(self):
        p = Teacherattendance(self)
        if ' No Data Found' in self.driver.page_source:
            self.teacherattendance.click_download_button()
            time.sleep(5)
            self.teacherattendance.click_download_button()
            time.sleep(3)
            self.teacherattendance.click_download_csv_button()
            alert = Alert(self.driver)
            a = alert.text
            print(a)
            message = "No data found to download"
            if a == message:
                alert.accept()
                assert True
            else:
                assert False
        else:
            self.teacherattendance.click_download_button()
            time.sleep(5)
            self.teacherattendance.click_download_button()
            time.sleep(3)
            self.teacherattendance.click_download_csv_button()
            time.sleep(3)
            self.file_name = p.get_download_dir() + "/District Wise Performance.csv"
            print(self.file_name)
            if os.path.isfile(self.file_name) is True:
                print("file is downloaded")
                os.remove(self.file_name)
            else:
                print("file is not downloaded")
                assert False

    def test_download_button_udise_pdf(self):
        self.logger.info("*************** Tc_cQube_udise_019 Testing started *****************")
        p = Teacherattendance(self)
        self.teacherattendance.click_download_button()
        time.sleep(5)
        self.teacherattendance.click_download_button()
        time.sleep(3)
        self.teacherattendance.click_download_pdf_button()
        time.sleep(4)
        self.file_name = p.get_download_dir() + "/udise_district-wise.pdf"
        print(self.file_name)
        if os.path.isfile(self.file_name) is True:
            print("file is downloaded")
            os.remove(self.file_name)
        else:
            print("file is not downloaded")
            assert False
        self.logger.info("*************** Tc_cQube_udise_019 Testing ended *****************")

    def test_full_screen_avg_teacher_tab(self):
        self.logger.info("*************** Tc_cQube_udise_010 Testing started *****************")
        self.teacherattendance.click_fullscreen_button()
        time.sleep(3)
        is_full_screen = self.driver.execute_script(
            "return window.screen.width == screen.width && window.screen.height == screen.height;")
        print(is_full_screen)
        assert is_full_screen
        self.logger.info("*************** Tc_cQube_udise_010 Testing ended *****************")

