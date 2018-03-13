#!/usr/bin/env python
# -*- coding: utf-8 -*-


from __future__ import unicode_literals
from PublicData import *
from CustomLibrary import *

sysBox = {
    'msg1': '删除成功！',
    'msg2': '参数值格式错误。示例：http://192.168.0.100/',
    'msg3': '参数值不能为空！',
    'msg4': '参数值格式错误。示例：192.168.0.100',
    'msg5': '参数值只能包含英文字符,数字,点,下划线,中横线',
    'msg6': '参数值格式错误：请输入一个0~100之间的整数。',
    'msg7': '参数值格式错误：请输入一个正整数。',
    'msg8': '启动DHCP服务(systemctl start dhcpd)执行失败,请检查DHCP配置是否在同一网段内',
    'msg9': '关闭DHCP服务(systemctl stop dhcpd)执行失败',
    'msg10': '重启DHCP服务(systemctl restart dhcpd)执行失败',
    'msg11': '挂载vTop安装包（parser_vtop_iso）执行出错！',
    'msg12': '挂载vTop安装包进行中……！',
    'msg13': 'DHCP服务启动成功',
    'msg14': 'DHCP服务关闭成功',
    'msg15': 'DHCP服务重启成功',
    'msg16': '网卡名称不能为空！',
    'msg17': '网卡名称只能输入英文字符和数字！',
    'msg18': 'VLAN号不能为空！',
    'msg19': 'VLAN号只能在1-4094之间！',
    'msg20': 'VLAN号只能是正整数！',
    'msg21': 'IP地址不能为空！',
    'msg22': 'IP地址格式错误，请检查！示例：192.168.100.100！',
    'msg23': '网关不能为空！',
    'msg24': '网关格式错误，请检查！示例：192.168.100.100！',
    'msg25': '添加网卡成功！启用网卡失败，请检查网卡配置。',
    'msg26': '添加或修改网卡成功！',
    'msg27': '删除网卡成功!',
    'msg28': '启用网卡成功!',
    'msg29': '禁用网卡成功!',
    'msg30': '网卡名称重复！',
    'msg31': '挂载vTop安装包成功！'
}

# 参数设置界面信息
parameterUI = {
    'title1': '参数设置',
    'title2': '编辑参数',
    'title3': '上级系统设置的分级管理的地址，用于不同系统之间的镜像同步',
    'nameL': ['存储池位置', '上级vTop Center地址', '分级管理地址', '分级管理密钥', '域名服务器IP', '注册密码', '存储池使用百分比告警阈值（%）', '存储池剩余大小告警阈值（G）', '主机硬盘使用百分比告警阈值（%）', '主机硬盘剩余大小告警阈值（G）'],
    'valueL': ['/storage/pool', '-', '-', '-', '61.139.2.69', 'password', '95', '10', '90', '10'],
    'tableH': ['参数名称', '参数值', '操作'],
    'labelL': ['名称', '* 参数值'],
    'err1': '参数值不能为空！',
}

# 参数设置测试数据
parameterRight = '._-'
parameterTD = {
    'fenR': allSymbolTD,
    'ipR': ['http://192.168.0.100/', 'https://192.168.0.100/'],
    'ipE': ['%^(&^$', '1234', 'http://'],
    'dnsR': random_ip(),
    'dnsE': ['5.4.4', '$@%!FW', '123dsafjla'],
    'keyR': allSymbolTD,
    'pwdR': [numberTD, lettersTD, parameterRight],
    'pwdE': list(getString(allSymbolTD, parameterRight)),
    'percentR': str(random.randint(1, 99)),
    'percentE': ['#$^&@FSF234', '-113', '0.41', '101', '0', '100'],
    'sizeR': '1003934',
    'sizeE': ['#$^&@FSF234', '-113', '0.41', '0']
}

# 分级管理界面信息
rankUI = {
    'title1': '分级管理',
    'title2': '新建一个下级vTop Center',
    'title3': '编辑下级vTop Center信息',
    'title4': '删除下级vTop Center',
    'title5': '新建vTop Center',
    'title6': '新建下级vTop Center',
    'title7': '编辑vTop Center',
    'title8': '编辑下级vTop Center',
    'button1': '新建',
    'tableH1': ['名称', 'vTop Center地址', '镜像信息', '联系人', '联系电话', '操作'],
    'tableH2': ['镜像名称', 'uuid', '创建人'],
    'srcLabel': ['名称', 'IP'],
    'labelL': ['* 名称', '*下级管理中心', '* 密钥', '联系人', '联系电话', '请选择镜像'],
    'len1': '64',
    'len2': '1024',
    'msg1': '您确定要删除所有选中的信息吗？',
    'err1': '名称不能为空！',
    'err2': 'ip地址不能为空！',
    'err3': '密钥不能为空！',
    'err4': '镜像不能为空！'
}

# 分级管理测试数据
rankTD = {
    'nameD': defaultNameTD,
    'nameR': [allSymbolTD, numberTD, lettersTD],
    'srcName': searchNameList,
    'srcIp': ['https://169.10.10.5/', 'https://169.10.10.6/', 'https://169.10.10.7/', 'https://169.10.10.8/'],
    'srcNoIp': searchNoName,
    'srcNoName': searchNoName,
    'editD': 'editNameForTest',
    'del': 'deleteNameForTest',
    'addrD': 'https://192.168.100.100/',
    'addrR': ['http://169.10.10.5/', 'https://169.10.10.6/', 'http://169.10.10.7/', allSymbolTD, numberTD, lettersTD],
    'keyD': 'defaultKeyForTest',
    'keyR': [allSymbolTD, numberTD, lettersTD],
    'person': [allSymbolTD, numberTD, lettersTD],
    'mobile': [allSymbolTD, numberTD, lettersTD],
    'vhdNameD': vhdNameP,
    'vhdNameR': ['vhdRank', 'vhdRank1', 'vhdRank2']
}

# 集中部署界面信息
pxeUI = {
    'title1': '集中部署',
    'title2': '添加一个vTop安装包',
    'title3': '配置DHCP服务',
    'title4': '启动DHCP服务',
    'title5': '关闭DHCP服务',
    'title6': '重启DHCP服务',
    'title7': '添加安装包',
    'title8': '配置DHCP服务',
    'title9': '查看或编辑vTop安装包',
    'title10': '删除vTop安装包',
    'title11': '下载vTop安装包',
    'title12': '选择vTop升级包的安装方式并挂载安装包',
    'title13': '安装包',
    'title14': '编辑安装包',
    'title15': '设置vTop安装方式',
    'title16': '挂载vTop安装包',
    'button1': '添加安装包',
    'button2': '配置DHCP',
    'button3': '启动',
    'button4': '关闭',
    'button5': '重启',
    'button6': '上传',
    'button7': '挂载',
    'button8': '取消',
    'srcLabel': '名称',
    'statusLabel': '服务状态：',
    'status1': '未知(请检查DHCP配置是否正确)',
    'status2': '已关闭',
    'status3': '已启动',
    'tableH': ['文件名', '状态', '操作'],
    'labelL1': ['*开始地址', '*结束地址', '*子网地址', '*子网掩码', '*网关', '*域名服务器', '*TFTP服务器'],
    'labelL2': ['请选择安装包', '* 安装包名称'],
    'labelL3': 'vTop密码:',
    'modeL': ['全新安装', '升级安装'],
    'msg1': '如果当前网络已经存在DHCP服务，请点击取消按钮。',
    'msg2': '您确定要关闭DHCP服务吗？',
    'msg3': '您确定要重启DHCP服务吗？',
    'msg4': '您确定删除该vTop安装包吗？',
    'msg5': '上传中 100%',
    'msg6': '挂载成功',
    'msg7': '挂载失败',
    'err1': 'vTop安装包名称不能为空！',
    'err2': '上传成功',
    'err3': '请先上传vTop安装包',
    'err4': 'iso错误。请检查文件：',
    'err5': '开始地址不能为空！',
    'err6': 'IP地址格式错误，请检查！示例：192.168.100.100！',
    'err7': '结束地址不能为空！',
    'err8': '子网地址不能为空！',
    'err9': '子网掩码格不能为空！',
    'err10': '子网掩码格式错误，请检查！示例：255.255.255.0！',
    'err11': '网关不能为空！',
    'err12': '域名服务器不能为空！',
    'err13': 'TFTP服务器不能为空！',
    'err14': '请为vTop设置一个通用的密码！',
    'err15': 'vTop的密码必须大于六位！',
    'err16': '处理中……',
    'err17': '只能包含英文字符,数字,点,下划线,中横线',
    'err18': '安装包名称重复！',
    'len1': '64',
    'vTopPwdD': 'password'
}

# 集中部署测试数据
pxePwdRight = '.-_'
pxeTD = {
    'nameD': 'defaultNameForTest',
    'nameR': allSymbolTD,
    'editD': 'editNameForTest',
    'editR': allSymbolTD,
    'del': 'deleteNameForTest',
    'startIpR': GetDhcpIp(6, vc_ip),
    'startIpN': '169.18.12.1',
    'ipE': ipErrorTD,
    'endIpR': GetDhcpIp(20, vc_ip),
    'subnetR': GetDhcpIp(0, vc_ip),
    'gwR': GetDhcpIp(1, vc_ip),
    'dnsR': '61.139.2.69',
    'maskR': getRandomNetmask(),
    'maskD': '255.255.255.0',
    'tftpR': vc_ip,
    'fileR': TestImportFile('iso'),
    'fileE': TestImportFile('iso', False),
    'srcName': searchNameList,
    'srcNoName': searchNoName,
    'vtopPwdE': random_str(allSymbolTD, random.randint(1, 5)),
    'vtopPwdE2': list(getString(allSymbolTD, pxePwdRight)),
    'vtopPwdR': [numberTD, lettersTD, pxePwdRight * 3],
    'vtopISO': os.path.join(os.path.expanduser("~"), "Desktop",
                            "vTop-6.0.0.5067-20170623.iso"),
    'vtopIsoName': 'vTopIsoNameForTest',
    'newInstall': 'fresh',
    'upInstall': 'upgrade'

}

# 固件升级界面信息
vcupUI = {
    'title1': '固件升级',
    'title2': '上传升级包',
    'title3': '重启管理服务器',
    'title4': '关闭管理服务器',
    'title5': '设置管理服务器时间',
    'title6': '查看或编辑vTop Center升级包',
    'title7': '删除vTop Center升级包',
    'title8': '下载vTop Center升级包',
    'title9': '上传升级包',
    'title10': '设置服务器时间',
    'title11': '编辑升级包',
    'button1': '上传升级包',
    'button2': '升级',
    'button3': '重启',
    'button4': '关机',
    'button5': '设置时间',
    'button6': '确定',
    'button7': '取消',
    'srcLabel': '名称',
    'tableH': ['名称', '操作'],
    'labelL1': ['请选择升级包', '* 升级包名称'],
    'labelL2': '固件名称:',
    'msg1': '上传中 100%',
    'msg2': '您确定删除该升级包吗？',
    'msg3': '您确定要重启管理服务器吗？',
    'msg4': '您确定要关闭管理服务器吗？',
    'err1': '处理中……',
    'err2': '上传成功',
    'err3': '请先上传升级包',
    'err4': '升级包名称不能为空！',
    'err5': 'iso错误。请检查文件：',
    'len1': '64',

}

# 固件升级测试数据
vcupTD = {
    'nameD': 'defaultNameForTest',
    'nameR': [allSymbolTD, numberTD, lettersTD],
    'editD': 'editNameForTest',
    'editR': allSymbolTD,
    'del': 'deleteNameForTest',
    'fileR': TestImportFile('iso'),
    'fileE': TestImportFile('iso', False),
    'srcName': searchNameList,
    'srcNoName': searchNoName,
    'vtopISO': os.path.join(os.path.expanduser("~"), "Desktop",
                            "vTop-6.0.0.5067-20170623.iso"),
    'vtopIsoName': 'vTopIsoNameForTest',
}

# 存储管理界面信息
storageUI = {
    'title1': '存储管理',
    'titleL': ['存储管理', '空闲磁盘', '存储池'],
    'tableH1': ['设备', '容量', '已使用', '可用'],
    'tableH2': ['存储池', '容量', '可用', '操作'],
    'noDisk': '没有空闲磁盘！',
    'alarmL': ['存储池告警：', '可用大小：', '告警阈值：', '使用率：', '告警阈值：']

}

# 网络管理界面信息
ifcfgUI = {
    'title1': '网络管理',
    'title2': '网络管理（VLAN）',
    'title3': '新增一个网卡',
    'title4': '编辑网卡',
    'title5': '删除网卡',
    'title6': '启用网卡',
    'title7': '禁用网卡',
    'title8': '添加网卡',
    'button1': '添加网卡',
    'tableH': ['名称', 'VLAN号', '物理网卡', 'ONBOOT', '当前状态', 'IP地址', '子网掩码', '操作'],
    'labelL': ['* VLAN号', '物理网卡', 'ONBOOT', '* IP地址', '子网掩码', '* 网关'],
    'onbootL': ['是', '否'],
    'netmaskL': ['255.255.255.0', '255.255.0.0', '255.0.0.0'],
    'up': '启用',
    'down': '未启用',
    'msg1': '您确定要删除该网卡吗？',
    'msg2': '您确定启用该网卡吗？',
    'msg3': '您确定要禁用该网卡吗？',
}

# 网络管理测试数据
ifcfgTD = {
    'vlanD': '2',
    'vlanR': ['1', '4094', str(random.randint(6, 4093))],
    'vlanE1': [0, 4095, random.randint(4096, 8780)],
    'vlanE2': list(allSymbolTD) + [random.randint(-4094, -1)],
    'cardD': 'eth0',
    'ipR': random_ip(),
    'ipD': '192.168.100.100',
    'ipE': ipErrorTD,
    'onboot': ['是', '否'],
    'netmask': ['255.255.255.0', '255.255.0.0', '255.0.0.0'],
    'gwD': '192.168.100.1',
    'gwE': ipErrorTD,
    'gwR': random_ip(),
    'del': '3',
    'stop': '4',
    'open': '5'
}
