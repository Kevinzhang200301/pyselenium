*** Settings ***
Resource          ../../ElementLocators/SystemManageElementID.robot
Resource          ../PublicKeywords.robot
Variables         ../../TestData/SystemManage.py

*** Keywords ***
clear env for edit network card
    [Documentation]    清空编辑网卡环境：1.删除网络；2.关闭浏览器
    delete all network card by UI
    close browser and kill chrome process

click add network card button
    [Documentation]    在网络管理界面点击添加网卡按钮
    Click Element    ${ifcfg_add_button_ID}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${layui_title2_ID}

click delete network card button
    [Arguments]    ${cardName}
    [Documentation]    点击删除网卡按钮
    ...    参数：网卡名称
    Click Element    //a[contains(@onclick,"delIfcfg('${cardName}')")]

click down network card button
    [Arguments]    ${cardName}
    [Documentation]    点击启用网卡按钮
    ...    参数：网卡名称
    Click Element    //a[contains(@onclick,"downIfcfg('${cardName}')")]

click edit network card button
    [Arguments]    ${cardName}
    [Documentation]    点击编辑网卡按钮
    ...    参数：网卡名称
    Click Element    //a[contains(@onclick,"editIfcfg('${cardName}')")]
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${layui_title2_ID}

click up network card button
    [Arguments]    ${cardName}
    [Documentation]    点击启用网卡按钮
    ...    参数：网卡名称
    Click Element    //a[contains(@onclick,"upIfcfg('${cardName}')")]

create right network card by UI
    [Arguments]    ${vlan}    ${boot}=open
    [Documentation]    在界面上创建正确的网卡
    ...    参数：网卡名称
    into vc network manage UI
    click add network card button
    input network card VLAN    ${vlan}
    Run Keyword If    '${boot}'!='open'    select onboot status    ${ifcfgTD['onboot'][1]}
    input network card IP    ${ifcfgTD['ipD']}
    input network card gateway    ${ifcfgTD['gwD']}
    click save button    True
    Wait Until Element Is Visible    ${lobibox_body_ID}    
    verify network card name on the UI    vlan${vlan}

delete all network card by UI
    [Documentation]    在网络管理界面删除所有的网卡
    into vc network manage UI
    ${len}    get current table record number    ${public_table_ID}
    : FOR    ${i}    IN RANGE    ${len}
    \    ${element}    Get Webelement    //a[contains(@onclick,'delIfcfg')]
    \    Wait Until Element Is Enabled    ${element}
    \    Click Element    ${element}
    \    click confirm box confirm button
    \    Select Frame    ${ifcfg_manage_iframe_ID}

input network card IP
    [Arguments]    ${ip}
    [Documentation]    输入网卡IP
    ...    参数：IP地址
    Clear Element Text    ${ifcfg_add_ip_input_ID}
    Input Text    ${ifcfg_add_ip_input_ID}    ${ip}
    Sleep    ${inputSleep}

input network card VLAN
    [Arguments]    ${vlanNum}
    [Documentation]    输入网卡VLAN
    ...    参数：vlan号
    Clear Element Text    ${ifcfg_add_vlanNum_input_ID}
    Input Text    ${ifcfg_add_vlanNum_input_ID}    ${vlanNum}
    Sleep    ${inputSleep}

input network card gateway
    [Arguments]    ${gw}
    [Documentation]    输入网卡IP
    ...    参数：网卡网关
    Clear Element Text    ${ifcfg_add_gw_input_ID}
    Input Text    ${ifcfg_add_gw_input_ID}    ${gw}
    Sleep    ${inputSleep}

input network card name
    [Arguments]    ${cardName}
    [Documentation]    输入网卡名称
    ...    参数：网卡名称
    Clear Element Text    ${ifcfg_add_name_input_ID}
    Input Text    ${ifcfg_add_name_input_ID}    ${cardName}
    Sleep    ${inputSleep}

into vc network manage UI
    [Documentation]    进入到网络管理界面
    refresh page
    Wait Until Element Is Enabled    ${system_manage_menu_ID}
    Click Element    ${system_manage_menu_ID}
    Wait Until Element Is Visible    ${ifcfg_menu_ID}
    Click Element    ${ifcfg_menu_ID}
    Wait Until Element Is Visible    ${ifcfg_manage_UI_ID}
    Select Frame    ${ifcfg_manage_iframe_ID}
    Wait Until Element Is Visible    ${ifcfg_add_button_ID}

prepare env for edit network card
    [Documentation]    为测试编辑网卡准备环境：1.admin用户登录；2.创建网卡vlan
    login by admin
    create right network card by UI    ${ifcfgTD['vlanD']}
    create right network card by UI    ${ifcfgTD['del']}
    create right network card by UI    ${ifcfgTD['open']}
    create right network card by UI    ${ifcfgTD['stop']}    boot=stop

select netmask
    [Arguments]    ${netmask}
    [Documentation]    在添加网卡界面选择子网掩码
    ...    参数：子网掩码
    Select From List By Label    ${ifcfg_add_mask_select_ID}    ${netmask}
    Sleep    ${selectSleep}
    List Selection Should Be    ${ifcfg_add_mask_select_ID}    ${SPACE}${netmask}

select onboot status
    [Arguments]    ${status}
    [Documentation]    在添加网卡界面选择ONBOOT状态
    ...    参数：ONBOOT的状态
    Select From List By Label    ${ifcfg_add_noboot_select_ID}    ${status}
    Sleep    ${selectSleep}
    List Selection Should Be    ${ifcfg_add_noboot_select_ID}    ${SPACE}${status}${SPACE}

select physical card
    [Arguments]    ${cardName}
    [Documentation]    在添加网卡界面选择物理网卡
    ...    参数：物理网卡
    Select From List By Label    ${ifcfg_add_card_select_ID}    ${cardName}
    Sleep    ${selectSleep}
    List Selection Should Be    ${ifcfg_add_card_select_ID}    ${cardName}

verify add network card UI form info
    [Documentation]    添加网卡界面form信息验证
    verify same element text by UI    ${ifcfg_add_label_ID}    @{ifcfgUI['labelL']}
    ${selectL2}    Get List Items    ${ifcfg_add_noboot_select_ID}
    ${selectL3}    Get List Items    ${ifcfg_add_mask_select_ID}
    ${txt1}    Get List Items    ${ifcfg_add_card_select_ID}
    Should Not Be Empty    ${txt1}
    : FOR    ${txt2}    IN    @{selectL2}
    \    ${txt2}    Strip String    ${txt2}
    \    Run Keyword And Continue On Failure    List Should Contain Value    ${ifcfgUI['onbootL']}    ${txt2}
    : FOR    ${txt3}    IN    @{selectL3}
    \    ${txt3}    Strip String    ${txt3}
    \    List Should Contain Value    ${ifcfgUI['netmaskL']}    ${txt3}

verify network card IP on the UI
    [Arguments]    ${cardName}    ${ip}
    [Documentation]    网络管理界面验证某网卡IP地址
    ...    参数：1.网卡名称；2.IP地址
    into vc network manage UI
    verify element text    //a[contains(@onclick,"editIfcfg('${cardName}')")]/../../td[6]    ${ip}

verify network card current status on the UI
    [Arguments]    ${cardName}    ${status}
    [Documentation]    网络管理界面验证某网卡当前状态
    ...    参数：1.网卡名称；2.网卡状态
    into vc network manage UI
    verify element text    //a[contains(@onclick,"editIfcfg('${cardName}')")]/../../td[5]    ${status}

verify network card name on the UI
    [Arguments]    ${cardName}
    [Documentation]    网络界面验证某网卡名称
    ...    参数：网卡名称；
    into vc network manage UI
    Table Column Should Contain    ${public_table_ID}    1    ${cardName}

verify network card netmask on the UI
    [Arguments]    ${cardName}    ${netmask}
    [Documentation]    网络管理界面验证某网卡子网掩码
    ...    参数：1.网卡名称；2.子网掩码
    into vc network manage UI
    Element Should Contain    //a[contains(@onclick,"editIfcfg('${cardName}')")]/../../td[7]    ${netmask}

verify network card onboot status on the UI
    [Arguments]    ${cardName}    ${status}
    [Documentation]    网络管理界面验证某网卡ONBOOT信息
    ...    参数：1.网卡名称；2.ONBOOT状态
    into vc network manage UI
    verify element text    //a[contains(@onclick,"editIfcfg('${cardName}')")]/../../td[4]    ${status}

verify network card physical card on the UI
    [Arguments]    ${cardName}    ${physicalCard}
    [Documentation]    网络管理界面验证某网卡物理网卡信息
    ...    参数：1.网卡名称；2.物理网络信息
    into vc network manage UI
    verify element text    //a[contains(@onclick,"editIfcfg('${cardName}')")]/../../td[3]    ${physicalCard}

verify network card vlan on the UI
    [Arguments]    ${cardName}    ${vlan}
    [Documentation]    网络管理界面验证某网卡vlan
    ...    参数：1.网卡名称；2.vlan号
    into vc network manage UI
    verify element text    //a[contains(@onclick,"editIfcfg('${cardName}')")]/../../td[2]    ${vlan}

verify network manage UI oter info
    [Documentation]    网络网络界面其他信息
    Element Should Be Visible    //input[@value='${ifcfgUI['button1']}']
    Element Should Be Visible    //input[@title='${ifcfgUI['title3']}']
    verify element text    ${public_manage_title_ID}    ${ifcfgUI['title2']}
    Unselect Frame
    verify element text    ${ifcfg_tab_ID}    ${ifcfgUI['title1']}

verify network manage UI table info
    [Documentation]    网络管理界面table信息验证
    verify same element text by UI    ${public_table_head}    @{ifcfgUI['tableH']}
    Element Should Be Visible    //a[@title='${ifcfgUI['title4']}']
    Element Should Be Visible    //a[@title='${ifcfgUI['title5']}']
    Element Should Be Visible    //a[@title='${ifcfgUI['title6']}']
    Element Should Be Visible    //a[@title='${ifcfgUI['title7']}']
