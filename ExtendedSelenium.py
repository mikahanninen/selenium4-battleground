import os
from pathlib import Path

from RPA.Browser.Selenium import Selenium
from SeleniumLibrary.base import keyword
from selenium import webdriver
from webdrivermanager import ChromeDriverManager


class ExtendedSelenium(Selenium):

    USER_DATA = Path("output") / "Chrome"
    USER_DATA_PATH = os.getenv("USER_DATA", str(USER_DATA)).strip()

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.cdm = ChromeDriverManager(link_path="AUTO")
        self.cdm.download_and_install()

    @keyword
    def open_site(self, url, **kwargs):
        options = webdriver.ChromeOptions()
        options.binary_location = self.cdm.link_path
        if self.USER_DATA_PATH:
            options.add_argument(f"user-data-dir={self.USER_DATA_PATH}")
        self.open_browser(url=url, options=options, **kwargs)
