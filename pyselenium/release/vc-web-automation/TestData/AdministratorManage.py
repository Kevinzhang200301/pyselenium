#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author  : HalsignRay

from __future__ import unicode_literals
from PublicData import *
import datetime


# 管理员测试数据
adminTD = {
    'realD': 'realNameForAdmin',
    'realR': random_str(allSymbolTD, 16),
    'nameE1': list(allSymbolTD),  # 特殊符号
    'nameE2': systemRetainsUser[:-1],  # 管理员账号存在系统关键字
    'nameE3': ['administrator', randomUpperCase('administrator')] + [randomUpperCase(i) for i in systemRetainsUser[1:-1]],
    'nameE4': randomUpperCase('root'),
    'nameR': [numberTD, random_str(lettersTD, 16)],
    'searchReal': ['searchRealName', 'searchRealName1', 'searchRealName2', 'searchRealName3'],
    'newPWD': 'passwordTest',
    'cellphoneR': '13880964532',
    'cellphoneE1': '87382388',
    'cellphoneE2': 'allSymbolTD',
    'officeE': ['!@#%&', '9998888827', 'asdfvasdf'],
    'officeR': '8792-82639462',
    'mailE': ['dadf33', 'ad@d3sd', '38dfd.com'],
    'mailR': 'test@halsign.com',
    'qq': 'dad87dfadf',
    'address': 'duacads中文',
    'expiryE': ['中文中文', '2102934-1234123234556', 'askdbnoweir',
                  '￥#￥！DSFASDF', '@#$%SDfga'],
    'expiryR': '2030-12-30',
    'nowTime': datetime.datetime.strftime(datetime.datetime.now(), '%Y-%m-%d'),
}

# 管理员管理界面信息
adminUI = {
    'title1': '管理员',
    'title2': '管理员管理',
    'title3': '新增一个管理员',
    'title4': '为多个管理员重置密码',
    'title5': '为选择的管理员设置管理范围',
    'title6': '查看或编辑该用户',
    'title7': '删除该用户',
    'title8': '恢复已经停用的用户',
    'title9': '新建管理员',
    'title10': '编辑管理员',
    'title11': '设置管理范围',
    'button1': '新建',
    'button2': '重置密码',
    'button3': '设置管理范围',
    'widget1': ['基本信息', '角色权限', '管理范围', '联系方式'],
    'widget2': '当前选择管理范围：',
    'tableH': ['用户名', '真实姓名', '用户角色', '管理范围', '有效期至', '用户状态', '操作'],
    'tableAdmin': ['admin', '管理员', '系统管理员', '全部', '2099-12-12'],
    'labelL': ['* 管理员账号', '* 真实姓名', '状态', '有效期至', '* 角色', '手机号码', '办公电话', '个人邮箱', 'QQ号码', '通讯地址'],
    'status': ['开通', '停用'],
    'statusT': ['已开通', '已停用'],
    'role': ['系统管理员', '普通管理员'],
    'msg1': '请输入管理员账号，默认密码：111111',
    'msg2': '（不选择截止日期，账号则永不过期）',
    'msg3': '请正确填写11位手机号码，如：13898989999',
    'msg4': '格式如：0000-00000000',
    'msg5': '请输入正确邮箱，如：aaa@163.com',
    'msg6': '输入管理员名或者真实姓名查询',
    'Select': '当前选择',
    'all': '全部',
    'init': '初始化位置',
    'longTime': '2099-12-12',
    'pwdD': '111111',
    'modules': '我的主页\n用户管理\nvTop管理\n日志管理',
    'len1': '16',
    'len2': '11',
    'len3': '15',
    'len4': '30',
    'len5': '12',
    'len6': '50',
    'err1': '管理员账号只能是数字、字母或数字和字母组合',
    'err2': '帐号已经被使用。 请查看 用户管理 --- 用户',
    'err3': '帐号已经被使用。 请查看 权限管理 --- 管理员',
    'err4': '管理员账号存在系统关键字',
    'err5': '请输入管理员账号',
    'err6': '请输入您的真实姓名',
    'err7': '请为管理员分配一个角色',
    'err8': '手机号码格式不正确',
    'err9': '手机号码必须为数字',
    'err10': '办公电话号码格式不正确',
    'err11': '请输入正确的邮箱',
    'err12': '该用户为系统保留用户！',
    'err13': '帐号已经被vtrans使用'
}

# 管理员box信息
adminBox = {
    'msg1': '操作成功',
    'msg2': '请选择要重置密码的管理员',
    'msg3': '请至少选择一个管理员！',
    'msg4': '密码重置成功！新密码为：111111',
    'msg5': '操作成功!',
    'msg6': '您确定要重置密码吗？',
    'msg7': '删除该管理员后，该管理员所有相关资料都将被删除且无法恢复，您确定此操作吗？'
}
