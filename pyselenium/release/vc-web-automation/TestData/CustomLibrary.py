#!/usr/bin/env python
# -*- coding: utf-8 -*-
# @Date    : 2017-06-06 17:41:45
# @Author  : HalsignRay
# @Email   : 321134890@qq.com


import os
import random
import socket
import struct
import datetime


class CustomLibrary(object):

    ROBOT_LIBRARY_VERSION = 1.0

    def __init__(self):
        pass


def getRandomNetmask():
    '''get random subnet mask'''

    mask_int = random.randint(1, 31)
    bin_arr = ['0' for i in range(32)]
    for i in range(mask_int):
        bin_arr[i] = '1'
    tmpmask = [''.join(bin_arr[i * 8:i * 8 + 8]) for i in range(4)]
    tmpmask = [str(int(tmpstr, 2)) for tmpstr in tmpmask]
    return '.'.join(tmpmask)


def random_str(randomStr, randomlength=8):
    str = ''
    chars = randomStr
    length = len(chars) - 1
    for i in range(randomlength):
        str += chars[random.randint(0, length)]
    return str


def random_noNum(starNum, endNum, *noNum):
    while True:
        i = random.randint(starNum, endNum)
        if i not in noNum:
            return i


def GetDhcpIp(mantissa, vTopCenterIp):
    '''get same network segment from vTop Center'''
    ipStr = ''
    IpfiedList = vTopCenterIp.split(".")
    for i in range(3):
        ipStr += ''.join(IpfiedList[i]) + '.'
    return ipStr + str(mantissa)


def TestImportFile(rightSuffix, fileStatus=True):
    '''Gets the path to the imported file'''
    scriptPath = os.path.split(os.path.abspath(__file__))[0]
    pathList = scriptPath.split('\\')
    pathList[-1] = 'PatchFile'
    importPath = ''
    for i in pathList:
        importPath += i + '\\'
    fileList = os.listdir(importPath)
    rightFilePath = []
    errorFilePath = []
    for i in fileList:
        if not i.startswith('.'):
            if rightSuffix in i:
                rightFilePath.append(os.path.join(importPath, i))
            else:
                errorFilePath.append(os.path.join(importPath, i))
    if fileStatus:
        return rightFilePath[0]
    else:
        return errorFilePath


def random_ip():
    return socket.inet_ntoa(struct.pack('>I', random.randint(1, 0xffffffff)))


def getDefualtDate(expiry):
    month1 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    month2 = ['一', '二', '三', '四', '五', '六', '七', '八', '九', '十', '十一', '十二']
    dateDic = {}
    nowTime = datetime.datetime.now()
    expiryDate = nowTime + datetime.timedelta(days=expiry)
    dateDic['year'] = expiryDate.year
    dateDic['month'] = month2[month1.index(expiryDate.month)]
    dateDic['day'] = expiryDate.day
    return dateDic


def getString(initStr, stripStr):

    for i in stripStr:
        initStr = initStr.replace(i, '')
    return initStr


def randomUpperCase(randomStr):
    number = random.randint(1, len(randomStr))
    randomStr = randomStr.encode('utf-8')
    StrList = list(randomStr)
    StrNumList = range(len(randomStr))
    for i in range(number):
        a = random.choice(StrNumList)
        StrList[a] = StrList[a].upper()
        StrNumList.remove(a)
    return ''.join(StrList)
