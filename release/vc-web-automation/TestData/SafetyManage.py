#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Date    : 2017-06-19 20:49:01
# @Author  : HalsignRay
# @Email   : 321134890@qq.com


from __future__ import unicode_literals
from PublicData import *
from CustomLibrary import *

safeBox = {
    'msg2': '请至少选择一个网关！',
    'msg3': '请至少选择一条审计内容！'
}

# 网络密钥界面信息
netKeyUI = {
    'title1': '网络密钥',
    'title2': '新增一个网络密钥',
    'title3': '查看或编辑该网络密钥',
    'title4': '删除该网络密钥',
    'title5': '新建网络密钥',
    'title6': '编辑网络密钥',
    'button1': '新建网络密钥',
    'srcLabel': '网络密钥名称',
    'tableH': ['名称', '值', '操作'],
    'labelL': ['* 名称', '* 值'],
    'len1': '64',
    'len2': '32',
    'msg1': '网络密钥只能是16，24，32位长度',
    'msg2': '您确定删除该网络密钥吗？',
    'msg3': '该网络密钥正在被其它模板使用，不能直接删除！',
    'err1': '网络密钥名称不能为空！',
    'err2': '网络密钥不能为空！',
    'err3': '网络密钥最短为16位',
    'err4': '网络密钥只能是16，24，32位长度',
    'err5': '密钥字符只能包含英文数字,字母,下划线',
    'err6': '网络密钥名称重复！'

}

# 网络密钥测试数据
valueStr = lettersTD + numberTD

netKeyTD = {
    'nameD': 'defaultNameForTest',
    'nameR': allSymbolTD,
    'valueD': '1111111111111111',
    'valueR': [random_str(valueStr, 16), random_str(valueStr, 24), random_str(valueStr, 32)],
    'valueE1': random_str(valueStr, random.randint(1, 15)),
    'valueE2': random_str(valueStr, random_noNum(17, 31, 24)),
    'valueE3': random_str(allSymbolTD, 16),
    'editD': editNameTD,
    'editR': allSymbolTD,
    'srcName': searchNameList,
    'del': deleteNameTD,
    'srcNoName': searchNoName
}

# 加密网络界面信息
erygwUI = {
    'title1': '加密网关',
    'title2': '开启网关',
    'title3': '关闭网关',
    'title4': '重启网关',
    'button1': '开机',
    'button2': '关机',
    'button3': '重启',
    'tableH': ['网关名称', 'CPU信息', '当前状态', '网卡信息', '操作']
}

# 审计管理界面信息
auditUI = {
    'title1': '审计管理',
    'title2': '通过选中的内容',
    'title3': '驳回选中的内容',
    'title4': '查询满足条件的审计信息',
    'button1': '批量删除',
    'button2': '通过',
    'button3': '驳回',
    'tableH': ['请求时间', '用户', '主机', '源虚拟机', '目的虚拟机', '请求类型', '审核状态', '传输结果', '操作'],
    'srcLabel': ['用户名', '源虚拟机', '请求类型', '当前状态'],
    'selectL1': ['全部', '摘要审计', '内容审计'],
    'selectL2': ['全部', '待审核', '通过', '驳回', '数据异常']

}
