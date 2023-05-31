from selenium.webdriver.common.by import By
from Page_of_objects.CqubeUi.BasePage import Base


class Diksha(Base):
    """ List of selenium locator of summary statistics screen """

    diksha = (By.XPATH, "//*[@id='menu-item-6']")
    L = r'L\.|[^\d.]'
    K = r'K\.|[^\d.]'
    ETB_Coverage_Status = (By.XPATH, "//mat-tab-group/mat-tab-header/div/div/div/div[1]")
    content_coverage_on_qr = (By.XPATH, "//mat-tab-group/mat-tab-header/div/div/div/div[2]")
    learning_session = (By.XPATH, "//mat-tab-group/mat-tab-header/div/div/div/div[3]")
    total_ETBs_value = (By.XPATH, "//div[1]/div/app-big-number/div/div[1]/h1")
    total_ETBs_text = (By.XPATH, "//div[1]/div/app-big-number/div/div[2]")
    total_qr_codes_value = (By.XPATH, "//div[2]/div/app-big-number/div/div[1]/h1")
    total_qr_codes_text = (By.XPATH, "//div[2]/div/app-big-number/div/div[2]")
    content_coverage_on_QR_value = (By.XPATH, "//div[3]/div/app-big-number/div/div[1]/h1")
    content_coverage_on_QR_text = (By.XPATH, "//div[3]/div/app-big-number/div/div[2]")
    metrics_dropdown = (By.ID, "filter-Medium")
    diksha_metric_dropdown = (By.XPATH, "//div[@role='option']/span")
    metrics_dropdown_value = (By.XPATH, "//div[starts-with(@id,'a') and contains(@id,"'-'"{}" + ")]")
    legend_text = (By.XPATH, "//*[@id='map']/div[2]/div[2]/div/strong")

    def __init__(self, driver):
        super().__init__(driver)
        self.driver = driver

    def test_click_on_diksha_menu(self):
        self.click(self.diksha)

    def click_ETB_Coverage_Status(self):
        return self.get_attribute_value('aria-selected', self.ETB_Coverage_Status)

    def content_coverage_on_qr_tab(self):
        self.click(self.content_coverage_on_qr)

    def click_content_coverage_on_qr(self):
        return self.get_attribute_value('aria-selected', self.content_coverage_on_qr)

    def learning_session_tab(self):
        self.click(self.learning_session)

    def click_learning_session(self):
        return self.get_attribute_value('aria-selected', self.learning_session)

    def get_total_ETBs_value(self):
        return self.get_web_element_text(self.total_ETBs_value)

    def get_total_ETBs_text(self):
        return self.get_web_element_text(self.total_ETBs_text)

    def get_total_qr_codes_value(self):
        return self.get_web_element_text(self.total_qr_codes_value)

    def get_total_qr_codes_text(self):
        return self.get_web_element_text(self.total_qr_codes_text)

    def get_content_coverage_on_QR_value(self):
        return self.get_web_element_text(self.content_coverage_on_QR_value)

    def get_content_coverage_on_QR_text(self):
        return self.get_web_element_text(self.content_coverage_on_QR_text)

    def click_dropdown(self):
        self.click(self.metrics_dropdown)

    def get_metrics_dropdown_values(self):
        metric_dropdown_options = self.get_web_elements(self.diksha_metric_dropdown)
        return metric_dropdown_options

    """This functionality is to get id of each metric in dropdown"""

    def get_each_dropdown_value_id(self, metrics_dropdown_id):
        metrics_dropdown_value = self.metrics_dropdown_value
        metrics_dropdown_value = list(metrics_dropdown_value)
        metrics_dropdown_value[1] = metrics_dropdown_value[1].format(metrics_dropdown_id)
        metrics_dropdown_value = tuple(metrics_dropdown_value)
        res = self.get_web_element((By.XPATH, str(metrics_dropdown_value[1])))
        return res

    """ This functionality is to get legend text"""

    def get_legend_text(self):
        return self.get_web_element_text(self.legend_text)
