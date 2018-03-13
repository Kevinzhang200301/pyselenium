#!/usr/bin/env python
# -*- coding:UTF-8 -*-

from Selenium2Library import Selenium2Library
from SSHLibrary import SSHLibrary
from robot.libraries.BuiltIn import BuiltIn
from vTopCenterWebLibrary.locators import PublicLocators
from vTopCenterWebLibrary.testdata import PublicUIInfo
from vTopCenterWebLibrary.testdata import PublicData
from robot.api import logger


class PublicKeywords(PublicLocators,
                     PublicData,
                     PublicUIInfo,
                     Selenium2Library
                     ):

    def __init__(self):
        super(PublicKeywords, self).__init__(timeout=10)
        self.blt = BuiltIn()
        # self.s2l = self.get_library_instance("Selenium2Library")
        # self.ssh = self.blt.get_library_instance("SSHLibrary")
        self.ssh = SSHLibrary()

    def print_info(self, msg, html=True):
        """
        print info on log file and console.
        :param msg: print message
        :param html: "True" Print information in html format
        """
        msg = "<span class='label info'>" + msg + "</span>"
        logger.info(msg, html=html)

    def print_error(self, msg, html=True):
        """
        print error on log file and console.
        :param msg: print message
        :param html: "True" Print information in html format
        """
        msg = "<span class='label fail'>" + msg + "</span>"
        logger.error(msg, html=html)

    def open_center_web(self, ip, browser, protocol="https"):
        """
        Enter the vTop Center IP in the new browser and wait for the login button to be visible.
        """
        web_addr = "%s://%s/" % (protocol, ip)
        self.print_info("open vTop Center on the new browser")
        self.open_browser(web_addr, browser=browser)
        self.maximize_browser_window()
        self.print_info("Wait for the login button to be visible")
        err_msg = "The login button is not visible!(%s)" % self.LOGIN_BUTTON_ID
        self.wait_until_element_is_visible(self.LOGIN_BUTTON_ID, error=err_msg)

    def input_element_txt(self, locator, text):
        """
        Enter the text into the element input box.
        """
        self.print_info("wait for the input box to be visible")
        err_msg = "The input box not visible!(%s)" % locator
        self.wait_until_element_is_visible(locator, error=err_msg)
        self.print_info("clear input box and input %s" % text)
        self.clear_element_text(locator)
        self.input_text(locator, text)
        self.blt.sleep(self.INPUT_SLEEP)

    def click_center_element(self, locator, sleep_status=True):
        """
         Click the vTop Center UI element.

        :param locator: vTopCenter element locator.
        :param sleep_status: Whether to sleep after the click."False" not sleep.
        """
        self.print_info("wait for the click element to be visible")
        err_msg = "The click elemnt not visible!(%s)" % locator
        self.wait_until_element_is_visible(locator, error=err_msg)
        self.click_element(locator)
        if sleep_status:
            self.blt.sleep(self.CLICK_SLEEP)

    def verify_element_title_attribute(self, locator, title):
        """
        Verify the element title attribute value.
        """
        self.print_info("wait for the element '%s' to be visible" % locator)
        err_msg = "The element '%s' not visible!()" % locator
        self.wait_until_element_is_visible(locator, error=err_msg)
        self.print_info("Get the title attribute and verify it(%s)" % locator)
        ui_title = self.get_element_attribute("%s@title" % locator)
        title = title.decode("utf8")
        if ui_title != title:
            self.capture_page_screenshot()
            err_msg = "The verification title '%s' is not equal to the actual title '%s'" % (
                title, ui_title)
            raise ValueError(err_msg)
        else:
            self.print_info("The title attribute verify successful")

    def verify_element_text(self, locator, text):
        """
        Verify the value within the element tag.
        """
        self.print_info("verify the element '%s' text" % locator)
        err_msg = "The element '%s' not visible!" % locator
        self.wait_until_element_is_visible(locator, error=err_msg)
        ui_text = self.get_text(locator)
        ui_text.strip()
        text = text.decode("utf8")
        if ui_text != text:
            self.capture_page_screenshot()
            err_msg = "The verification text '%s' is not equal to the actual text '%s'" % (
                text, ui_text)
            raise ValueError(err_msg)
        else:
            self.print_info(
                "The element '%s' text verify successful" % locator)

    def verify_login_successful(self, user=None, real_name=None):
        """
        Verify that the user is logged in vTop Center is successful.

        The default user is admin,the real name is 管理员.
        """
        self.print_info("verify %s login successful" % user)
        err_msg = "login button must be not visible,but it's visible!"
        self.wait_until_element_is_not_visible(
            self.LOGIN_BUTTON_ID, error=err_msg)
        self.print_info("wait for the loading img not visible")
        err_msg = "loading img is visible"
        self.wait_until_element_is_not_visible(self.LOADING_DIV_ID, error=err_msg)
        self.wait_until_element_is_not_visible(self.LOADING_IMG_ID, error=err_msg)
        if not user:
            user = self.CENTER_ADMIN_NAME
        if user == self.CENTER_ADMIN_NAME:
            real_name = self.CENTER_ADMIN_REAL_NAME
        self.print_info("verify navbar info")
        if real_name:
            self.verify_element_title_attribute(
                self.NAVBAR_WELCOME_INFO_ID, real_name)
        text = self.NAVBAR_WELCOME_LABEL + "\n" + user
        self.verify_element_text(self.NAVBAR_WELCOME_INFO_ID, text)
        err_msg = "navbar must be visible,but it is not visible!"
        self.wait_until_element_is_visible(self.NAVBAR_UI_ID, error=err_msg)

    def login_center_web(self, user="admin", password="admin", ip=None, browser=None):
        """
        User login vTop Center.

        Default user is admin,and default ip is the test vtop center.
        """
        self.print_info("login management center web by %s" % user)
        if not ip:
            ip = self.CENTER_IP
        if not browser:
            browser = self.TEST_BROWSER
        self.open_center_web(ip, browser=browser)
        self.print_info("input user and password,then click login button")
        self.input_element_txt(self.LOGIN_USER_INPUT_ID, user)
        self.input_element_txt(self.LOGIN_PASSWORD_INPUT_ID, password)
        self.click_center_element(self.LOGIN_BUTTON_ID)
        self.print_info("Verify login successful")
        self.verify_login_successful()

    def refresh_center_page(self, times=3):
        """
        refresh vTop Center page,Equivalent to F5 refresh.

        :param times: When the loaded image is always visible,refresh times.

        :return: None
        """
        self.print_info("refresh management center web page(F5)")
        i = 0
        while i <= int(times):
            i += 1
            self.reload_page()
            self.print_info("wait loading images not visible")
            status_div = self.wait_until_element_is_not_visible(self.LOADING_DIV_ID, timeout=5)
            if status_div is not None:
                continue
            status_img = self.wait_until_element_is_not_visible(self.LOADING_IMG_ID, timeout=5)
            if status_img is not None:
                continue
            status_click = self.click_element(self.HOME_MANAGE_TAB_ID)
            if status_click is None:
                break

    def choose_upload_file(self, file_path):
        """
        Choose upload file on local
        :param file_path: the file path.
        """
        self.print_info("choose vTop Center ISO:%s" % file_path)
        self.choose_file(self.UPLOAD_FILE_CHOOSE_ID, file_path=file_path)

    def wait_until_upload_file_success(self, timeout=600):
        """
        Wait until upload file success.

        :param timeout: wait the file upload success timeout.
        """
        self.print_info("wait until file upload success")
        self.wait_until_element_is_visible(self.UPLOAD_FILE_UP100_ID, timeout=timeout)
        i = 0
        while i < 60:
            i += 1
            err_msg = "upload file Prompt information not visible"
            self.wait_until_element_is_visible(self.UPLOAD_FILE_STATUS_ID, error=err_msg)
            status = self.get_text(self.UPLOAD_FILE_STATUS_ID)
            status_success = self.UPLOAD_STATUS_SUCCESS.decode("utf8")
            if status == status_success:
                break
            self.blt.sleep(1)

    def click_upload_file_button(self):
        """
        click upload file button.
        """
        self.print_info("click upload button on firmware upgrade ui")
        self.click_center_element(self.UPLOAD_FILE_UPLOAD_BUTTON_ID)

    def click_button_to_open_layer(self, locator, layer_visible=True, button_name=None):
        """
        click button to open the layer UI.

        :param locator: The button locator.
        :param layer_visible: Whether the layer is visible."True" is visible,"False" is not visible.
        :param button_name: the button name.
        """
        if button_name is None:
            button_name = locator
        self.print_info("click the %s button on the management ui" % button_name)
        err_msg = "the button not visible!"
        self.wait_until_element_is_visible(locator, error=err_msg)
        self.click_center_element(locator)
        if layer_visible:
            self.unselect_frame()
            err_msg = "layer ui not visible"
            self.wait_until_element_is_visible(self.LAYER_FIRST_TITLE_ID, error=err_msg)
            self.select_frame(self.LAYER_IFRAME_ID)
            err_msg = "layer ui second title not visible"
            self.wait_until_element_is_visible(self.LAYER_SECOND_TITLE_ID, error=err_msg)

    def verify_lobibox_message(self, msg=None, msg_visible=True):
        """
        Verify the bottom right corner box information

        :param msg:  the bottom right corner box body information
        :param msg_visible: "False" is the bottom right corner box body not visible
        """
        self.print_info("Verify the bottom right corner box information")
        self.unselect_frame()
        err_msg = "lobibox not visible"
        self.wait_until_element_is_visible(self.LOBIBOX_DIV_ID, error=err_msg)
        if msg is None:
            msg = self.LOBIBOX_MSG_SUCCESS
            title = self.LOBIBOX_TITLE_SUCCESS
        else:
            title = self.LOBIBOX_TITLE_FRIENDLY
        self.verify_element_text(self.LOBIBOX_TITLE_ID, title)
        if msg_visible:
            self.verify_element_text(self.LOBIBOX_MSG_INFO_ID, msg)

    def click_layer_save_button(self, layer_visible=False):
        """
        Click layer UI save button.

        :param layer_visible: "False" layer ui is not visible. "True" layer ui is visible.
        """
        self.print_info("click layer save button")
        self.unselect_frame()
        self.click_center_element(self.LAYER_SAVE_BUTTON_ID, sleep_status=False)
        if layer_visible:
            self.select_frame(self.LAYER_IFRAME_ID)

    def open_center_ssh(self,timeout=None):
        """
        Open vtop center ssh
        :param timeout: ssh timeout
        """
        self.print_info("Use the %s user ssh, and then switch to root" % self.CENTER_SSH_USER)
        self.ssh.open_connection(self.CENTER_IP, port=self.CENTER_SSH_PORTE,
                                 timeout=timeout)
        i = 0
        while i < 10:
            i += 1
            self.blt.sleep(5)
            try:
                status_login = self.ssh.login(self.CENTER_SSH_USER, self.CENTER_SSH_PASSWOER)
            except Exception, e:
                if i == 9:
                    raise RuntimeError(e)
                continue
            status_info = "[%s@localhost ~]$" % self.CENTER_SSH_USER
            if status_info in status_login:
                break
        self.ssh.write("su")
        self.ssh.read_until("Password:")
        self.ssh.write(self.CENTER_ROOT_PASSWORD)
        self.ssh.read_until("[root@localhost %s]#" % self.CENTER_SSH_USER)

    def get_center_version(self):
        """
        execute the command to get the vtop center version.

        :return: vtop center version
        """
        self.print_info("execute the command to get the vtop center version")
        self.open_center_ssh()
        cmd = "cat /data/build_tag"
        version = self.ssh.execute_command(cmd)
        self.ssh.close_connection()
        return version

    def allow_remote_access_hsdb(self):
        self.print_info("allow user remote access to the database")
        self.print_info("open the database remote access port(3306)")
        cmd_port = "firewll-cmd --add-port=3306/tcp"
        output = self.ssh.execute_command(cmd_port)
        if output != "success" and output != "Warning: ALREADY_ENABLED":
            raise AssertionError("can't open the database remote access port,err:%s"%output)
        self.print_info("allow root access hsdb database")
        self.ssh.write("mysql")
        self.ssh.read_until_regexp(".*MariaDB.*")
        self.ssh.write("GRANT ALL PRIVILEGES ON *.* TO 'root'@'%%' IDENTIFIED BY '%s' WITH GRANT OPTION;"
                       % self.CENTER_ROOT_PASSWORD)
        self.ssh.read_until_regexp(".*Query OK, 0 rows affected*.")
        self.ssh.write("FLUSH PRIVILEGES;")
        self.ssh.read_until_regexp(".*Query OK, 0 rows affected*.")
