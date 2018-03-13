#!/usr/bin/env python
# -*- coding:UTF-8 -*-


class PublicLocators(object):

    # 登录界面
    LOGIN_BUTTON_ID = "//*[@id='butt']"    # 登录按钮
    LOGIN_USER_INPUT_ID = "//*[@id='j_username']"  # 登录用户名输入框
    LOGIN_PASSWORD_INPUT_ID = "//*[@id='j_password']"  # 登录密码输入框
    LOGIN_ERROR_MESSAGE_ID = "//*[@id='errormessage']"  # 登录失败提示信息
    LOGIN_BOX_TITLE_ID = "//*[@id='login-box']//h4"    # 登录框Title
    LOGIN_VTOP_IMG_ID = "//h1/img"  # vtop图片
    LOGIN_COMPANY_LINK_ID = "//*[@id='id-company-text']"   # @红山世纪链接

    # 加载图片
    LOADING_DIV_ID = "//div[contains(@class,'layui-layer-shade')]"  # 加载中界面
    LOADING_IMG_ID = "//*[@id='layui-layer1']/div"  # 加载中图片

    # 导航栏
    NAVBAR_UI_ID = "//div[@id='navbar']"   # 导航栏界面
    NAVBAR_WELCOME_BUTTON_ID = "//li[contains(@class,'light-orange')]"  # “欢迎,XXX”按钮
    NAVBAR_WELCOME_INFO_ID = "//span[@class='user-info']"  # “欢迎,XXX”按钮信息
    NAVBAR_WELCOME_SUBLIST_ID = NAVBAR_WELCOME_BUTTON_ID + "/ul//a"   # “欢迎,XXX”菜单下子功能

    # 我的主页
    HOME_MANAGE_TAB_ID = "//*[@id='tab_tab_home_0001']"    # 我的主页tab

    # 新建或者编辑界面
    LAYER_IFRAME_ID = "//iframe[contains(@id,'layui-layer-iframe')]"  # lay界面iframe
    LAYER_SAVE_BUTTON_ID = "//a[@class='layui-layer-btn0']"  # lay界面保存按钮
    LAYER_CANCEL_BUTTON_ID = "//a[@class='layui-layer-btn1']"  # lay界面取消按钮
    LAYER_X_BUTTON_ID = "//a[contains(@class,'layui-layer-close')]"  # lay界面上“x”按钮
    LAYER_FIRST_TITLE_ID = "//div[@class='layui-layer-title']"  # lay界面title
    LAYER_SECOND_TITLE_ID = "//h1"  # lay界面第二个title
    LAYER_LABEL_ID = "//label"  # lay界面label
    LAYER_GROUP_SELECT_BOX_ID = "id=citySel"  # layer界面上用户组选择框
    
    # 上传文件界面
    UPLOAD_FILE_STATUS_ID = "id=other_error"  # 上传文件界面上传文件错误提示信息
    UPLOAD_FILE_CHOOSE_ID = "id=fileupload"  # 上传文件界面文件选择
    UPLOAD_FILE_UPLOAD_BUTTON_ID = "id=upload"  # 上传文件界面选择文件后上传按钮
    UPLOAD_FILE_UP_FILENAME_ID = "id=upshow"  # 上传文件界面上传文件名显示
    UPLOAD_FILE_UP_PROGRESS_ID = "//div[@id='progress']/div"  # 上传文件界面上传文件进度条
    UPLOAD_FILE_UP100_ID = "//div[@class='progress-bar progress-bar-success' and @style='width:100%;']/.."  # 上传文件界面上传到100%

    # lobiBox界面
    LOBIBOX_TITLE_ID = "//div[@class='lobibox-notify-title']"  # 操作后右下角弹窗title
    LOBIBOX_MSG_INFO_ID = "//div[@class='lobibox-notify-msg']"  # 操作后右下角弹窗信息
    LOBIBOX_DIV_ID = "//div[@class='lobibox-notify-body']"  # lobibox的body