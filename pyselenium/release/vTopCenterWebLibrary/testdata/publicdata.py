#!/usr/bin/env python
# -*- coding:UTF-8 -*-


class PublicData(object):

    TEST_BROWSER = "chrome"  # 浏览器类型
    CENTER_IP = "172.18.10.28"  # vTopCenter的IP地址
    CENTER_SSH_PORTE = "10022"  # vTopCenter的SSH的端口号
    CENTER_SSH_USER = "rescue-user"  # vTopCenter的ssh用户
    CENTER_SSH_PASSWOER = "password@halsign"
    CENTER_ADMIN_NAME = "admin"  #vTopCenter管理用户名
    CENTER_ADMIN_PASSWORD = "admin"   #vTopCenter管理用户的密码
    CENTER_ROOT_PASSWORD = "password"  #vTopCenter的root密码
    CENTER_BUILD_SERVER_IP = "192.168.0.51" # vTopCenter镜像ISO build服务器IP地址
    CENTER_BUILD_SERVER_USER = "root" # vTopCenter镜像ISO build服务器ssh登录用户
    CENTER_BUILD_SERVER_PASSWORD = "123%Qwer" # vTopCenter镜像ISO build服务器登录密码
    #CENTER_BUILD_SERVER_LOGIN_SUCCESS = "[root@vcbuild ~]#" vTopCenter镜像ISO build服务器登录成功
    CENTER_BUILD_SERVER_ISO_PATH = "/home/beyond/vtop-center/build/iso" #vTopCenter build服务器镜像存储路径
    INPUT_SLEEP = 0.3   # 输入文字sleep时间
    CLICK_SLEEP = 0.3   # 点击元素sleep时间


class PublicUIInfo(object):

    CENTER_ADMIN_REAL_NAME = "管理员"  # vTopCenter管理员的真实姓名
    NAVBAR_WELCOME_LABEL = "欢迎,"    # 导航栏欢迎
    UPLOAD_STATUS_SUCCESS = "上传成功"  # 上传文件是显示“上传成功”
    LOBIBOX_MSG_SUCCESS = "操作成功"  # 操作成功时lobibox窗口中msg信息
    LOBIBOX_TITLE_SUCCESS = "操作成功"  # 操作成功时lobibox窗口中title信息
    LOBIBOX_TITLE_FRIENDLY = "友情提示"  # lobibox友情提示titile