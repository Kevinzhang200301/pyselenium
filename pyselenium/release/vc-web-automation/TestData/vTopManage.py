#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author  : HalsignRay

from __future__ import unicode_literals
from PublicData import *
from CustomLibrary import *


# 操作后右下角弹窗信息
vtopBox = {
    'msg1': '您确定设置""为默认注册位置吗？',
    'msg2': '请至少选择一个虚拟机！',
    'msg3': '请至少选择一个vTop！',
    'msg4': '请先选择一个vTop！',
    'msg5': '请选择一个vTop！',
    'msg6': '设置""为默认的注册位置成功',
    'msg7': '您确定删除""吗？',
    'msg8': '""不能被删除！原因：该位置下存在子位置，请先删除',
    'msg9': '默认位置""不能删除！'

}

# 位置管理界面信息
localUI = {
    'title1': '位置',
    'title2': '新建一个位置',
    'title3': '新建位置',
    'title4': '编辑位置',
    'title5': '编辑或查看该位置',
    'title6': '删除该位置',
    'title7': '设置为默认位置',
    'title8': '查询满足条件的地理位置',
    'button1': '新建位置',
    'init': '初始化位置',
    'localD': '默认位置',
    'noMsg': '-',
    'tableH1': ['位置', '所属位置', '前缀', '操作'],
    'tableH2': ['清空', '名称', '开始地址', '结束地址'],
    'labelL': ['* 位置', '前缀', '选择网络', '所属位置', '描述'],
    'err1': '位置不能为空！',
    'err2': '前缀只能是abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_-.',
    'err3': '位置""已存在！',
    'err4': '只能输入中文、字母、数字或下划线且长度在3-20个字符之间',
    'srcLabel': '位置',
    'len1': '64',
    'len2': '8',
    'msg1': '您确定设置"默认位置"为默认注册位置吗？'
}

# 位置管理测试数据
localRight = '_-.'
localRightName = '中_'
localTD = {
    'nameD': defaultNameTD,
    'nameR': [random_str(numberTD, 3), random_str(lettersTD, 20), localRightName + random_str(lettersTD, 10)],
    'nameE1': random.randint(1, 2),
    'nameE2': random_str(lettersTD, random.randint(21, len(lettersTD))),
    'nameE3': list(getString(allSymbolTD, localRightName)),
    'markD': 'defaultmarkForTest',
    'markE': random_str(getString(allSymbolTD, localRight)),
    'markR': random_str(numberTD + lettersTD + localRight),
    'des': allSymbolTD,
    'srcName': searchNameList,
    'editD': 'defaultEditForTest',
    'editR': getString(allSymbolTD, "'\\"),
    'del': 'DeleteNameForTest',
    'networkD': 'networkForTest',
}

# 虚拟机管理界面信息
vmUI = {
    'title1': '虚拟机',
    'title2': '删除虚拟机',
    'title3': '打开选中的虚拟机',
    'title4': '关闭选中的虚拟机',
    'title5': '重新启动选择的虚拟机',
    'title6': '如果虚拟机没有下载镜像，则执行镜像下载操作；否则执行更新操作',
    'title7': '将选中的虚拟机还原到镜像',
    'button1': '删除',
    'button2': '关机',
    'button3': '开机',
    'button4': '重启',
    'button5': '更新',
    'button6': '清空',
    'button7': '还原',
    'srcLabel': ['用户名称', '虚拟机名称', '虚拟机状态', '所属位置', '所属vTop'],
    'tableH': ['虚拟机名称', '虚拟机IP', '镜像名称', '所属vTop', '所属用户', '虚拟机状态']
}

# vTop管理界面信息
vtopUI = {
    'title1': 'vTop',
    'title2': 'vTop管理',
    'title3': '可以同时开启多个vTop',
    'title4': '可以同时关闭多个vTop',
    'title5': '可以同时重启多个vTop',
    'title6': '可以同时向多个vTop推送镜像资源',
    'title7': '可以同时为多个vTop更换位置',
    'title8': '启用vTop自动登录',
    'title9': '禁用vTop自动登录',
    'title10': '可以同时升级多个vTop环境',
    'title11': '绑定用户',
    'title12': '取消绑定',
    'title13': '设置成网关',
    'title14': '查询满足条件的vTop',
    'button1': '开机',
    'button2': '关机',
    'button3': '重启',
    'button4': '基础操作',
    'button5': '推送镜像',
    'button6': '更换位置',
    'button7': '启用自动登录',
    'button8': '禁用自动登录',
    'button9': '升级',
    'button10': '绑定用户',
    'button11': '取消绑定',
    'button12': '设置成网关',
    'tableH1': ['主机名', '所在位置', '编号', 'IP地址', '绑定用户', '自动登录', '当前状态', '登陆用户', '可用大小(G)', '操作'],
    'tableH2': ['主机名', 'vTop版本', '主机信息', 'CPU信息', '操作'],
    'detail': '详细',
    'srcLabel': '主机名称',
}
