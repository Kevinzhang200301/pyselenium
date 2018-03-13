*** Settings ***
Suite Setup       login by admin
Suite Teardown    close browser and kill chrome process
Force Tags      ${ifcfgTag['default']}
Resource          ../../Keyword/SystemManage/NetworkManageKeywords.robot

*** Test Cases ***
网络管理界面信息验证
    [Tags]    ${ifcfgTag['info']}
    [Setup]    create right network card by UI    ${ifcfgTD['vlanD']}1
    into vc network manage UI
    verify network manage UI table info
    verify network manage UI oter info
    [Teardown]    delete all network card by UI

添加网卡界面信息验证
    [Tags]    ${ifcfgTag['info']}
    into vc network manage UI
    click add network card button
    verify add network card UI form info
    verify lay UI title info    ${ifcfgUI['title8']}

添加网卡_VLAN号为空
    [Tags]    ${ifcfgTag['create']}
    into vc network manage UI
    click add network card button
    input network card VLAN    ${EMPTY}
    click save button
    verify lobibox info    ${sysBox['msg18']}

添加网卡_VLAN号不在1~4094间的正数
    [Tags]    ${ifcfgTag['create']}
    into vc network manage UI
    click add network card button
    : FOR    ${vlan}    IN    @{ifcfgTD['vlanE1']}
    \    Unselect Frame
    \    Select Frame    ${layui_iframe_ID}
    \    input network card VLAN    ${vlan}
    \    click save button
    \    Run Keyword And Continue On Failure    verify lobibox info    ${sysBox['msg19']}

添加网卡_VLAN号不是正数
    [Tags]    ${ifcfgTag['create']}
    into vc network manage UI
    click add network card button
    : FOR    ${vlan}    IN    @{ifcfgTD['vlanE2']}
    \    Unselect Frame
    \    Select Frame    ${layui_iframe_ID}
    \    input network card VLAN    ${vlan}
    \    click save button
    \    Run Keyword And Continue On Failure    verify lobibox info    ${sysBox['msg20']}

添加网卡_VLAN号重复
    [Tags]    ${ifcfgTag['create']}
    [Setup]    create right network card by UI    ${ifcfgTD['vlanD']}2
    into vc network manage UI
    click add network card button
    input network card VLAN    ${ifcfgTD['vlanD']}2
    input network card IP    ${ifcfgTD['ipD']}
    input network card gateway    ${ifcfgTD['gwD']}
    click save button
    verify lobibox info    ${sysBox['msg30']}
    [Teardown]    delete all network card by UI

添加网卡_VLAN号正确
    [Tags]    ${ifcfgTag['create']}    smokeCase
    : FOR    ${i}    IN    @{ifcfgTD['vlanR']}
    \    into vc network manage UI
    \    click add network card button
    \    input network card VLAN    ${i}
    \    input network card IP    ${ifcfgTD['ipD']}
    \    input network card gateway    ${ifcfgTD['gwD']}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info    ${sysBox['msg26']}
    \    Run Keyword And Continue On Failure    verify network card vlan on the UI    vlan${i}    ${i}
    [Teardown]    delete all network card by UI

添加网卡_ONBOOT正确
    [Tags]    ${ifcfgTag['create']}    smokeCase
    ${len}    Get Length    ${ifcfgTD['onboot']}
    : FOR    ${i}    IN RANGE    ${len}
    \    into vc network manage UI
    \    click add network card button
    \    input network card VLAN    10${i}
    \    select onboot status    ${ifcfgTD['onboot'][${i}]}
    \    input network card IP    ${ifcfgTD['ipD']}
    \    input network card gateway    ${ifcfgTD['gwD']}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info    ${sysBox['msg26']}
    \    verify network card onboot status on the UI    vlan10${i}    ${ifcfgTD['onboot'][${i}]}
    [Teardown]    delete all network card by UI

添加网卡_IP地址为空
    [Tags]    ${ifcfgTag['create']}
    into vc network manage UI
    click add network card button
    input network card VLAN    ${ifcfgTD['vlanD']}
    input network card IP    ${EMPTY}
    click save button
    verify lobibox info    ${sysBox['msg21']}

添加网卡_IP地址格式错误
    [Tags]    ${ifcfgTag['create']}
    into vc network manage UI
    click add network card button
    input network card VLAN    ${ifcfgTD['vlanD']}
    : FOR    ${ip}    IN    @{ifcfgTD['ipE']}
    \    Unselect Frame
    \    Select Frame    ${layui_iframe_ID}
    \    input network card IP    ${ip}
    \    click save button
    \    Run Keyword And Continue On Failure    verify lobibox info    ${sysBox['msg22']}

添加网卡_IP地址正确
    [Tags]    ${ifcfgTag['create']}    smokeCase
    into vc network manage UI
    click add network card button
    input network card VLAN    ${ifcfgTD['vlanD']}
    input network card IP    ${ifcfgTD['ipR']}
    input network card gateway    ${ifcfgTD['gwD']}
    click save button    True
    Wait Until Element Is Visible    ${lobibox_body_ID}    
    verify network card IP on the UI    vlan${ifcfgTD['vlanD']}    ${ifcfgTD['ipR']}
    [Teardown]    delete all network card by UI

添加网卡_子网掩码
    [Tags]    ${ifcfgTag['create']}    smokeCase
    ${len}    Get Length    ${ifcfgTD['netmask']}
    : FOR    ${i}    IN RANGE    ${len}
    \    into vc network manage UI
    \    click add network card button
    \    input network card VLAN    100${i}
    \    input network card IP    ${ifcfgTD['ipD']}
    \    select netmask    ${ifcfgTD['netmask'][${i}]}
    \    input network card gateway    ${ifcfgTD['gwD']}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info    ${sysBox['msg26']}
    \    verify network card netmask on the UI    vlan100${i}    ${ifcfgTD['netmask'][${i}]}
    [Teardown]    delete all network card by UI

添加网卡_网关为空
    [Tags]    ${ifcfgTag['create']}
    into vc network manage UI
    click add network card button
    input network card VLAN    ${ifcfgTD['vlanD']}
    input network card IP    ${ifcfgTD['ipD']}
    input network card gateway    ${EMPTY}
    click save button
    verify lobibox info    ${sysBox['msg23']}

添加网卡_网关格式错误
    [Tags]    ${ifcfgTag['create']}
    into vc network manage UI
    click add network card button
    input network card VLAN    ${ifcfgTD['vlanD']}
    input network card IP    ${ifcfgTD['ipD']}
    : FOR    ${gw}    IN    @{ifcfgTD['ipE']}
    \    Unselect Frame
    \    Select Frame    ${layui_iframe_ID}
    \    input network card gateway    ${gw}
    \    click save button
    \    Run Keyword And Continue On Failure    verify lobibox info    ${sysBox['msg24']}
 
添加网卡_网关正确
    [Tags]    ${ifcfgTag['create']}    smokeCase
    into vc network manage UI
    click add network card button
    input network card VLAN    ${ifcfgTD['vlanD']}
    input network card IP    ${ifcfgTD['ipD']}
    input network card gateway    ${ifcfgTD['gwR']}
    click save button    True
    Wait Until Element Is Visible    ${lobibox_body_ID}
    [Teardown]    delete all network card by UI
