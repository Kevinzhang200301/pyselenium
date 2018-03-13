#!/usr/bin/env python
# -*- coding: utf-8 -*-


from __future__ import unicode_literals
from PublicData import *

# 用户管理界面lobibox信息
userBox = {
    'msg1': '请至少选择一个用户！',
    'msg2': '请选择一个模板！',
    'msg3': '您确定删除该用户吗？',
    'msg4': '请至少选择一个虚拟机！',
    'msg5': '您确定设置""为开关机联动模板吗？',
    'msg6': '设置""为开关机联动模板成功',
    'msg7': '您确定要取消""的开关机联动吗？',
    'msg8': '取消""的开关机联动成功',
    'msg9': '您确定删除该模板吗？',
    'msg10': '请至少选择一个模板',
    'msg11': '您确定删除这个模板吗？',
    'msg12': '请选择一个用户！',
    'msg13': '请至少选择一个用户！',
    'msg14': '密码重置成功',
    'msg15': '开通用户成功',
    'msg16': '停用用户成功',
    'msg17': '您确定要重置选中用户的密码吗？',
    'msg18': '您确定要开通选中的用户吗？',
    'msg19': '您确定要停用选中的用户吗？',
    'msg20': '发布者不能修改用户策略',
    'msg21': '您确定删除该名称为""的用户组吗？',
    'msg22': '用户组""不能被删除！原因：该用户组下存在子用户组，请先删除',
    'msg23': '用户组""不能被删除！原因：该用户组下还有用户，请先删除'
}

# vTop用户测试数据
userRightSymbol = '._-'
userTD = {
    'nameD': 'userNameForTest',
    'nameE1': list(getString(allSymbolTD, userRightSymbol)) + ['1 1'],
    'nameE2': systemRetainsUser + [randomUpperCase(i) for i in systemRetainsUser[1:]],
    'nameE3': randomUpperCase(systemRetainsUser[0]),
    'nameR': [numberTD, lettersTD, userRightSymbol],
    'pubName': 'publisherTest',
    'comName': ['conmmonUserForTest1', 'conmmonUserForTest2'],
    'tempName': ['templateForTestUser', 'templateForTestUser1', 'templateForTestUser2'],
    'groupD': 'groupForTest',
    'policyD': 'userPolicyForTest',
    'realD': 'realNameForTest',
    'realR': allSymbolTD,
    'pwdE1': random_str(numberTD, random.randint(1, 5)),
    'pwdR': [numberTD,  ''.join(random.sample(lettersTD, 32)), userRightSymbol],
    'emailE': errorEmail + [allSymbolTD, numberTD, lettersTD],
    'emailR': 'test@halsign.com',
    'dateR': '2019-06-30',
    'dateE': [allSymbolTD, numberTD, lettersTD],
    'editD': 'editUserForTest',
    'del': 'deleteUserForTest',
    'srcName': searchNameList,
    'srcNoName': searchNoName,
    'importR': TestImportFile("xls"),
    'importE': TestImportFile("xls", False)
}

IgnoreCase = randomUpperCase(userTD['nameD'])

# 用户管理界面信息
userUI = {
    'title1': '用户管理',
    'title2': '新增一个用户',
    'title3': '为多个用户配模板',
    'title4': '编辑',
    'title5': '删除',
    'title6': '查看虚拟机',
    'title7': '选中任何一个用户，查看该用户已分配的用户策略或为该用户分配一个用户策略',
    'title8': '可以同时为多个用户重置密码',
    'title9': '可以同时开通多个用户',
    'title10': '可以同时停用多个用户',
    'title11': '可以同时为多个用户更换用户组',
    'title12': '可以批量导入用户',
    'title13': '新建用户',
    'title14': '编辑用户',
    'title15': '用户',
    'title16': '有效期至',
    'title17': '分配模板',
    'title18': '用户详情',
    'title19': '配置用户策略',
    'title19-1': '用户：',
    'title19-2': '姓名：',
    'title19-3': '用户组：',
    'title19-4': '（共有""等位用户参与策略分配，发布者不参与分配）',
    'title20': '更换用户组',
    'title21': '导入用户',
    'button1': '新建用户',
    'button2': '分配模板',
    'button3': '基础操作',
    'button4': '用户策略',
    'button5': '重置密码',
    'button6': '开通用户',
    'button7': '停用用户',
    'button8': '更换用户组',
    'button9': '导入用户',
    'button10': '查 询',
    'button11': 'OK',
    'tableH': ['用户名', '真实姓名', '所属用户组', '发布者', '模板数量', '用户策略', '操作'],
    'tableH2': ['模板名称', '系统名称', '磁盘加密', 'cpu数量', '硬盘大小', '内存大小', '网卡数量'],
    'tableH3': ['策略名称', '用户规则', '规则数量'],
    'tableH4': ['用户账号', '用户名称', '所属用户组', '是否开通'],
    'labelL1': ['* 用户名', '* 真实姓名', '* 密码', '电子邮件', '所属用户组', '有效期至', '发布者', '是否开通'],
    'labelL2': ['* 用户名', '* 真实姓名', '* 密码', '电子邮件', '所属用户组', '磁盘加密码', '用户目录', '有效期至', '发布者', '是否开通'],
    'label3': '模板名称',
    'labelL4': ['用户名', '真实姓名', '密码', '电子邮件', '所属用户组', '磁盘加密码', '磁盘容量(G)', '用户目录', '有效期至', '发布者', '是否开通'],
    'label5': '* 用户组',
    'label6': '请选择用户文件    下载模板',
    'srcLabel': '用户名称',
    'PwdD': 'password',
    'groupD': '初始用户组',
    'diskSizeD': '50',
    'dateD': [getDefualtDate(expiryTime)['year'], getDefualtDate(expiryTime)['month'], getDefualtDate(expiryTime)['day']],
    'headerH': ['请选择新的用户组', '已选择的用户'],
    'len1': '16',
    'len2': '64',
    'len3': '32',
    'pub': ['是', '否'],
    'userStatus': ['是', '否'],
    'stop': '已停用',
    'expired': '已过期',
    'poolPath': '/storage/pool/',
    'warn': '发布者不会分配磁盘加密模板',
    'err1': '用户名不能为空！',
    'err2': '只能包含英文字符,数字,点,下划线,中横线',
    'err3': '该用户为系统保留用户！',
    'err4': '该用户为系统保留关键字！',
    'err5': '真实姓名不能为空！',
    'err6': '密码不能为空！',
    'err7': '只能包含英文字符,数字,点,下划线,中横线',
    'err8': '密码必须大于等于6位！',
    'err9': '帐号已经被vtrans使用',
    'err10': '帐号已经被使用。 请查看 用户管理 --- 用户',
    'err11': '帐号已经被使用。 请查看 权限管理 --- 管理员',
    'err12': '邮件格式错误！邮箱的格式：xxx@mail.xxx.com',
    'err13': '文件错误，请重新选择excel文件',
    'err14': '请先选择一个文件！',
    'err15': '用户组不能为空',
}

# 用户查看虚拟机界面元素信息
seeVmUI = {
    'title1': '虚拟机',
    'title2': '删除虚拟机',
    'title3': '将选中的虚拟机还原到镜像',
    'title4': '打开选中的虚拟机',
    'title5': '关闭选中的虚拟机',
    'title6': '重新启动选择的虚拟机',
    'title7': '如果虚拟机没有下载镜像，则执行镜像下载操作；否则执行更新操作',
    'title8': '查询满足条件的虚拟机',
    'button1': '删除',
    'button2': '还原',
    'button3': '开机',
    'button4': '关机',
    'button5': '重启',
    'button6': '更新',
    'button7': '清空',
    'tableH': ['虚拟机名称', '镜像名称', '所属vTop', '所属用户', '虚拟机状态'],
    'labelL': ['用户名称', '虚拟机名称', '虚拟机状态', '所属位置', '所属vTop'],
    'selectL': ['全部', '未就绪', '已就绪', '已开机', '离线']
}


# 用户查看模板界面信息
seeTempUI = {
    'title1': '点击我查看模板信息',
    'title2': '已分配的模板如下',
    'title3': '查看模板',
    'title4': '用户：',
    'title5': '用户组：',
    'title6': '删除选中的模板',
    'title7': '删除模板',
    'title8': '设置开关机联动',
    'title9': '取消开关机联动',
    'title10': '查看该模板的配置信息',
    'title11': '模板详细信息',
    'button1': '删除',
    'tableH': ['模板名称', '镜像名称', '系统版本', '开关机联动', '磁盘加密', 'CPU数量', '硬盘大小(G)', '内存大小(M)', '网卡数量', '操作'],
    'valueL': ['无规则', '', '自适应', '1024', '20', '否', '禁止传输', '', 'bridge', 'eth0', '用户自定义', '默认策略', '无']
}

# 用户组管理界面信息
userGroupUI = {
    'initName': '初始用户组',
    'title1': '用户组',
    'title2': '新建一个用户组',
    'title3': '编辑',
    'title4': '删除',
    'title5': '新建用户组',
    'title6': '编辑用户组',
    'button1': '新建用户组',
    'srcLabel': '用户组名称',
    'admin': '管理员',
    'tableH': ['用户组', '所属用户组', '创建人', '创建时间', '操作'],
    'label': ['* 用户组名称', '上级用户组', '用户组描述'],
    'err1': '用户组名称不能为空！',
    'err2': '用户组""已存在！',
    'err3': '用户组名称请选择常用字符，比如汉字，英文，数字等！不能使用逗号，斜杠等特殊字符'
}

# 用户管理测试数据
groupRightSymbol = '%——·！……）（】【“；：;:，《。》？中._-'
userGroupTD = {
    'nameD': 'defaultGroupForTest',
    'nameR': groupRightSymbol[:3] + ' ' + groupRightSymbol[3:],
    'nameE': list(getString(allSymbolTD, groupRightSymbol)),
    'des': allSymbolTD[:3] + ' ' + allSymbolTD[3:],
    'user': 'user1ForTestUserGroup',
}