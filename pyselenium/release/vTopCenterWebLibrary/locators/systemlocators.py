#!/usr/bin/env python
# -*- coding:UTF-8 -*-


class SystemLocators(object):

    SYSTEM_MANAGE_MENU_ID = "//i[contains(@class,'fa-gears')]/.."  # 左侧树中系统管理

    # 固件升级
    VCUP_MENU_ID = "//li[contains(@onclick,'936425')]"  # 左侧树中固件升级栏
    VCUP_TAB_ID = "//a[@href='#tab_936425']"  # 固件升级标签页
    VCUP_MANAGE_UI_ID = "id=tab_936425"  # 固件升级界面
    VCUP_MANAGE_IFRAME_ID = "id=acetab_ifr_tab_936425"  # 固件升级界面iframe
    VCUP_UP_PATCH_BUTTON_ID = "//input[contains(@onclick,'addVC')]"  # 固件升级管理界面上传升级包按钮
    VCUP_UPGRADE_BUTTON_ID = "//input[contains(@onclick,'toVcupdate')]"  # 固件升级管理界面升级按钮
    VCUP_RESTART_BUTTON_ID = "//input[contains(@onclick,'restartVC')]"  # 固件升级管理界面重启按钮
    VCUP_SHUTDOWN_BUTTON_ID = "//input[contains(@onclick,'shutdownVC')]"  # 固件升级管理界面关机按钮
    VCUP_SET_DATE_BUTTON_ID = "//input[contains(@onclick,'setVCDate')]"  # 固件升级管理界面设置时间按钮
    VCUP_SEARCH_INPUT_ID = "name=pageInfo.f_name"  # 固件升级管理界面搜索输入框
    VCUP_PATCH_NAME_INPUT_ID = "id=name"  # 固件升级管理上传升级包界面升级包名称输入框
    VCUP_PATCH_NAME_ERROR_ID = "id=name_error"  # 固件升级管理添加安装包界面名称错误提示信息
    VCUP_PATCH_NAME_ID ="//font"  # 升级界面固件名称
    VCUP_SET_DATE_TITLE_ID = "//h5"  # 设置时间界面title
    VCUP_SET_DATE_CONFIRM_BUTTON_ID = "//input[contains(@onclick,'modify_date')]"  # 设置时间界面确定按钮
    VCUP_SET_DATE_CANCEL_BUTTON_ID = "//input[contains(@onclick, 'closeDialog')]"  # 设置时间界面取消按钮
    VCUP_UPGRADE_INFO1_ID = "//td[@valign='bottom']/span"  # 升级界面升级时第一个提示信息
    VCUP_UPGRADE_INFO2_ID = "//td[@valign='top']/span"  # 升级界面升级时第二个提示信息