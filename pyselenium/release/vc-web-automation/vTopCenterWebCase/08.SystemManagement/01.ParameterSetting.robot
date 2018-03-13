*** Settings ***
Suite Setup    login by admin
Suite Teardown    Run Keywords    restore default parameter value by database    close browser and kill chrome process
Force Tags    ${parameterTag['default']}
Resource    ../../Keyword/SystemManage/ParameterSettingKeywords.robot

*** Test Cases ***
参数设置界面信息验证
    [Tags]    ${parameterTag['info']}
    into parameter setting manage UI
    verify parameter setting manage UI info

上级vTop Center地址编辑页面信息验证
    [Tags]    ${parameterTag['info']}
    into parameter setting manage UI
    click Upper vTop Center address edit button
    verify parameter edit UI info    ${parameterUI['nameL'][1]}    ${parameterUI['valueL'][1]}
    
分级管理地址编辑页面信息验证
    [Tags]    ${parameterTag['info']}
    into parameter setting manage UI
    click hierarchical manage address edit button
    verify parameter edit UI info    ${parameterUI['nameL'][2]}    ${parameterUI['valueL'][2]}
    
分级管理密钥编辑页面信息验证
    [Tags]    ${parameterTag['info']}
    into parameter setting manage UI
    click hierarchical manage key edit button
    verify parameter edit UI info    ${parameterUI['nameL'][3]}    ${parameterUI['valueL'][3]}
    
域名服务器IP编辑页面信息验证
    [Tags]    ${parameterTag['info']}
    into parameter setting manage UI
    click DNS server edit button
    verify parameter edit UI info    ${parameterUI['nameL'][4]}    ${parameterUI['valueL'][4]}
    
注册密码编辑页面信息验证
    [Tags]    ${parameterTag['info']}
    into parameter setting manage UI
    click registered password edit button
    verify parameter edit UI info    ${parameterUI['nameL'][5]}    ${parameterUI['valueL'][5]}
    
存储池使用百分比告警阈值编辑页面信息验证
    [Tags]    ${parameterTag['info']}
    into parameter setting manage UI
    click pool percentage edit button
    verify parameter edit UI info    ${parameterUI['nameL'][6]}    ${parameterUI['valueL'][6]}
    
存储池剩余大小告警阈值编辑页面信息验证
    [Tags]    ${parameterTag['info']}
    into parameter setting manage UI
    click pool size edit button
    verify parameter edit UI info    ${parameterUI['nameL'][7]}    ${parameterUI['valueL'][7]}
    
主机硬盘使用百分比告警阈值编辑页面信息验证
    [Tags]    ${parameterTag['info']}
    into parameter setting manage UI
    click hard disk percentage edit button
    verify parameter edit UI info    ${parameterUI['nameL'][8]}    ${parameterUI['valueL'][8]}
     
主机硬盘剩余大小告警阈值编辑页面信息验证
    [Tags]    ${parameterTag['info']}
    into parameter setting manage UI
    click hard disk size edit button
    verify parameter edit UI info    ${parameterUI['nameL'][9]}    ${parameterUI['valueL'][9]}
    
上级vTopCenter地址_参数值为空
    into parameter setting manage UI
    click Upper vTop Center address edit button
    input parameter value    ${EMPTY}
    click save button
    verify parameter value error info    ${parameterUI['err1']}
    verify lobibox info    ${sysBox['msg3']}
    
上级vTopCenter地址_参数值错误
    into parameter setting manage UI
    click Upper vTop Center address edit button
    :FOR    ${value}    IN    @{parameterTD['ipE']}
    \    Unselect Frame
    \    Select Frame    ${layui_iframe_ID}
    \    input parameter value    ${value}
    \    click save button
    \    Run Keyword And Continue On Failure    verify lobibox info    ${sysBox['msg2']}

上级vTopCenter地址_参数值正确
    [Tags]    smokeCase
    :FOR    ${i}    IN    @{parameterTD['ipR']}
    \    into parameter setting manage UI
    \    click Upper vTop Center address edit button
    \    input parameter value    ${i}
    \    click save button    True
    \    verify lobibox info
    \    verify parameter value on the UI    2    ${i}

分级管理地址_参数值为空
    into parameter setting manage UI
    click hierarchical manage address edit button
    input parameter value    ${EMPTY}
    click save button
    verify parameter value error info    ${parameterUI['err1']}
    verify lobibox info    ${sysBox['msg3']}

分级管理地址_参数值正确
    [Tags]    smokeCase
    into parameter setting manage UI
    click hierarchical manage address edit button
    input parameter value    ${parameterTD['fenR']}
    click save button    True
    verify lobibox info
    verify parameter value on the UI    3    ${parameterTD['fenR']}

分级管理密钥_参数值为空
    into parameter setting manage UI
    click hierarchical manage key edit button
    input parameter value    ${EMPTY}
    click save button
    verify parameter value error info    ${parameterUI['err1']}
    verify lobibox info    ${sysBox['msg3']}

分级管理密钥_参数值正确
    [Tags]    smokeCase
    into parameter setting manage UI
    click hierarchical manage key edit button
    input parameter value    ${parameterTD['keyR']}
    click save button    True
    verify lobibox info
    verify parameter value on the UI    4    ${parameterTD['keyR']}

域名服务器IP_参数值为空
    into parameter setting manage UI
    click DNS server edit button
    input parameter value    ${EMPTY}
    click save button
    verify parameter value error info    ${parameterUI['err1']}
    verify lobibox info    ${sysBox['msg3']}
    
域名服务器IP_参数值错误
    into parameter setting manage UI
    click DNS server edit button
    :FOR    ${value}    IN    @{parameterTD['dnsE']}
    \    Unselect Frame
    \    Select Frame    ${layui_iframe_ID}
    \    input parameter value    ${value}
    \    click save button
    \    Run Keyword And Continue On Failure    verify lobibox info    ${sysBox['msg4']}

域名服务器IP_参数值正确
    [Tags]    smokeCase
    into parameter setting manage UI
    click DNS server edit button
    input parameter value    ${parameterTD['dnsR']}
    click save button    True
    verify lobibox info
    verify parameter value on the UI    5    ${parameterTD['dnsR']}

注册密码_参数值为空
    into parameter setting manage UI
    click registered password edit button
    input parameter value    ${EMPTY}
    click save button
    verify parameter value error info    ${parameterUI['err1']}
    verify lobibox info    ${sysBox['msg3']}
    
注册密码_参数值错误
    into parameter setting manage UI
    click registered password edit button
    :FOR    ${value}    IN    @{parameterTD['pwdE']}
    \    Unselect Frame
    \    Select Frame    ${layui_iframe_ID}
    \    input parameter value    ${value}
    \    click save button
    \    Run Keyword And Continue On Failure    verify lobibox info    ${sysBox['msg5']}

注册密码_参数值正确
    [Tags]    smokeCase
    :FOR    ${i}    IN    @{parameterTD['pwdR']}
    \    into parameter setting manage UI
    \    click registered password edit button
    \    input parameter value    ${i}
    \    click save button    True
    \    verify lobibox info
    \    verify parameter value on the UI    6    ${i}    

存储池使用百分比告警阈值_参数值为空
    into parameter setting manage UI
    click pool percentage edit button
    input parameter value    ${EMPTY}
    click save button
    verify parameter value error info    ${parameterUI['err1']}
    verify lobibox info    ${sysBox['msg3']}
    
存储池使用百分比告警阈值_参数值错误
    into parameter setting manage UI
    click pool percentage edit button
    :FOR    ${value}    IN    @{parameterTD['percentE']}
    \    Unselect Frame
    \    Select Frame    ${layui_iframe_ID}
    \    input parameter value    ${value}
    \    click save button
    \    Run Keyword And Continue On Failure    verify lobibox info    ${sysBox['msg6']}

存储池使用百分比告警阈值_参数值正确
    [Tags]    smokeCase
    into parameter setting manage UI
    click pool percentage edit button
    input parameter value    ${parameterTD['percentR']}
    click save button    True
    verify lobibox info
    verify parameter value on the UI    7    ${parameterTD['percentR']}    

存储池剩余大小告警阈值_参数值为空
    into parameter setting manage UI
    click pool size edit button
    input parameter value    ${EMPTY}
    click save button
    verify parameter value error info    ${parameterUI['err1']}
    verify lobibox info    ${sysBox['msg3']}
    
存储池剩余大小告警阈值_参数值错误
    into parameter setting manage UI
    click pool size edit button
    :FOR    ${value}    IN    @{parameterTD['sizeE']}
    \    Unselect Frame
    \    Select Frame    ${layui_iframe_ID}
    \    input parameter value    ${value}
    \    click save button
    \    Run Keyword And Continue On Failure    verify lobibox info    ${sysBox['msg7']}

存储池剩余大小告警阈值_参数值正确
    [Tags]    smokeCase
    into parameter setting manage UI
    click pool size edit button
    input parameter value    ${parameterTD['sizeR']}
    click save button    True
    verify lobibox info
    verify parameter value on the UI    8    ${parameterTD['sizeR']}    

主机硬盘使用百分比告警阈值_参数值为空
    into parameter setting manage UI
    click hard disk percentage edit button
    input parameter value    ${EMPTY}
    click save button
    verify parameter value error info    ${parameterUI['err1']}
    verify lobibox info    ${sysBox['msg3']}
    
主机硬盘使用百分比告警阈值_参数值错误
    into parameter setting manage UI
    click hard disk percentage edit button
    :FOR    ${value}    IN    @{parameterTD['percentE']}
    \    Unselect Frame
    \    Select Frame    ${layui_iframe_ID}
    \    input parameter value    ${value}
    \    click save button
    \    Run Keyword And Continue On Failure    verify lobibox info    ${sysBox['msg6']}

主机硬盘使用百分比告警阈值_参数值正确
    [Tags]    smokeCase
    into parameter setting manage UI
    click hard disk percentage edit button
    input parameter value    ${parameterTD['percentR']}
    click save button    True
    verify lobibox info
    verify parameter value on the UI    9    ${parameterTD['percentR']}    

主机硬盘剩余大小告警阈值_参数值为空
    into parameter setting manage UI
    click hard disk size edit button
    input parameter value    ${EMPTY}
    click save button
    verify parameter value error info    ${parameterUI['err1']}
    verify lobibox info    ${sysBox['msg3']}
    
主机硬盘剩余大小告警阈值_参数值错误
    into parameter setting manage UI
    click hard disk size edit button
    :FOR    ${value}    IN    @{parameterTD['sizeE']}
    \    Unselect Frame
    \    Select Frame    ${layui_iframe_ID}
    \    input parameter value    ${value}
    \    click save button
    \    Run Keyword And Continue On Failure    verify lobibox info    ${sysBox['msg7']}

主机硬盘剩余大小告警阈值_参数值正确
    [Tags]    smokeCase
    into parameter setting manage UI
    click hard disk size edit button
    input parameter value    ${parameterTD['sizeR']}
    click save button    True
    verify lobibox info
    verify parameter value on the UI    10    ${parameterTD['sizeR']}    