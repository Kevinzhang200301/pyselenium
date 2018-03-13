#!/usr/bin/env python
# -*- coding: utf-8 -*-
# Author  : HalsignRay

from __future__ import unicode_literals
from PublicData import *
from CustomLibrary import *
import random


# 操作右下角弹窗信息
resBox = {
    'msg1': '该网络已经分配给了其它模板使用，不能直接删除！',
    'msg2': '该域已经分配给了模板使用，不能直接删除！',
    'msg3': '该设备已经分配给了设备策略，不能直接删除！',
    'msg4': '删除该设备成功',
    'msg5': '删除成功',
    'msg6': '清理成功！',
    'msg7': '请先选择一个镜像！',
    'msg8': '最少保留一次发布的镜像',
    'msg9': '镜像已经合并过或者镜像只包含一个vhd文件，不需要再合并！',
    'msg10': '接口不通，参数错误，口令错误 或者 没有分配镜像 ，请检查或联系管理员',
    'msg11': '请先选择一个模板！',
    'msg12': '请至少选择一个用户！',
    'msg13': '只能选择一个模板！',
    'msg14': '请选择一个使用者！',
    'msg15': '请至少选择一个使用者！',
    'msg16': '请选择一个模板！',
    'msg17': '该镜像当前正在被使用，不能直接删除！'
}

# vlan测试数据
vlanTD = {
    'nameR': allSymbolTD,
    'valueD': '2',
    'valueE1': [0, 4095, random.randrange(4096, 100000000)],
    'valueE2': list(allSymbolTD),
    'valueR': [1, 4094, random.randrange(3, 4093)]
}

# vlan界面信息
vlanUI = {
    'title1': 'VLAN',
    'title2': '新建VLAN',
    'title3': '编辑VLAN',
    'title4': '新增一个VLAN',
    'title5': '删除该VLAN',
    'title6': '查看或编辑该VLAN',
    'button1': '新建VLAN',
    'labelL': ['* 名称', '* 值'],
    'tableH': ['名称', '值', '操作'],
    'srcLabel': 'VLAN名称',
    'delOk': 'OK',
    'len1': '64',
    'len2': '32',
    'msg1': 'VLAN名称不能为空！',
    'msg2': 'VLAN值不能为空！',
    'msg3': 'VLAN值格式错误，只能在1-4094之间',
    'msg4': 'VLAN值只能在1-4094之间',
    'msg5': '您确定删除该VLAN吗？',
    'msg6': '该VLAN正在被其它模板使用，不能直接删除！',
    'msg7': 'VLAN名称重复！'

}

# 升级包测试数据

patchTD = {
    'name': 'patchName.tar',
    'version': '6.0.0.9999',
    'editV': '6.0.0.3827',
    'editN': 'patchNameEdit',
    'editR': 'patchNameRight',
    'errSuffix': TestImportFile("tar", False),
    'errPatch': TestImportFile("tar"),
    'ritPatch': os.path.join(os.path.expanduser("~"), "Desktop",
                             "update9999.tar"),
    'description': '用于测试升级包描述'
}

# 升级包管理界面信息
patchUI = {
    'title1': '升级包',
    'title2': '上传升级包',
    'title3': '编辑升级包',
    'title4': '新增一个升级包',
    'title5': '查看或编辑该升级包',
    'title6': '删除该升级包',
    'title7': '下载该升级包',
    'button1': '上传升级包',
    'button2': '上传',
    'length1': '64',
    'length2': '32',
    'tableHead': ['名称', '发布时间', '版本', '操作'],
    'upLabelList': ['请选择升级包', '* 升级包名称', '* 版本', '说明'],
    'msg1': '上传成功',
    'msg2': '处理中',
    'msg3': '上传中 100%',
    'msg4': '处理中……',
    'msg5': '请先上传升级包',
    'msg6': '升级包错误。请检查文件：',
    'msg7': '上传成功读取版本信息错误,请人工输入版本号',
    'msg8': '升级包名称不能为空！',
    'msg9': '版本不能为空！',
    'msg10': '您确定删除该升级包吗？'

}

# AD测试数据
adRightSymbo = '._-'
ADTD = {
    'nameD': defaultNameTD,
    'nameE': list(getString(allSymbolTD, adRightSymbo)),
    'nameR': [lettersTD, numberTD, adRightSymbo],
    'ipD': ipDefaultTD,
    'ipR': random_ip(),
    'ipE': ipErrorTD
}

# AD域界面信息
ADUI = {
    'title1': 'AD域',
    'title2': '新增一个域管理器',
    'title3': '查看或编辑该域管理器',
    'title4': '删除该域管理器',
    'title5': '新建AD域',
    'title6': '编辑AD域',
    'button1': '新建AD域',
    'srcLabel': '域名',
    'tableH': ['名称', '服务器地址', '操作'],
    'labelList': ['* 名称', '* 服务器地址', '* 用户名', '* 密码', '说明'],
    'len1': '64',
    'len2': '32',
    'msg1': '域名不能为空！',
    'msg2': 'AD域名称',
    'msg3': 'AD域服务器的IP地址',
    'msg4': '域名重复！',
    'msg5': '域服务器IP不能为空！',
    'msg6': '用户名不能为空！',
    'msg7': 'IP地址格式错误，请检查！示例：192.168.100.100！',
    'msg8': '密码不能为空！',
    'msg9': '只能输入英文字母,数字,点,下划线,中横线',
    'msg10': '您确定删除该域吗？'
}

# 设备界面信息
deviceUI = {
    'title1': '设备',
    'title2': '新建设备',
    'title3': '编辑设备',
    'title4': '新增一个设备',
    'title5': '查看或编辑该设备',
    'title6': '删除该设备',
    'srcLabel': '设备名称',
    'noMsg': '-',
    'sys': 'system',
    'admin': '管理员',
    'NameD1': '虚拟光驱设备',
    'NameD2': '光驱设备',
    'NameD3': 'USB存储设备',
    'typeD1': '光驱',
    'typeD2': 'USB存储设备',
    'tableH': ['设备名称', '设备类型', '厂商ID', '产品ID', '创建人', '操作'],
    'labelList': ['* 设备名称', '设备标签', '设备类型', '* 厂商ID', '* 产品ID', '描述'],
    'msg1': '设备名称不能为空！',
    'msg2': '产品ID不能为空！',
    'msg3': '厂商ID不能为空！',
    'msg4': '设备名称已存在！',
    'msg5': '您确定删除该设备吗？',
    'msg6': '设备名称不能包含单引号！',
    'len1': '64',
    'typeList': ['UKEY', 'USB存储设备', '光驱', '打印机', '摄像头', '其它']
}

# 设备测试数据
deviceError = "'"
deviceTD = {
    'nameR': [numberTD, lettersTD, getString(allSymbolTD, deviceError)],
    'nameE': deviceError,
}

# 网络界面信息
networkUI = {
    'title1': '网络',
    'title2': '新增一个网络',
    'title3': '查看或编辑该网络',
    'title4': '删除该网络',
    'title5': '新建网络',
    'title6': '编辑网络',
    'srcLabel': '网络名称',
    'noMsg': '-',
    'nameD1': '用户自定义',
    'nameD2': 'DHCP',
    'tableH': ['网络名称', '开始地址', '结束地址', '子网掩码', '网关', 'DNS服务器', '备用DNS服务器', '操作'],
    'labelList': ['* 网络名称', '* 开始地址', '* 结束地址', '* 子网掩码', '* 网关', '* DNS服务器', '备用DNS服务器', '说明'],
    'err1': '网络名称不能为空！',
    'err2': '开始地址不能为空！',
    'err3': 'IP地址格式错误，请检查！示例：192.168.100.100！',
    'err4': '结束地址不能为空！',
    'err5': '开始地址不能等于结束地址！',
    'err6': '开始地址不能大于结束地址！',
    'err7': '子网掩码不能为空！',
    'err8': '子网掩码格式错误，请检查！示例：255.255.255.0！',
    'err9': '网关不能为空！',
    'err10': '网关格式错误，请检查！示例：192.168.1.1！',
    'err11': 'DNS服务器不能为空！',
    'err12': 'DNS服务器格式错误，请检查！示例：192.168.1.1！',
    'err13': '备用服务器格式错误，请检查！示例：192.168.1.1！',
    'err14': '网络名称已存在！',
    'msg1': '您确定删除该网络吗？',
    'len1': '64',
    'len2': '32'
}

# 网络测试数据
networkTD = {
    'nameD': defaultNameTD,
    'nameR': [numberTD, lettersTD, getString(allSymbolTD, "'")],
    'srcName': searchNameList,
    'startIpD': '1.1.1.1',
    'startIpR': '1.1.1.2',
    'IpE': ipErrorTD,
    'endIpD': '1.1.1.5',
    'endIpR': '1.1.1.4',
    'maskD': '255.255.255.0',
    'maskR': getRandomNetmask(),
    'maskE': maskErrorTD,
    'gatewayD': '1.1.1.1',
    'gatewayR': '2.2.2.2',
    'dns1D': '1.1.1.1',
    'dns1R': '3.3.3.3',
    'dns2D': '1.1.1.1',
    'editD': editNameTD,
    'del': deleteNameTD,
    'des': allSymbolTD,
}

# 漫游数据管理界面信息
wanderUI = {
    'title1': '漫游数据',
    'title2': '可以清理由于各种异常引起的无用的漫游数据',
    'button': '清理漫游数据',
    'tableH': ['用户名', '数据类型', '时间', '漫游信息', '操作'],
    'srcLabel': ['用户名', '数据类型'],
    'typeList': ['全部', '系统盘', '用户盘'],
    'msg1': '您确定要清理无用的漫游数据么？'
}

# 镜像管理界面信息
vhdUI = {
    'title1': '镜像',
    'title2': '创建镜像',
    'title3': '编辑镜像',
    'title4': '新增一个镜像',
    'title5': '合并该镜像包含的所有的vhd文件，生成一个新的vhd文件',
    'title6': '设置镜像的桌面显示图标',
    'title7': '清理无用的镜像',
    'title8': '获取上级vTop Center分配的镜像信息',
    'title9': '查看或编辑该镜像',
    'title10': '删除该镜像',
    'title11': '下载该镜像文件',
    'title12': '将镜像回滚到上一个版本',
    'title13': '设置桌面',
    'title14': '设置镜像桌面',
    'title15': '从镜像VHD链的末端开始显示',
    'title16': '查看镜像',
    'title17': '镜像详细信息',
    'title18': '从上级vTop Center下载或更新镜像',
    'title19': '删除该镜像',
    'title20': '已完成',
    'button1': '创建镜像',
    'button2': '合并镜像',
    'button3': '设置桌面',
    'button4': '清理镜像',
    'button5': '获取镜像列表',
    'button6': '同步',
    'button7': '删除',
    'tableH1': ['镜像名称', '发布次数', '系统版本', '发布人', '发布时间', '操作'],
    'tableH2': ['镜像名称', '系统版本', '发布人', '发布时间', '状态', '操作'],
    'tableH3': ['VHD名称', 'VHD大小'],
    'srcLabel': '名称',
    'strongL': ['镜像', '本地镜像', '上级镜像'],
    'promptL': ['存储池状态', '总容量：', '已用大小：', '可用大小：', '告警阈值：', '使用率：', '告警阈值：'],
    'labelL': ['请选择镜像文件', '* 镜像名称', '* 版本', '绝对路径', '镜像ID', '说明'],
    'detalLabel': ['镜像名称', '版本', '发布人', '发布时间', '镜像大小', '镜像ID', '镜像位置'],
    'editLabel': ['* 镜像名称', '* 版本', '镜像大小', '镜像ID', '说明'],
    'len1': '64',
    'len2': '32',
    'err1': '镜像格式错误。请检查文件：',
    'err2': '上传成功',
    'err3': '镜像名称不能为空！',
    'err4': '版本不能为空！',
    'err5': '请先上传镜像文件',
    'err6': '请选择一个镜像桌面！',
    'err7': '镜像名称重复！',
    'msg1': '上传中 100%',
    'msg2': '您确定合并该镜像吗？',
    'msg3': '您确定要清理无用的镜像文件吗？（如果当前还有镜像正在发布过程中，请发布成功之后再执行该操作）',
    'msg4': '您确定回退该镜像吗？',
    'msg5': '您确定删除该镜像吗？',
}

# 镜像测试数据
vhdTD = {
    'upperVc': '192.168.0.21',
    'syncKey': '123',
    'nameD': defaultNameTD,
    'nameR': [numberTD, lettersTD, allSymbolTD],
    'fileR': TestImportFile('vhd'),
    'fileE': TestImportFile('vhd', False),
    'versionD': defaultNameTD,
    'versionR': random_str(allSymbolTD, 32),
    'des': numberTD + lettersTD + allSymbolTD,
    'srcName': searchNameList,
    'editD': editNameTD,
    'del': deleteNameTD,
    'imgNum': random.randint(1, 22),
}

# 模板界面信息
tempUI = {
    'title1': '模板',
    'title2': '创建模板',
    'title3': '编辑模板',
    'title4': '创建一个模板',
    'title5': '把该模板分配给若干用户',
    'title6': '查询指定模板分配给了那些用户',
    'title7': '查看或编辑该模板',
    'title8': '删除该模板',
    'title9': '查看该模板的配置信息',
    'title10': '分配模板',
    'title11': '删除选中的使用该模板的用户',
    'title12': '设置模板为选中用户的开关机联动模板',
    'title13': '取消模板为选中用户的开关机联动模板',
    'title14': '用户',
    'title15': '分配用户',
    'title16': '查看模板',
    'title17': '模板详细信息',
    'stepT': ['常规', '系统', '网络', '策略', '概览'],
    'button1': '创建模板',
    'button2': '分配用户',
    'button3': '使用情况',
    'button4': '上一步',
    'button5': '下一步',
    'button6': '完成',
    'button7': '清空',
    'button8': '查 询',
    'button9': '删除',
    'button10': '设置开关机联动',
    'button11': '取消开关机联动',
    'button12': confirmBtn3,
    'srcLabel': '模板名称',
    'selectD': '请选择',
    'selectL1': ['无规则', 'vTop主机名作为前缀(vTop主机名+数字)', '用户名作为前缀(用户名+随机字符)', '自定义前缀(自定义前缀+随机字符)'],
    'tableH1': ['模板名称', '镜像名称', '磁盘加密', 'CPU数量', '硬盘大小(G)', '内存大小(M)', '网卡数量', '操作'],
    'tableH2': ['清空', '域名', '域服务器IP'],
    'tableH3': ['名称', '开始地址', '结束地址', '网关/掩码', '域名服务器'],
    'tableH4': ['策略名称', '类型', '设备', '设备数量'],
    'tableH5': ['用户名', '真实姓名', '所属用户组', '发布者'],
    'tableH6': ['账号', '名称', '发布者'],
    'labelL1': ['请选择镜像', '*模板名称', '命名规则', 'AD域'],
    'labelL2': ['CPU数量', '* 内存(M)','创建数据盘', '* 硬盘(G)', '磁盘加密', '审计类型', '串并兼容模式'],
    'labelL3': ['用户名', '用户组'],
    'labelL4': '请选择设备策略',
    'labelL5': ['模板名称', '镜像名称', '命名规则', 'AD域', 'CPU数量', '内存大小(M)', '硬盘大小(G)', '磁盘加密', '审计类型', '设备策略', '隔离策略'],
    'netlabel': ['连接方式', '绑定的网卡', '绑定网络', ],
    'valueL': ['无规则', '', '自适应', '1024', '20', '否', '禁止传输', '', 'bridge', '物理网卡1（eth0）', '用户自定义', '默认策略', ''],
    'valueL1': ['无规则', '', '自适应', '1024', '20', '否', '禁止传输', '', 'bridge', 'eth0', '用户自定义', '默认策略', '无'],
    'netCardNameL': ['网卡1', '网卡2', '网卡3', '网卡4'],
    'cpuNum': ['自适应', '1', '2', '3', '4', '5', '6', '7', '8'],
	'createDisk': ['是', '否'],
    'stubdom': ['启用', '禁用'],
    'diskEncry': ['否', '是'],
    'auditType': ['自由传输', '摘要审计', '内容审计', '禁止传输'],
    'connectL': ['bridge', 'NAT', 'hostonly'],
    'connectT': '连接方式',
    'enableL': ['启用网络', '启用网卡加密', '启用VLAN'],
    'phyCardT': '请选择物理网卡',
    'phyCardL': ['物理网卡1（eth0）', '物理网卡2（eth1）', '物理网卡3（eth2）', '物理网卡4（eth3）', '无线网卡（wifi）'],
    'networkT': '请选择网络',
    'networkD': ['用户自定义', 'DHCP'],
    'netKeyT': '请选择网络密钥',
    'vlanT': '请选择VLAN',
    'memoryD': '1024',
    'diskD': '20',
    'deviceD': ['默认策略', '黑名单', '无限制', '1'],
    'deviceT': '请选择设备策略',
    'len1': '64',
    'err1': '请选择模板使用的镜像！',
    'err2': '模板名称只能由英文字符，数字，点，空格，下划线，中横线组成',
    'err3': '请输入模板名称',
    'err4': '当选择"自定义前缀"时，自定义前缀不能为空！',
    'err5': '自定义前缀只能由英文字符，数字，点，下划线组成',
    'err6': '内存大小不能为空！',
    'err7': '硬盘大小不能为空！',
    'err8': '分配内存过小,内存应该大于等于128M',
    'err9': '分配硬盘过小,硬盘应该大于等于5G！',
    'err10': '内存大小必须为数字！',
    'err11': '分配内存过大,内存不应该大于16*1024M',
    'err12': '硬盘大小必须为数字！',
    'err13': '分配硬盘过大,硬盘应该小于4*1024G！',
    'err14': '请选择一个网络密钥！如果没有网络密钥，请先到"安全管理"---"网络密钥"中定义',
    'err15': '请先选择一个vlan',
    'err16': '内存大小不能为负数',
    'err17': '硬盘大小不能为负数！',
    'err18': '自定义前缀最多只能是7位',
    'err19': '模板名称已存在！',
    'err20': '请分配串并口！',
    'msg1': '磁盘加密模板不会分配给发布者',
    'msg2': '您确定要删除选中的使用者吗？',
    'msg3': '您确定要将该模板设定为选定用户的开关机联动模板吗？',
    'msg4': '您确定要取消该模板为选定用户的开关机联动模板吗？',
    'msg5': '设置成功！',
    'msg6': '取消成功！',
    'msg7': '您确定删除该模板吗？',
    'msg8': '删除模板成功！',
    'msg9': '该模板已经分配给用户使用，不能直接删除！'
}

# 模板测试数据
templateRightSymbols = '-._'
tempTD = {
    'nameD': defaultNameTD,
    'nameD1': defaultNameTD + '999',
    'nameR': str(random.randint(1, 9)) + templateRightSymbols + random_str(lettersTD),
    'nameE': list(getString(allSymbolTD, templateRightSymbols)),
    'customNameE1': list(getString(allSymbolTD, templateRightSymbols)),
    'customNameE2': random_str(lettersTD + allSymbolTD, random.randint(8, 64)),
    'customNameR': str(random.randint(1, 9)) + '._' + random_str(lettersTD, 4),
    'vhdD': 'vhdForTest',
    'adD': 'adForTest',
    'editD': 'editForTest',
    'memoryE1': random.randint(-88888, -1),
    'memoryE2': list(allSymbolTD),
    'memoryE3': random.randint(0, 127),
    'memoryE4': random.randint(16385, 999999999),
    'memoryR': ['128', str(random.randint(129, 16383)), '16384'],
    'diskE1': random.randint(-88888, -1),
    'diskE2': list(allSymbolTD),
    'diskE3': random.randint(0, 4),
    'diskE4': random.randint(4097, 999999999),
    'diskR': ['5', str(random.randint(6, 4095)), '4096'],
    'netKeyR': 'netKeyForTest',
    'vlanR': 'vlan88',
    'netNameR': 'netNameForTest',
    'policyR': 'policyForTest',
    'del': 'delForTest',
    'srcName': searchNameList,
    'userR': ['userForTest', 'userForTest1'],
    'userPub': 'PublisherForTest',
    'srcNoName': searchNoName,
}
