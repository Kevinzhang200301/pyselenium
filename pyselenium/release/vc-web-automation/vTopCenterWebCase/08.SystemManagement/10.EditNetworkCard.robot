*** Settings ***
Suite Setup       prepare env for edit network card
Suite Teardown    clear env for edit network card
Force Tags    ${ifcfgTag['default']}
Resource          ../../Keyword/SystemManage/NetworkManageKeywords.robot

*** Test Cases ***
编辑网卡界面信息验证
    [Tags]    ${ifcfgTag['info']}
    into vc network manage UI
    click edit network card button    vlan${ifcfgTD['vlanD']}
    verify lay UI title info    ${ifcfgUI['title4']}

编辑网卡_VLAN号为空
    [Tags]    ${ifcfgTag['edit']}
    into vc network manage UI
    click edit network card button    vlan${ifcfgTD['vlanD']}
    input network card VLAN    ${EMPTY}
    click save button
    verify lobibox info    ${sysBox['msg18']}

编辑网卡_VLAN号不在1~4094间的正数
    [Tags]    ${ifcfgTag['edit']}
    into vc network manage UI
    click edit network card button    vlan${ifcfgTD['vlanD']}
    : FOR    ${vlan}    IN    @{ifcfgTD['vlanE1']}
    \    Unselect Frame
    \    Select Frame    ${layui_iframe_ID}
    \    input network card VLAN    ${vlan}
    \    click save button
    \    Run Keyword And Continue On Failure    verify lobibox info    ${sysBox['msg19']}

编辑网卡_VLAN号不是正数
    [Tags]    ${ifcfgTag['edit']}
    into vc network manage UI
    click edit network card button    vlan${ifcfgTD['vlanD']}
    : FOR    ${vlan}    IN    @{ifcfgTD['vlanE2']}
    \    Unselect Frame
    \    Select Frame    ${layui_iframe_ID}
    \    input network card VLAN    ${vlan}
    \    click save button
    \    Run Keyword And Continue On Failure    verify lobibox info    ${sysBox['msg20']}

编辑网卡_VLAN号正确
    [Tags]    ${ifcfgTag['edit']}    smokeCase
    : FOR    ${vlan}    IN    @{ifcfgTD['vlanR']}
    \    into vc network manage UI
    \    click edit network card button    vlan${ifcfgTD['vlanD']}
    \    input network card VLAN    ${vlan}
    \    click save button    True
    \    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${lobibox_body_ID}
    \    Run Keyword And Continue On Failure    verify network card vlan on the UI    vlan${ifcfgTD['vlanD']}    ${vlan}

编辑网卡_ONBOOT正确
    [Tags]    ${ifcfgTag['edit']}    smokeCase
    : FOR    ${status}    IN    @{ifcfgTD['onboot']}
    \    into vc network manage UI
    \    click edit network card button    vlan${ifcfgTD['vlanD']}
    \    select onboot status    ${status}
    \    click save button    True
    \    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${lobibox_body_ID}
    \    verify network card onboot status on the UI    vlan${ifcfgTD['vlanD']}    ${status}

编辑网卡_IP地址为空
    [Tags]    ${ifcfgTag['edit']}
    into vc network manage UI
    click edit network card button    vlan${ifcfgTD['vlanD']}
    input network card IP    ${EMPTY}
    click save button
    verify lobibox info    ${sysBox['msg21']}

编辑网卡_IP地址格式错误
    [Tags]    ${ifcfgTag['edit']}
    into vc network manage UI
    click edit network card button    vlan${ifcfgTD['vlanD']}
    : FOR    ${ip}    IN    @{ifcfgTD['ipE']}
    \    Unselect Frame
    \    Select Frame    ${layui_iframe_ID}
    \    input network card IP    ${ip}
    \    click save button
    \    Run Keyword And Continue On Failure    verify lobibox info    ${sysBox['msg22']}

编辑网卡_IP地址正确
    [Tags]    ${ifcfgTag['edit']}    smokeCase
    into vc network manage UI
    click edit network card button    vlan${ifcfgTD['vlanD']}
    input network card IP    ${ifcfgTD['ipR']}
    click save button    True
    Wait Until Element Is Visible    ${lobibox_body_ID}
    verify network card IP on the UI    vlan${ifcfgTD['vlanD']}    ${ifcfgTD['ipR']}

编辑网卡_子网掩码
    [Tags]    ${ifcfgTag['edit']}    smokeCase
    : FOR    ${mask}    IN    @{ifcfgTD['netmask']}
    \    into vc network manage UI
    \    click edit network card button    vlan${ifcfgTD['vlanD']}
    \    select netmask    ${mask}
    \    click save button    True
    \    Run Keyword And Continue On Failure    Wait Until Element Is Visible    ${lobibox_body_ID}
    \    verify network card netmask on the UI    vlan${ifcfgTD['vlanD']}    ${mask}

编辑网卡_网关为空
    [Tags]    ${ifcfgTag['edit']}
    into vc network manage UI
    click edit network card button    vlan${ifcfgTD['vlanD']}
    input network card gateway    ${EMPTY}
    click save button
    verify lobibox info    ${sysBox['msg23']}

编辑网卡_网关格式错误
    [Tags]    ${ifcfgTag['edit']}
    into vc network manage UI
    click edit network card button    vlan${ifcfgTD['vlanD']}
    : FOR    ${gw}    IN    @{ifcfgTD['ipE']}
    \    Unselect Frame
    \    Select Frame    ${layui_iframe_ID}
    \    input network card gateway    ${gw}
    \    click save button
    \    Run Keyword And Continue On Failure    verify lobibox info    ${sysBox['msg24']}

编辑网卡_网关正确
    [Tags]    ${ifcfgTag['edit']}    smokeCase
    into vc network manage UI
    click edit network card button    vlan${ifcfgTD['vlanD']}
    input network card gateway    ${ifcfgTD['gwR']}
    click save button    True
    Wait Until Element Is Visible    ${lobibox_body_ID}

删除网卡_弹窗信息验证
    [Tags]    ${ifcfgTag['info']}
    into vc network manage UI
    click delete network card button    vlan${ifcfgTD['del']}
    verify confirm box info    ${ifcfgUI['msg1']}

删除网卡_取消
    [Tags]    ${ifcfgTag['del']}
    into vc network manage UI
    click delete network card button    vlan${ifcfgTD['del']}
    click confirm box cancel button
    verify confirm not exist

删除网卡_确定
    [Tags]    ${ifcfgTag['del']}
    into vc network manage UI
    click delete network card button    vlan${ifcfgTD['del']}
    click confirm box confirm button
    verify lobibox info    ${sysBox['msg27']}
    ${status}    Run Keyword And Return Status    verify network card name on the UI    vlan${ifcfgTD['del']}
    Should Be Equal As Strings    ${status}    False

启用网卡_弹窗信息验证
    [Tags]    ${ifcfgTag['info']}
    into vc network manage UI
    click up network card button    vlan${ifcfgTD['stop']}
    verify confirm box info    ${ifcfgUI['msg2']}

启用网卡_取消
    [Tags]    ${ifcfgTag['open']}
    into vc network manage UI
    click up network card button    vlan${ifcfgTD['stop']}
    click confirm box cancel button
    verify confirm not exist

启用网卡_确定
    [Tags]    ${ifcfgTag['open']}
    into vc network manage UI
    click up network card button    vlan${ifcfgTD['stop']}
    click confirm box confirm button
    verify lobibox info    ${sysBox['msg28']}
    verify network card current status on the UI    vlan${ifcfgTD['stop']}    ${ifcfgUI['up']}

禁用网卡_弹窗信息验证
    [Tags]    ${ifcfgTag['info']}
    into vc network manage UI
    click down network card button    vlan${ifcfgTD['open']}
    verify confirm box info    ${ifcfgUI['msg3']}

禁用网卡_取消
    [Tags]    ${ifcfgTag['stop']}
    into vc network manage UI
    click down network card button    vlan${ifcfgTD['open']}
    click confirm box cancel button
    verify confirm not exist

禁用网卡_确定
    [Tags]    ${ifcfgTag['stop']}
    into vc network manage UI
    click down network card button    vlan${ifcfgTD['open']}
    click confirm box confirm button
    verify lobibox info    ${sysBox['msg29']}
    verify network card current status on the UI    vlan${ifcfgTD['open']}    ${ifcfgUI['down']}
