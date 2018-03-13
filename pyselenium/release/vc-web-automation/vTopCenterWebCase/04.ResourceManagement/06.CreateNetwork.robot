*** Settings ***
Suite Setup    login by admin
Suite Teardown    close browser and kill chrome process
Force Tags    ${networkTag['default']}
Resource    ../../Keyword/ResourceManage/NetworkKeywords.robot

*** Test Cases ***
网络管理界面信息验证
    [Tags]    ${networkTag['info']}
    [Setup]    create right network by UI    ${networkTD['nameD']}1
    into network manage UI
    verify network manage UI info
    [Teardown]    delete all network by UI

新建网络界面信息验证
    [Tags]    ${networkTag['info']}
    into network manage UI
    click create network button
    verify create network UI info

新建网络_名称为空
    [Tags]    ${networkTag['create']}
    into network manage UI
    click create network button
    input network name    ${EMPTY}
    click save button
    verify network name error info    ${networkUI['err1']}

新建网络_名称正确
    [Tags]    ${networkTag['create']}    smokeCase
    into network manage UI
    :FOR    ${name}    IN    @{networkTD['nameR']}
    \    click create network button
    \    input network name    ${name}
    \    input network start ip    ${networkTD['startIpD']}
    \    input network end ip    ${networkTD['endIpD']}
    \    input network netmask    ${networkTD['maskD']}
    \    input network gateway    ${networkTD['gatewayD']}
    \    input network first DNS    ${networkTD['dns1D']}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify network name exist on the UI    ${name}
    [Teardown]    delete all network by UI

新建网络_名称重复
    [Tags]    ${networkTag['create']}
    [Setup]    create right network by UI    ${networkTD['nameD']}2
    into network manage UI
    click create network button
    input network name    ${networkTD['nameD']}2
    input network start ip    ${networkTD['startIpD']}
    input network end ip    ${networkTD['endIpD']}
    input network netmask    ${networkTD['maskD']}
    input network gateway    ${networkTD['gatewayD']}
    input network first DNS    ${networkTD['dns1D']}
    click save button
    verify network name error info    ${networkUI['err14']}
    [Teardown]    delete all network by UI

新建网络_名称忽略大小写
    [Tags]    ${networkTag['create']}
    [Setup]    create right network by UI    ${networkTD['nameD']}3
    into network manage UI
    click create network button
    ${upper}    Convert To Uppercase    ${networkTD['nameD']}3
    input network name    ${upper}
    input network start ip    ${networkTD['startIpD']}
    input network end ip    ${networkTD['endIpD']}
    input network netmask    ${networkTD['maskD']}
    input network gateway    ${networkTD['gatewayD']}
    input network first DNS    ${networkTD['dns1D']}
    click save button
    verify network name error info    ${networkUI['err14']}
    
新建网络_开始地址为空
    [Tags]    ${networkTag['create']}
    into network manage UI
    click create network button
    input network name    ${networkTD['nameD']}4
    input network start ip    ${EMPTY}
    click save button
    verify network start ip error info    ${networkUI['err2']}

新建网络_开始地址格式不对
    [Tags]    ${networkTag['create']}
    into network manage UI
    click create network button
    input network name    ${networkTD['nameD']}5
    :FOR    ${ip}    IN    @{networkTD['IpE']}
    \    input network start ip    ${ip}
    \    click save button
    \    Run Keyword And Continue On Failure    verify network start ip error info    ${networkUI['err3']}

新建网络_开始地址正确
    [Tags]    ${networkTag['create']}    smokeCase
    into network manage UI
    click create network button
    input network name    ${networkTD['nameD']}6
    input network start ip    ${networkTD['startIpD']}
    input network end ip    ${networkTD['endIpD']}
    input network netmask    ${networkTD['maskD']}
    input network gateway    ${networkTD['gatewayD']}
    input network first DNS    ${networkTD['dns1D']}
    click save button    True
    verify lobibox info
    verify network start ip on the UI    ${networkTD['nameD']}6    ${networkTD['startIpD']}
    [Teardown]    delete all network by UI

新建网络_结束地址为空
    [Tags]    ${networkTag['create']}
    into network manage UI
    click create network button
    input network name    ${networkTD['nameD']}7
    input network start ip    ${networkTD['startIpD']}
    input network end ip    ${EMPTY}
    click save button
    verify network end ip error info    ${networkUI['err4']}

新建网络_结束地址格式不对
    [Tags]    ${networkTag['create']}
    into network manage UI
    click create network button
    input network name    ${networkTD['nameD']}8
    input network start ip    ${networkTD['startIpD']}
    :FOR    ${ip}    IN    @{networkTD['IpE']}
    \    input network end ip    ${ip}
    \    click save button
    \    Run Keyword And Continue On Failure    verify network end ip error info    ${networkUI['err3']}

新建网络_结束地址等于开始地址
    [Tags]    ${networkTag['create']}
    into network manage UI
    click create network button
    input network name    ${networkTD['nameD']}9
    input network start ip    ${networkTD['startIpD']}
    input network end ip    ${networkTD['startIpD']}
    click save button
    verify network end ip error info    ${networkUI['err5']}

新建网络_结束地址小于开始地址
    [Tags]    ${networkTag['create']}
    into network manage UI
    click create network button
    input network name    ${networkTD['nameD']}10
    input network start ip    ${networkTD['endIpD']}
    input network end ip    ${networkTD['startIpD']}
    click save button
    verify network end ip error info    ${networkUI['err6']}

新建网络_结束地址正确
    [Tags]    ${networkTag['create']}    smokeCase
    into network manage UI
    click create network button
    input network name    ${networkTD['nameD']}11
    input network start ip    ${networkTD['startIpD']}
    input network end ip    ${networkTD['endIpD']}
    input network netmask    ${networkTD['maskD']}
    input network gateway    ${networkTD['gatewayD']}
    input network first DNS    ${networkTD['dns1D']}
    click save button    True
    verify lobibox info
    verify network end ip on the UI    ${networkTD['nameD']}11    ${networkTD['endIpD']}
    [Teardown]    delete all network by UI

新建网络_子网掩码为空
    [Tags]    ${networkTag['create']}
    into network manage UI
    click create network button
    input network name    ${networkTD['nameD']}12
    input network start ip    ${networkTD['startIpD']}
    input network end ip    ${networkTD['endIpD']}
    input network netmask    ${EMPTY}
    click save button
    verify network netmask error info    ${networkUI['err7']}

新建网络_子网掩码格式错误
    [Tags]    ${networkTag['create']}
    into network manage UI
    click create network button
    input network name    ${networkTD['nameD']}13
    input network start ip    ${networkTD['startIpD']}
    input network end ip    ${networkTD['endIpD']}
    :FOR    ${mask}    IN    @{networkTD['maskE']}
    \    input network netmask    ${mask}
    \    click save button
    \    Run Keyword And Continue On Failure    verify network netmask error info    ${networkUI['err8']}

新建网络_子网掩码正确
    [Tags]    ${networkTag['create']}    smokeCase
    into network manage UI
    click create network button
    input network name    ${networkTD['nameD']}14
    input network start ip    ${networkTD['startIpD']}
    input network end ip    ${networkTD['endIpD']}
    input network netmask    ${networkTD['maskD']}
    input network gateway    ${networkTD['gatewayD']}
    input network first DNS    ${networkTD['dns1D']}
    click save button    True
    verify lobibox info
    verify network netmask on the UI    ${networkTD['nameD']}14    ${networkTD['maskD']}
    [Teardown]    delete all network by UI

新建网络_网关为空
    [Tags]    ${networkTag['create']}
    into network manage UI
    click create network button
    input network name    ${networkTD['nameD']}15
    input network start ip    ${networkTD['startIpD']}
    input network end ip    ${networkTD['endIpD']}
    input network netmask    ${networkTD['maskD']}
    input network gateway    ${EMPTY}
    click save button
    verify network gateway error info    ${networkUI['err9']}

新建网络_网关格式异常
    [Tags]    ${networkTag['create']}
    into network manage UI
    click create network button
    input network name    ${networkTD['nameD']}16
    input network start ip    ${networkTD['startIpD']}
    input network end ip    ${networkTD['endIpD']}
    input network netmask    ${networkTD['maskD']}
    :FOR    ${gw}    IN    @{networkTD['IpE']}
    \    input network gateway    ${gw}
    \    click save button
    \    Run Keyword And Continue On Failure    verify network gateway error info    ${networkUI['err10']}

新建网络_网关正确
    [Tags]    ${networkTag['create']}    smokeCase
    into network manage UI
    click create network button
    input network name    ${networkTD['nameD']}17
    input network start ip    ${networkTD['startIpD']}
    input network end ip    ${networkTD['endIpD']}
    input network netmask    ${networkTD['maskD']}
    input network gateway    ${networkTD['gatewayD']}
    input network first DNS    ${networkTD['dns1D']}
    click save button    True
    verify lobibox info
    verify network gateway on the UI    ${networkTD['nameD']}17    ${networkTD['gatewayD']}
    [Teardown]    delete all network by UI

新建网络_DNS服务器为空
    [Tags]    ${networkTag['create']}
    into network manage UI
    click create network button
    input network name    ${networkTD['nameD']}18
    input network start ip    ${networkTD['startIpD']}
    input network end ip    ${networkTD['endIpD']}
    input network netmask    ${networkTD['maskD']}
    input network gateway    ${networkTD['gatewayD']}
    input network first DNS    ${EMPTY}
    click save button
    verify network first DNS error info    ${networkUI['err11']}

新建网络_DNS服务器格式错误
    [Tags]    ${networkTag['create']}
    into network manage UI
    click create network button
    input network name    ${networkTD['nameD']}19
    input network start ip    ${networkTD['startIpD']}
    input network end ip    ${networkTD['endIpD']}
    input network netmask    ${networkTD['maskD']}
    input network gateway    ${networkTD['gatewayD']}
    :FOR    ${dns1}    IN    @{networkTD['IpE']}
    \    input network first DNS    ${dns1}
    \    click save button
    \    Run Keyword And Continue On Failure    verify network first DNS error info    ${networkUI['err12']}

新建网络_DNS服务器正确
    [Tags]    ${networkTag['create']}    smokeCase
    into network manage UI
    click create network button
    input network name    ${networkTD['nameD']}20
    input network start ip    ${networkTD['startIpD']}
    input network end ip    ${networkTD['endIpD']}
    input network netmask    ${networkTD['maskD']}
    input network gateway    ${networkTD['gatewayD']}
    input network first DNS    ${networkTD['dns1D']}
    click save button    True
    verify lobibox info
    verify network dns1 on the UI    ${networkTD['nameD']}20    ${networkTD['dns1D']}
    [Teardown]    delete all network by UI

新建网络_备用DNS服务器格式错误
    [Tags]    ${networkTag['create']}
    into network manage UI
    click create network button
    input network name    ${networkTD['nameD']}21
    input network start ip    ${networkTD['startIpD']}
    input network end ip    ${networkTD['endIpD']}
    input network netmask    ${networkTD['maskD']}
    input network gateway    ${networkTD['gatewayD']}
    input network first DNS    ${networkTD['dns1D']}
    :FOR    ${dns2}    IN    @{networkTD['IpE']}
    \    input network second DNS    ${dns2}
    \    click save button
    \    Run Keyword And Continue On Failure    verify network second DNS error info    ${networkUI['err13']}

新建网络_备用DNS服务器正确
    [Tags]    ${networkTag['create']}    smokeCase
    into network manage UI
    click create network button
    input network name    ${networkTD['nameD']}22
    input network start ip    ${networkTD['startIpD']}
    input network end ip    ${networkTD['endIpD']}
    input network netmask    ${networkTD['maskD']}
    input network gateway    ${networkTD['gatewayD']}
    input network first DNS    ${networkTD['dns1D']}
    input network second DNS    ${networkTD['dns2D']}
    click save button    True
    verify lobibox info
    verify network dns2 on the UI    ${networkTD['nameD']}22    ${networkTD['dns2D']}
    [Teardown]    delete all network by UI

新建网络_输入说明
    [Tags]    ${networkTag['create']}    smokeCase
    into network manage UI
    click create network button
    input network name    ${networkTD['nameD']}23
    input network start ip    ${networkTD['startIpD']}
    input network end ip    ${networkTD['endIpD']}
    input network netmask    ${networkTD['maskD']}
    input network gateway    ${networkTD['gatewayD']}
    input network first DNS    ${networkTD['dns1D']}
    input network description    ${networkTD['des']}
    click save button    True
    verify lobibox info
    [Teardown]    delete all network by UI