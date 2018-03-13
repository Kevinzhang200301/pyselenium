*** Settings ***
Suite Setup       prepare env for edit network
Suite Teardown    clear env for edit network
Force Tags    ${networkTag['default']}
Resource          ../../Keyword/ResourceManage/NetworkKeywords.robot

*** Test Cases ***
编辑网络界面信息验证
    [Tags]    ${networkTag['info']}
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    verify lay UI title info    ${networkUI['title6']}

编辑网络_名称为空
    [Tags]    ${networkTag['edit']}
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    input network name    ${EMPTY}
    click save button
    verify network name error info    ${networkUI['err1']}

编辑网络_名称正确
    [Tags]    ${networkTag['edit']}    smokeCase
    into network manage UI
    ${nameNew}    Set Variable    ${networkTD['editD']}
    :FOR    ${name}    IN    @{networkTD['nameR']}
    \    click edit network button    ${nameNew}
    \    input network name    ${name}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify network name exist on the UI    ${name}
    \    ${nameNew}    Set Variable    ${name}

新建网络_名称忽略大小写
    [Tags]    ${networkTag['edit']}
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    ${upper}    Convert To Uppercase    ${networkTD['srcName'][1]}
    input network name    ${upper}
    input network start ip    ${networkTD['startIpD']}
    click save button
    verify network name error info    ${networkUI['err14']}

编辑网络_名称重复
    [Tags]    ${networkTag['edit']}
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    input network name    ${networkTD['del']}
    click save button
    verify network name error info    ${networkUI['err14']}

编辑网络_开始地址为空
    [Tags]    ${networkTag['edit']}
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    input network start ip    ${EMPTY}
    click save button
    verify network start ip error info    ${networkUI['err2']}

编辑网络_开始地址格式不对
    [Tags]    ${networkTag['edit']}
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    : FOR    ${ip}    IN    @{networkTD['IpE']}
    \    input network start ip    ${ip}
    \    click save button
    \    Run Keyword And Continue On Failure    verify network start ip error info    ${networkUI['err3']}

编辑网络_开始地址正确
    [Tags]    ${networkTag['edit']}    smokeCase
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    input network start ip    ${networkTD['startIpR']}
    click save button    True
    verify lobibox info
    verify network start ip on the UI    ${networkTD['nameD']}    ${networkTD['startIpR']}

编辑网络_结束地址为空
    [Tags]    ${networkTag['edit']}
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    input network end ip    ${EMPTY}
    click save button
    verify network end ip error info    ${networkUI['err4']}

编辑网络_结束地址格式不对
    [Tags]    ${networkTag['edit']}
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    : FOR    ${ip}    IN    @{networkTD['IpE']}
    \    input network end ip    ${ip}
    \    click save button
    \    Run Keyword And Continue On Failure    verify network end ip error info    ${networkUI['err3']}

编辑网络_结束地址等于开始地址
    [Tags]    ${networkTag['edit']}
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    input network start ip    ${networkTD['startIpD']}
    input network end ip    ${networkTD['startIpD']}
    click save button
    verify network end ip error info    ${networkUI['err5']}

编辑网络_结束地址小于开始地址
    [Tags]    ${networkTag['edit']}
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    input network start ip    ${networkTD['endIpD']}
    input network end ip    ${networkTD['startIpD']}
    click save button
    verify network end ip error info    ${networkUI['err6']}

编辑网络_结束地址正确
    [Tags]    ${networkTag['edit']}    smokeCase
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    input network end ip    ${networkTD['endIpR']}
    click save button    True
    verify lobibox info
    verify network end ip on the UI    ${networkTD['nameD']}    ${networkTD['endIpR']}

编辑网络_子网掩码为空
    [Tags]    ${networkTag['edit']}
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    input network netmask    ${EMPTY}
    click save button
    verify network netmask error info    ${networkUI['err7']}

编辑网络_子网掩码格式错误
    [Tags]    ${networkTag['edit']}
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    : FOR    ${mask}    IN    @{networkTD['maskE']}
    \    input network netmask    ${mask}
    \    click save button
    \    Run Keyword And Continue On Failure    verify network netmask error info    ${networkUI['err8']}

编辑网络_子网掩码正确
    [Tags]    ${networkTag['edit']}    smokeCase
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    input network netmask    ${networkTD['maskR']}
    click save button    True
    verify lobibox info
    verify network netmask on the UI    ${networkTD['nameD']}    ${networkTD['maskR']}

编辑网络_网关为空
    [Tags]    ${networkTag['edit']}
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    input network gateway    ${EMPTY}
    click save button
    verify network gateway error info    ${networkUI['err9']}

编辑网络_网关格式异常
    [Tags]    ${networkTag['edit']}
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    : FOR    ${gw}    IN    @{networkTD['IpE']}
    \    input network gateway    ${gw}
    \    click save button
    \    Run Keyword And Continue On Failure    verify network gateway error info    ${networkUI['err10']}

编辑网络_网关正确
    [Tags]    ${networkTag['edit']}    smokeCase
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    input network gateway    ${networkTD['gatewayR']}
    click save button    True
    verify lobibox info
    verify network gateway on the UI    ${networkTD['nameD']}    ${networkTD['gatewayR']}

编辑网络_DNS服务器为空
    [Tags]    ${networkTag['edit']}
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    input network first DNS    ${EMPTY}
    click save button
    verify network first DNS error info    ${networkUI['err11']}

编辑网络_DNS服务器格式错误
    [Tags]    ${networkTag['edit']}
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    : FOR    ${dns1}    IN    @{networkTD['IpE']}
    \    input network first DNS    ${dns1}
    \    click save button
    \    Run Keyword And Continue On Failure    verify network first DNS error info    ${networkUI['err12']}

编辑网络_DNS服务器正确
    [Tags]    ${networkTag['edit']}    smokeCase
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    input network first DNS    ${networkTD['dns1R']}
    click save button    True
    verify lobibox info
    verify network dns1 on the UI    ${networkTD['nameD']}    ${networkTD['dns1R']}

编辑网络_备用DNS服务器格式错误
    [Tags]    ${networkTag['edit']}
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    : FOR    ${dns2}    IN    @{networkTD['IpE']}
    \    input network second DNS    ${dns2}
    \    click save button
    \    Run Keyword And Continue On Failure    verify network second DNS error info    ${networkUI['err13']}

编辑网络_备用DNS服务器正确
    [Tags]    ${networkTag['edit']}    smokeCase
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    input network second DNS    ${networkTD['dns2D']}
    click save button    True
    verify lobibox info
    verify network dns2 on the UI    ${networkTD['nameD']}    ${networkTD['dns2D']}

编辑网络_输入说明
    [Tags]    ${networkTag['edit']}    smokeCase
    into network manage UI
    click edit network button    ${networkTD['nameD']}
    input network description    ${networkTD['des']}
    click save button    True
    verify lobibox info

搜索网络_不输入任何值
    [Tags]    ${networkTag['search']}
    into network manage UI
    ${num}    get current table record number
    input search network name    ${EMPTY}
    click search button
    verify table records current page    ${num}

搜索网络_不存在的网络
    [Tags]    ${networkTag['search']}
    into network manage UI
    : FOR    ${name}    IN    @{searchNoName}
    \    input search network name    ${name}
    \    click search button
    \    Run Keyword And Continue On Failure    verify table records current page    2

搜索网络_已存在的网络
    [Tags]    ${networkTag['search']}
    into network manage UI
    input search network name    ${networkTD['srcName'][1]}
    click search button
    verify table records current page    3

搜索网络_已存在网络的部分字段
    [Tags]    ${networkTag['search']}
    into network manage UI
    ${len}    Get Length    ${networkTD['srcName']}
    ${len}    Convert To Integer    ${len}
    input search network name    ${networkTD['srcName'][0]}
    click search button
    verify table records current page    ${len+2}

删除网络_弹窗信息验证
    [Tags]    ${networkTag['info']}
    into network manage UI
    click delete network button    ${networkTD['del']}
    verify confirm box info    ${networkUI['msg1']}

删除网络_取消
    [Tags]    ${networkTag['del']}
    into network manage UI
    click delete network button    ${networkTD['del']}
    click confirm box cancel button
    verify confirm not exist

删除网络_已分配给模板
    [Tags]    ${networkTag['del']}
    [Setup]    create right template by UI    ${defaultNameTD}1    vhdName=${vhdNameP}    network=${networkTD['nameD']}
    into network manage UI
    click delete network button    ${networkTD['nameD']}
    click confirm box confirm button
    verify lobibox info    ${resBox['msg1']}

删除网络_确定
    [Tags]    ${networkTag['del']}    smokeCase
    into network manage UI
    click delete network button    ${networkTD['del']}
    click confirm box confirm button
    verify lobibox info    ${resBox['msg5']}
    ${status}    Run Keyword And Return Status    verify network name exist on the UI    ${deviceTD['del']}
    Should Be Equal As Strings    ${status}    False
