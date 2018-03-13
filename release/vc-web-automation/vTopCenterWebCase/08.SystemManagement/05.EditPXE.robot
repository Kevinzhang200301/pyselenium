*** Settings ***
Suite Setup       prepare env for edit PXE
Suite Teardown    clear env for edit PXE
Force Tags      ${pxeTag['default']}
Resource          ../../Keyword/SystemManage/PxeManageKeywords.robot

*** Test Cases ***
编辑安装包界面信息验证
    [Tags]    ${pxeTag['info']}
    into pxe manage UI
    click edit install patch button    ${pxeTD['nameD']}
    verify lay UI title info    ${pxeUI['title14']}

挂载安装包界面信息验证
    [Tags]    ${pxeTag['info']}
    into pxe manage UI
    click mount install patch button    ${pxeTD['nameD']}
    verify mount install package UI title
    verify mount install package UI form info

编辑安装包_名称为空
    [Tags]    ${pxeTag['edit']}
    into pxe manage UI
    click edit install patch button    ${pxeTD['nameD']}
    input install patch name    ${EMPTY}
    click save button
    verify install patch name error info    ${pxeUI['err1']}

编辑安装包_名称正确
    [Tags]    ${pxeTag['edit']}    smokeCase
    into pxe manage UI
    click edit install patch button    ${pxeTD['editD']}
    input install patch name    ${pxeTD['editR']}
    click save button    True
    verify lobibox info
    verify install patch on the UI    ${pxeTD['editR']}

编辑安装包_名称重复
    [Tags]    ${pxeTag['edit']}
    into pxe manage UI
    click edit install patch button    ${pxeTD['nameD']}
    input install patch name    ${pxeTD['srcName'][1]}
    click save button
    verify install patch name error info    ${pxeUI['err18']}

编辑安装包_名称忽略大小写
    [Tags]    ${pxeTag['edit']}
    into pxe manage UI
    click edit install patch button    ${pxeTD['nameD']}
    ${upper}    Convert To Uppercase    ${pxeTD['srcName'][0]}
    input install patch name    ${upper}
    click save button
    verify install patch name error info    ${pxeUI['err18']}

删除安装包_弹窗信息验证
    [Tags]    ${pxeTag['info']}
    into pxe manage UI
    click delete install patch button    ${pxeTD['del']}
    verify confirm box info    ${pxeUI['msg4']}

删除安装包_取消
    [Tags]    ${pxeTag['del']}
    into pxe manage UI
    click delete install patch button    ${pxeTD['del']}
    click confirm box cancel button
    verify confirm not exist

删除安装包_确定
    [Tags]    ${pxeTag['del']}    smokeCase
    into pxe manage UI
    click delete install patch button    ${pxeTD['del']}
    click confirm box confirm button
    ${status}    Run Keyword And Return Status    verify install patch on the UI    ${pxeTD['del']}
    Should Be Equal As Strings    ${status}    False

搜索安装包_不输入任何值
    [Tags]    ${pxeTag['search']}
    into pxe manage UI
    ${num}    get current table record number
    input search install patch name    ${EMPTY}
    click search button
    verify table records current page    ${num}

搜索安装包_不存在的名称
    [Tags]    ${pxeTag['search']}
    into pxe manage UI
    : FOR    ${name}    IN    @{pxeTD['srcNoName']}
    \    input search install patch name    ${name}
    \    click search button
    \    verify table records current page    0

搜索安装包_已存在的完整名称
    [Tags]    ${pxeTag['search']}
    into pxe manage UI
    input search install patch name    ${pxeTD['srcName'][1]}
    click search button
    verify table records current page    1

搜索安装包_已存在名称的部分字段
    [Tags]    ${pxeTag['search']}
    into pxe manage UI
    ${len}    Get Length    ${pxeTD['srcName']}
    input search install patch name    ${pxeTD['srcName'][0]}
    click search button
    verify table records current page    ${len}

挂载安装包_vTop密码为空
    [Tags]    ${pxeTag['mount']}
    into pxe manage UI
    click mount install patch button    ${pxeTD['nameD']}
    input mount install package vtop password    ${EMPTY}
    click mount install package UI mount button
    verify mount install package vtop password error info    ${pxeUI['err14']}

挂载安装包_vTop密码少于6位
    [Tags]    ${pxeTag['mount']}
    into pxe manage UI
    click mount install patch button    ${pxeTD['nameD']}
    input mount install package vtop password    ${pxeTD['vtopPwdE']}
    click mount install package UI mount button
    verify mount install package vtop password error info    ${pxeUI['err15']}

挂载安装包_vTop密码非法字符
    [Tags]    ${pxeTag['mount']}
    into pxe manage UI
    click mount install patch button    ${pxeTD['nameD']}
    : FOR    ${pwd}    IN    @{pxeTD['vtopPwdE2']}
    \    input mount install package vtop password    ${pwd*6}
    \    click mount install package UI mount button
    \    verify mount install package vtop password error info    ${pxeUI['err17']}

挂载安装包_密码正确
    [Tags]    ${pxeTag['mount']}    smokeCase
    : FOR    ${pwd}    IN    @{pxeTD['vtopPwdR']}
    \    into pxe manage UI
    \    click mount install patch button    ${pxeTD['vtopIsoName']}
    \    input mount install package vtop password    ${pwd}
    \    click mount install package UI mount button
    \    verify lobibox info    ${sysBox['msg12']}
    \    verify install package mount lobibox
    \    verify install package mount success    ${pxeTD['vtopIsoName']}    ${pxeUI['msg6']}

挂载安装包_非vtop的iso
    [Tags]    ${pxeTag['mount']}
    into pxe manage UI
    click mount install patch button    ${pxeTD['nameD']}
    click mount install package UI mount button
    verify lobibox info    ${sysBox['msg12']}
    Wait Until Element Is Not Visible    ${layui_title_ID}
    verify lobibox info    ${sysBox['msg11']}
    verify install package mount success    ${pxeTD['nameD']}    ${pxeUI['msg7']}

挂载安装包_全新安装
    [Tags]    ${pxeTag['mount']}    smokeCase
    into pxe manage UI
    click mount install patch button    ${pxeTD['vtopIsoName']}
    select install package mode    ${pxeTD['newInstall']}
    click mount install package UI mount button
    verify lobibox info    ${sysBox['msg12']}
    verify install package mount lobibox
    verify install package mount success    ${pxeTD['vtopIsoName']}    ${pxeUI['msg6']}

挂载安装包_升级安装
    [Tags]    ${pxeTag['mount']}    smokeCase
    into pxe manage UI
    click mount install patch button    ${pxeTD['vtopIsoName']}
    select install package mode    ${pxeTD['upInstall']}
    click mount install package UI mount button
    verify lobibox info    ${sysBox['msg12']}
    verify install package mount lobibox
    verify install package mount success    ${pxeTD['vtopIsoName']}    ${pxeUI['msg6']}

DHCP服务_启动弹窗信息验证
    [Tags]    ${pxeTag['info']}
    into pxe manage UI
    click start DHCP button
    verify confirm box info    ${pxeUI['msg1']}

DHCP服务_配置异常启动
    [Tags]    ${pxeTag['dhcp']}
    [Setup]    prepar env for start dhcp    ${pxeTD['startIpN']}
    into pxe manage UI
    click start DHCP button
    click confirm box confirm button
    verify lobibox info    ${sysBox['msg8']}
    verify dhcp status by UI    ${pxeUI['status1']}

DHCP服务_配置异常关闭
    [Tags]    ${pxeTag['dhcp']}
    [Setup]    prepar env for shutdown dhcp    ${pxeTD['startIpN']}
    into pxe manage UI
    click shutdown DHCP button
    click confirm box confirm button
    verify lobibox info    ${sysBox['msg9']}
    verify dhcp status by UI    ${pxeUI['status1']}

DHCP服务_配置异常重启
    [Tags]    ${pxeTag['dhcp']}
    [Setup]    prepar env for shutdown dhcp    ${pxeTD['startIpN']}
    into pxe manage UI
    click restart DHCP button
    click confirm box confirm button
    verify lobibox info    ${sysBox['msg10']}
    verify dhcp status by UI    ${pxeUI['status1']}

DHCP服务_正常启动
    [Tags]    ${pxeTag['dhcp']}    smokeCase
    [Setup]    prepar env for start dhcp    ${pxeTD['startIpR']}
    into pxe manage UI
    click start DHCP button
    click confirm box confirm button
    verify lobibox info    ${sysBox['msg13']}
    verify dhcp status by UI    ${pxeUI['status3']}
    verify dhcp service on backstage    running

DHCP服务_关闭DHCP服务弹窗信息验证
    [Tags]    ${pxeTag['info']}
    [Setup]    prepar env for shutdown dhcp    ${pxeTD['startIpR']}
    into pxe manage UI
    click shutdown DHCP button
    verify confirm box info    ${pxeUI['msg2']}

DHCP服务_正常关闭
    [Tags]    ${pxeTag['dhcp']}    smokeCase
    [Setup]    prepar env for shutdown dhcp    ${pxeTD['startIpR']}
    into pxe manage UI
    click shutdown DHCP button
    click confirm box confirm button
    verify lobibox info    ${sysBox['msg14']}
    verify dhcp status by UI    ${pxeUI['status2']}
    verify dhcp service on backstage    dead

DHCP服务_重启DHCP服务弹窗信息验证
    [Tags]    ${pxeTag['info']}
    [Setup]    prepar env for shutdown dhcp    ${pxeTD['startIpR']}
    into pxe manage UI
    click restart DHCP button
    verify confirm box info    ${pxeUI['msg3']}

DHCP服务_正常重启
    [Tags]    ${pxeTag['dhcp']}    smokeCase
    [Setup]    prepar env for shutdown dhcp    ${pxeTD['startIpR']}
    into pxe manage UI
    click restart DHCP button
    click confirm box confirm button
    verify lobibox info    ${sysBox['msg15']}
    verify dhcp status by UI    ${pxeUI['status3']}
    verify dhcp service on backstage    running
