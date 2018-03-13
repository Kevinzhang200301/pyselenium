#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author  : HalsignRay

from __future__ import unicode_literals
from PublicData import *
import hashlib

chgpwdUI = {
    'title1': '修改密码',
    'labelL': ['用户名', '* 原密码', '* 新密码', '* 确认新密码'],
    'msg1': '修改密码成功，请重新登录！',
    'msg2': '修改密码成功，请从新登录',
    'err1': '密码不得少于六位',
    'err2': '原密码有误!',
    'err3': '旧密码不能为空或空格',
    'err4': '新密码不能为空或空格',
    'err5': '确认密码不能为空或空格',
    'err6': '两次输入的密码必须相同',
}

chgpwdTD = {
    'md5D': hashlib.md5(vc_web_pwd).hexdigest().upper(),
    'pwdD': 'qwer1234qwer',
    'pwdR': [numberTD, numberTD, lettersTD, allSymbolTD],
    'pwdE1': random_str(numberTD, random.randint(1, 5)),
    'pwdE': {
        'old_pwd': '$%@#%$DFWEQ',
        'differ_new': ['qwer123413', 'sdf12fsw', 'cvhafhsdkjdf', '9cjfadjedid']
    }
}
