#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import unicode_literals
from CustomLibrary import *


test_browser = "chrome"  # 测试使用的浏览器
vc_ip = "172.18.10.28"  # vTopCenter的IP地址
vc_web_user = "admin"  # vTopCenter中admin用户名
vc_web_pwd = "admin"  # vTopCenter中admin密码
vc_root_pwd = "password"  # vTopCenter中root密码
vc_ssh_user = "rescue-user"  # vTopCenter中ssh登录用户
vc_ssh_pwd = "password@halsign"  # vTopCenter中SSH登录密码
vc_ssh_port = 10022  # vTopCenter中SSH端口
open_mysql_port_cmd = "firewall-cmd --add-port=3306/tcp"  # vTopCenter中MySQL访问端口开启命令
vc_mysql_pwd = "password"  # vTopCenter中mysql登录密码

# 默认测试数据
systemRetainsUser = ['root', 'hssj', 'halsign', 'admin', 'administrator']
allSymbolTD = "`!@#$%^&*()—=+~·！￥……）（】【][}{\|、’“；：;:\'\",/<>?，《。》？中._-"
lettersTD = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM"
errorEmail = ['12@fadf', '@sdfasd', 'qwerwqer.com', '.comasdffasd', 'asdf@.com',
              '@asdfas.com', 'test@halsign。com']
numberTD = "1234567890"
searchNameList = ['searchForTest', 'searchForTest1', 'searchForTest2', 'searchForTest3']
searchNoName = [random_str(allSymbolTD, 16), 'SELECT id FROM ulms_user;',
                '<scrpt>alert("有问题")</scrpt>', 'document.write("你好 世界!");', 'NULL']
deleteNameTD = 'deleteForTest'
defaultNameTD = 'defualtForTest'
editNameTD = 'editForTest'
vhdNameP = 'PublicVhdName'
ipDefaultTD = '192.168.100.100'
ipErrorTD = ['1..11..', 'adsfa', '123dsif', '13.1233.1.1']
maskDefaultTD = '255.255.255.0'
maskErrorTD = ['~!@#$%^&*()_+', 'asdfckn8783', '1.1.1.', '255.255.255.255', '284.255.255.0']
gwDefualtTD = '192.168.100.1'

# 休息时间
inputSleep = 0.2
selectSleep = 0.3
clickSleep = 0.3
expiryTime = 180

# 共有的字段
searchButton = '搜索'
saveButton = '保存'
cancelButton = '取消'
clearButton = '清空'
confirmButton = '确定'
noMessage = '-'

# lobibox信息
lobiTitle1 = '操作成功'
lobiTitle2 = '友情提示'
lobiMsg1 = '操作成功'

# confirm弹窗信息
confirmTitle = '友情提示'
confirmBtn1 = '确定'
confirmBtn2 = '取消'
confirmBtn3 = 'OK'

# 上传文件
upFile = {
    'msg1': '上传成功',
    'msg2': '上传中 100%',
    'msg3': '处理中……',
}


# vTopCenter主界面信息
mainUI = {
    'title1': '关于vTop Center',
    'title2': '电源',
    'title3': '授权文件',
    'shortT': ['快速打开“用户”功能', '快速打开“vTop”功能', '快速打开“虚拟机”功能', '快速打开“镜像”功能'],
    'info': ['产品名称：vTop Center', '软件版本：', '版权所有：北京红山世纪科技有限公司','咨询电话：400-1020-696','官方网站：http://www.halsign.com/'],
    'msg1': 'Copyright© 2017 Halsign Corporation',
    'msg2': 'Copyright© 2017 Halsign Corporation',
    'msg3': '授权文件',
    'msg4': '关于我们',
    'menuText': ['我的主页', '用户管理', 'vTop管理', '策略管理', '资源管理', '权限管理', '日志管理', '安全管理', '系统管理'],
    'user': ['用户', '用户组'],
    'vtop': ['vTop', '虚拟机', '位置'],
    'policy': ['用户策略', '设备策略'],
    'resouce': ['模板', '镜像', '漫游数据', '网络', '设备', 'AD域', 'VLAN', '升级包'],
    'auth': ['管理员'],
    'log': ['vTop日志', '系统日志'],
    'safe': ['网络密钥', '加密网关', '审计管理'],
    'sys': ['参数设置', '分级管理', '集中部署', '固件升级', '存储管理', '网络管理'],
    'welcome': ['修改密码', '退出登录'],
    'power': ['重启', '关机'],
    'labelL1': ['请选择授权文件', '详细信息'],
    'labelL2': ['版本', 'UUID', '公司', '有效期', '最大vTop数量'],
    'labelL3': ['用户', 'vTop', '虚拟机'],
    'labelL4': ['请选择用户组：', '请选择位置：', '请选择位置：', '请选择vTop：'],
    'value1': '北京红山世纪科技有限公司'
}
welcomelable = '欢迎,\n'

# 测试用例标签
smokeTag = 'smokeCase'
loginTag = 'loginCase'
logoutTag = 'logoutCase'
turnTag = 'trunPageCase'


userTag = {
    'default': 'userManageCase',
    'create': 'createUserCase',
    'edit': 'editUserCase',
    'info': 'userInfoCase',
    'del': 'deleteUserCase',
    'search': 'searchUserCase',
    'seeVm': 'seeVmCase',
    'basic': 'userBasicCase',
    'seeTemp': 'seeTemplateCase',
    'assTemp': 'assignTemplateCase',
    'sort': 'userSortCase',
}
userGroupTag = {
    'default': 'userGroupManageCase',
    'create': 'createUserGroupCase',
    'edit': 'editUserGroupCase',
    'info': 'userGroupInfoCase',
    'del': 'deleteUserGroupCase',
    'sort': 'userGroupSortCase',
    'search': 'searchUserGroupCase'
}

adminTag = {
    'default': 'adminManageCase',
    'create': 'createAdminCase',
    'edit': 'editAdminCase',
    'rstPwd': 'resetPasswordCase',
    'setRange': 'setAdminRangeCase',
    'info': 'adminInfoCase',
    'del': 'deleteAdminCase',
    'sort': 'adminSortCase',
    'search': 'searchAdminCase'
}

localTag = {
    'default': 'locationManageCase',
    'create': 'createLocationManageCase',
    'edit': 'editLocationManageCase',
    'info': 'locationInfoCase',
    'del': 'deleteLocationCase',
    'sort': 'locationSortCase',
    'search': 'searchLocationCase',
    'setDefault': 'setDefaultLocationCase'
}
vTopTag = {
    'default': 'vtopManageCase',
    'sort': 'vtopSortCase',
    'info': 'vTopInfoCase'

}
vmTag = {
    'default': 'vmManageCase',
    'sort': 'vmSortCase',
    'info': 'vmInfoCase'
}
policyTag = {
    'Ddefault': 'devicePolicyCase',
    'Dcreate': 'devicePolicyCreateCase',
    'Dedit': 'devicePolicyEditCase',
    'Dinfo': 'devicePolicyInfoCase',
    'Dsort': 'devicePolicySortCase',
    'Ddel': 'devicePolicyDeleteCase',
    'Dsearch': 'devicePolicySearchCase',
    'Udefault': 'userPolicyCase',
    'Ucreate': 'userPolicyCreateCase',
    'Uedit': 'userPolicyEditCase',
    'Uinfo': 'userPolicyInfoCase',
    'Usort': 'userPolicySortCase',
    'Udel': 'userPolicyDeleteCase',
    'Usearch': 'userPolicySearchCase',
}

logTag = {
    'vtop': 'vTopLogCase',
    'sys': 'systemLogCase',
    'sort': 'logSortCase'
}

patchTag = {
    'default': 'vTopPatchManageCase',
    'create': 'createvTopPatchCase',
    'edit': 'editvTopPatchCase',
    'info': 'vTopPatchInfoCase',
    'del': 'deletevTopPatchCase',
    'sort': 'vTopPatchSortCase',
}

vlanTag = {
    'default': 'vTopVlanManageCase',
    'create': 'createvTopVlanCase',
    'edit': 'editvTopVlanCase',
    'info': 'vTopVlanInfoCase',
    'del': 'deletevTopVlanCase',
    'sort': 'vTopVlanSortCase',
    'search': 'searchvTopVlanCase'
}

adTag = {
    'default': 'ADManageCase',
    'create': 'createADCase',
    'edit': 'editADCase',
    'info': 'ADInfoCase',
    'del': 'deleteADCase',
    'sort': 'ADSortCase',
    'search': 'searchADCase'
}

deviceTag = {
    'default': 'deviceManageCase',
    'create': 'createdeviceCase',
    'edit': 'editdeviceCase',
    'info': 'deviceInfoCase',
    'del': 'deletedeviceCase',
    'sort': 'deviceSortCase',
    'search': 'searchdeviceCase'
}

wanderTag = {
    'default': 'wanderDataCase',
    'sort': 'wanderDataSortCase'
}

networkTag = {
    'default': 'networkManageCase',
    'create': 'createNetworkCase',
    'edit': 'editNetworkCase',
    'info': 'networkInfoCase',
    'del': 'deleteNetworkCase',
    'sort': 'networkSortCase',
    'search': 'searchNetworkCase'
}

vhdTag = {
    'default': 'VHDManageCase',
    'create': 'createVHDCase',
    'edit': 'editVHDCase',
    'info': 'VHDInfoCase',
    'del': 'deleteVHDCase',
    'sort': 'VHDSortCase',
    'search': 'searchVHDCase',
    'merge': 'mergeVHDCase',
    'desktop': 'setDesktopCase',
    'clear': 'clearVHDCase',
    'getvc': 'GetSyncListCase',
    'rollback': 'rollbackVHDCase',
    'megre': 'megreVhdCase'
}

templateTag = {
    'default': 'templateManageCase',
    'create': 'createTemplateCase',
    'edit': 'editTemplateCase',
    'info': 'templateInfoCase',
    'del': 'deleteTemplateCase',
    'sort': 'templateSortCase',
    'search': 'searchTemplateCase',
    'assign': 'templateAssignUsersCase',
    'use': 'templateUseSituationCase'
}

auditTag = {
    'default': 'auditManageCase',
    'info': 'auditInfoCase',
    'sort': 'auditSortCase'
}

networkKeyTag = {
    'default': 'networkKeyManageCase',
    'create': 'createNetworkKeyCase',
    'edit': 'editNetworkKeyCase',
    'info': 'networkKeyInfoCase',
    'del': 'deleteNetworkKeyCase',
    'sort': 'networkKeySortCase',
    'search': 'searchNetworkKeyCase'
}

encryptGWTag = {
    'default': 'EncryptGateWayManageCase',
    'info': 'EncryptGateWayInfoCase',
    'sort': 'encryptGateWaySortCase'
}

parameterTag = {
    'default': 'parameterManageCase',
    'info': 'praameterInfoCase'
}

rankTag = {
    'default': 'RankManageCase',
    'create': 'createRankCase',
    'edit': 'editRankCase',
    'info': 'RankInfoCase',
    'del': 'deleteRankCase',
    'sort': 'RankSortCase',
    'search': 'searchRankCase'
}

pxeTag = {
    'default': 'PxeManageCase',
    'create': 'createPxeCase',
    'edit': 'editPxeCase',
    'info': 'PxeInfoCase',
    'del': 'deletePxeCase',
    'sort': 'PxeSortCase',
    'search': 'searchPxeCase',
    'dhcp': 'DHCPCase',
    'mount': 'mountIsoCase'
}

vcupTag = {
    'default': 'VcUpManageCase',
    'create': 'createVcUpCase',
    'edit': 'editVcUpCase',
    'info': 'VcUpInfoCase',
    'del': 'deleteVcUpCase',
    'sort': 'VcUpSortCase',
    'search': 'searchVcUpCase',
    'shutdown': 'VcShutdownCase',
    'restart': 'VcRestartCase'
}

storageTag = {
    'default': 'storageManageCase'
}

ifcfgTag = {
    'default': 'IfconfigManageCase',
    'create': 'createIfconfigCase',
    'edit': 'editIfconfigCase',
    'info': 'IfconfigInfoCase',
    'del': 'deleteIfconfigCase',
    'sort': 'IfconfigSortCase',
    'open': 'IfconfigOpenOnbootCase',
    'stop': 'IfconfigStopOnbootCase'
}
# 排序测试数据
sortTD = {
    'name1': ['a', 'b', 'c', 'd', 'e'],
    'name2': ['f', 'g', 'h', 'i', 'j'],
    'date1': ['2030-01-31', '2035-06-15', '2040-04-05', '2046-06-15', '2050-09-21'],
    'randomNum': '12345'
}
