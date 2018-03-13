#!/usr/bin/env python
# -*- coding:UTF-8 -*-

from publickeywords import PublicKeywords
from vTopCenterWebLibrary.locators import SystemLocators
from vTopCenterWebLibrary.testdata import FirmwareUpgradeUIInfo
import os


class FirmwareUpgrade(PublicKeywords,
                      SystemLocators,
                      FirmwareUpgradeUIInfo):

    def __init__(self):
        super(FirmwareUpgrade, self).__init__()

    def into_firmware_upgrade_ui(self):
        """
        first refresh the page,then into firmware upgrade management UI.
        """
        self.print_info("Go to the firmware upgrade management interface")
        self.refresh_center_page()
        self.click_center_element(self.SYSTEM_MANAGE_MENU_ID)
        err_msg = "firmware upgrade menu not visible!"
        self.wait_until_element_is_visible(self.VCUP_MENU_ID, error=err_msg)
        self.click_center_element(self.VCUP_MENU_ID)
        err_msg = "firmware upgrade management ui not visible!"
        self.wait_until_element_is_visible(self.VCUP_MANAGE_UI_ID,error=err_msg)
        self.select_frame(self.VCUP_MANAGE_IFRAME_ID)
        err_msg = "firmware upgrade management ui upgrade button not visible!"
        self.wait_until_element_is_visible(self.VCUP_UPGRADE_BUTTON_ID, error=err_msg)

    def open_center_build_server_ssh(self):
        """
        open the vtop center iso build server ssh
        """
        self.print_info("open the vtop center iso build server ssh")
        self.ssh.open_connection(self.CENTER_BUILD_SERVER_IP)
        self.ssh.login(username=self.CENTER_BUILD_SERVER_USER, password=self.CENTER_BUILD_SERVER_PASSWORD)

    def get_center_version_from_build_server(self, product_name="vTopCenter"):
        """
        Get vtop center version from build server

        :param product_name: product name. the default value is "vTopCenter"
        :return: product version
        """
        self.print_info("Get %s version from build server" % product_name)
        self.open_center_build_server_ssh()
        iso_name = self.get_center_latest_iso_name(product_name=product_name)
        version = iso_name.split("-")[1]
        version = version[:5] + "-" + version[6:]
        self.ssh.close_connection()
        return version

    def get_center_latest_iso_name(self, product_name="vTopCenter"):
        """
        Get the vtop center latest iso name on build server.

        :param product_name: product name. the default value is "vTopCenter"
        """
        self.print_info("get the %s latest ISO name on build server" % product_name)
        cmd_file = "ls -lt" + " " + self.CENTER_BUILD_SERVER_ISO_PATH
        cmd_file += " | awk 'NR>1 {print $9}'"
        cmd_file += " | awk -F - '{if($1==\"%s\") print $0}'" % product_name
        cmd_file += " | awk 'NR==1 {print$0}'"
        iso_name = self.ssh.execute_command(cmd_file)
        if not iso_name:
            raise ValueError("%s product not exist no the build server" % product_name)
        return iso_name

    def copy_center_iso_from_build_server(self, product_name="vTopCenter"):
        """
        Copy vTopCenter ISO from build server

        :param product_name: product name. the default value is "vTopCenter"
        :return: The vTopCenter ISO local path
        """
        msg = "Copy the latest iso of the %s" % product_name
        msg += " from the build server"
        msg += " to the local desktop"
        self.print_info(msg)
        self.open_center_build_server_ssh()
        iso_name = self.get_center_latest_iso_name(product_name=product_name)
        iso_server_path = self.CENTER_BUILD_SERVER_ISO_PATH + "/" + iso_name
        iso_local_path = os.path.join(os.path.expanduser("~"), 'Desktop', iso_name)
        self.print_info("wait the %s latest ISO is copied to the local" % product_name)
        self.ssh.get_file(iso_server_path, iso_local_path)
        self.ssh.close_connection()
        return iso_local_path

    def click_upload_upgrade_patch_button(self):
        """
        Click upload upgrade patch button on the firmware upgrade management ui.
        """
        self.print_info("Click the Upload Upgrade Pack button in the Firmware Upgrade Management interface")
        button_name = "upload upgrade patch"
        self.click_button_to_open_layer(self.VCUP_UP_PATCH_BUTTON_ID, button_name=button_name)

    def click_upgrade_center_button(self, layer_visible=True):
        """
        Click upgrade on the firmware upgrade management ui.
        """
        self.print_info("Click the Upgrade button in the Firmware Upgrade Management interface")
        button_name = "upgrade center"
        self.click_button_to_open_layer(self.VCUP_UPGRADE_BUTTON_ID,
                                        layer_visible=layer_visible, button_name=button_name)

    def upload_correct_center_iso(self, iso_path, timeout=600):
        """
        upload correct vtop center iso to vtop center ui.

        :param iso_path: the vtop center iso path.
        :param timeout: Upload completion timeout time
        """
        self.print_info("the ISO is %s,and upload to vtop center" % iso_path)
        self.click_upload_upgrade_patch_button()
        self.choose_upload_file(iso_path)
        self.click_upload_file_button()
        self.wait_until_upload_file_success(timeout)
        self.click_layer_save_button()
        self.verify_lobibox_message()

    def upgrade_center(self, restart_timeout=300, product_name="vTopCenter"):
        """
        upgrade vtop center.

        :param restart_timeout: vtop center restart timeout time
        :param product_name: product name
        :return: the vtop center version
        """
        self.print_info("upgrade vTopCenter")
        build_version = self.get_center_version_from_build_server(product_name=product_name)
        center_version = self.get_center_version()
        build_version = self.blt.convert_to_string(build_version)
        center_version = self.blt.convert_to_string(center_version)
        if center_version >= build_version:
            self.print_info("the build server %s version:%s" % (product_name,build_version))
            self.print_info("installed %s version:%s" %(product_name,center_version))
            self.print_info("the %s is latest,no need to upgrade" % product_name)
            return
        else:
            self.print_info("%s > %s" % (center_version, build_version))
        self.print_info("click upgrade button to upgrade vtop center and wait upgrade complete")
        self.click_upgrade_center_button()
        self.click_layer_save_button(layer_visible=True)
        self.print_info("verify upgrade prompt information")
        self.verify_element_text(self.VCUP_UPGRADE_INFO1_ID, self.VCUP_UPGRADE_INFO1)
        self.verify_element_text(self.VCUP_UPGRADE_INFO2_ID, self.VCUP_UPGRADE_INFO2)
        self.print_info("wait until upgrade layer not visible")
        self.unselect_frame()
        self.wait_until_element_is_not_visible(self.LAYER_FIRST_TITLE_ID, timeout=360)
        self.print_info("wait vtop center restart complete")
        self.blt.sleep(30)
        restart_timeout -= 30
        self.open_center_ssh(restart_timeout)
        self.print_info("verify apache-tomcat process start")
        cmd = "ps -aux | grep tomcat"
        output = self.ssh.execute_command(cmd)
        if "/usr/local/apache-tomcat" not in output:
            self.print_error("after upgrade vtop center,the apache-tomcat not start")
            raise AssertionError(output)
        self.ssh.close_connection()
        self.login_center_web()
        return build_version
