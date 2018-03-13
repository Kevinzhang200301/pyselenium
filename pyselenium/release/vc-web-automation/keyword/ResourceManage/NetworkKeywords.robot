*** Settings ***
Resource          ../PublicKeywords.robot
Resource          ../../ElementLocators/ResourceElementID.robot
Resource          ../../Keyword/ResourceManage/TemplateKeywords.robot
Variables         ../../TestData/ResourceTestData.py

*** Keywords ***
clear env for edit network
    [Documentation]    清空编辑网络测试环境：1.删除模板；2.删除镜像；
    ...    3.删除网络；4.关闭浏览器
    delete all template by UI
    delete all vhd by UI
    delete all network by UI
    close browser and kill chrome process

click create network button
    [Documentation]    点击新建网络按钮
    Click Element    ${net_create_button_ID}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${net_create_name_input_ID}

click delete network button
    [Arguments]    ${netName}
    [Documentation]    点击删除网络按钮
    ...    参数：网络名称
    ${nameId}    get network id by database    ${netName}
    Click Element    //a[contains(@onclick,'deleteNetwork(${nameId})')]

click edit network button
    [Arguments]    ${netName}
    [Documentation]    点击编辑网络按钮
    ...    参数：网络名称
    ${nameId}    get network id by database    ${netName}
    Click Element    //a[contains(@onclick,'editNetwork(${nameId})')]
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${net_create_name_input_ID}

create right network by UI
    [Arguments]    ${netName}
    [Documentation]    正确创建一个网络
    ...    参数：网络名称
    into network manage UI
    click create network button
    input network name    ${netName}
    input network start ip    ${networkTD['startIpD']}
    input network end ip    ${networkTD['endIpD']}
    input network netmask    ${networkTD['maskD']}
    input network gateway    ${networkTD['gatewayD']}
    input network first DNS    ${networkTD['dns1D']}
    click save button    True
    verify network name exist on the UI    ${netName}

delete all network by UI
    [Documentation]    在数据库中删除所有的网络
    into network manage UI
    ${len}    get rows of database table    SELECT id FROM policy_resource_network;
    : FOR    ${i}    IN RANGE    ${len}
    \    ${element}    Get Webelement    //a[contains(@onclick,'deleteNetwork')]
    \    Wait Until Element Is Enabled    ${element}
    \    Click Element    ${element}
    \    click confirm box confirm button
    \    Select Frame    ${net_manage_iframe_ID}

get network id by database
    [Arguments]    ${netName}
    [Documentation]    在数据库中获取网络ID
    ...    参数：网络名称   
    ${nameId}    get return value of the database query
    ...    SELECT id FROM policy_resource_network WHERE network_name='${netName}';
    [Return]    ${nameId}

input network description
    [Arguments]    ${des}
    [Documentation]    输入网络信息说明
    ...    参数：说明信息
    Clear Element Text    ${net_create_des_ID}
    Input Text    ${net_create_des_ID}    ${des}
    Sleep    ${inputSleep}    

input network end ip
    [Arguments]    ${endIP}
    [Documentation]    输入结束地址
    ...    参数：结束的IP地址
    Clear Element Text    ${net_create_ipEnd_input_ID}
    Input Text    ${net_create_ipEnd_input_ID}    ${endIP}
    Sleep    ${inputSleep}

input network first DNS
    [Arguments]    ${dns1}
    [Documentation]    输入DNS服务器(第一个DNS)
    ...    参数：第一个DNS
    Clear Element Text    ${net_create_dns1_input_ID}
    Input Text    ${net_create_dns1_input_ID}    ${dns1}
    Sleep    ${inputSleep}

input network gateway
    [Arguments]    ${gateway}
    [Documentation]    输入网关
    ...    参数：网关
    Clear Element Text    ${net_create_gateway_input_ID}
    Input Text    ${net_create_gateway_input_ID}    ${gateway}
    Sleep    ${inputSleep}

input network name
    [Arguments]    ${netName}
    [Documentation]    输入网络名称
    ...    参数：网络名称
    Clear Element Text    ${net_create_name_input_ID}
    Input Text    ${net_create_name_input_ID}    ${netName}
    Sleep    ${inputSleep}

input network netmask
    [Arguments]    ${mask}
    [Documentation]    输入子网掩码
    ...    参数：网络子网掩码
    Clear Element Text    ${net_create_mask_input_ID}
    Input Text    ${net_create_mask_input_ID}    ${mask}
    Sleep    ${inputSleep}

input network second DNS
    [Arguments]    ${dns2}
    [Documentation]    输入备用DNS服务器
    ...    参数：备用DNS地址
    Clear Element Text    ${net_create_dns2_input_ID}
    Input Text    ${net_create_dns2_input_ID}    ${dns2}
    Sleep    ${inputSleep}

input network start ip
    [Arguments]    ${startIP}
    [Documentation]    输入开始地址
    ...    参数：开始IP地址
    Clear Element Text    ${net_create_ipStart_input_ID}
    Input Text    ${net_create_ipStart_input_ID}    ${startIP}
    Sleep    ${inputSleep}

input search network name
    [Arguments]    ${netName}
    [Documentation]    输入搜索网络名称
    ...    参数：网络名称
    open the search UI
    Clear Element Text    ${net_search_input_ID}
    Input Text    ${net_search_input_ID}    ${netName}
    Sleep    ${inputSleep}

into network manage UI
    [Documentation]    进入网络管理界面
    refresh page
    Wait Until Element Is Enabled    ${resource_manage_ID}
    Click Element    ${resource_manage_ID}
    Wait Until Element Is Visible    ${net_menu_ID}
    Click Element    ${net_menu_ID}
    Wait Until Element Is Visible    ${net_manage_UI_ID}
    Select Frame    ${net_manage_iframe_ID}
    Wait Until Element Is Visible    ${net_create_button_ID}

prepare env for edit network
    [Documentation]    为编辑网络测试准备环境：1.admin用户登录；2.创建网络
    login by admin
    create right network by UI    ${networkTD['nameD']}
    : FOR    ${name}    IN    @{networkTD['srcName']}
    \    create right network by UI    ${name}
    create right network by UI    ${networkTD['editD']}
    create right network by UI    ${networkTD['del']}
    create right vhd by UI    ${vhdNameP}

verify create network UI info
    [Documentation]    验证新建网络界面表单信息
    verify same element text by UI    ${layui_label_ID}    @{networkUI['labelList']}
    verify input box character limit    ${net_create_name_input_ID}    ${networkUI['len1']}
    verify input box character limit    ${net_create_ipStart_input_ID}    ${networkUI['len2']}
    verify input box character limit    ${net_create_ipEnd_input_ID}    ${networkUI['len2']}
    verify input box character limit    ${net_create_mask_input_ID}    ${networkUI['len2']}
    verify input box character limit    ${net_create_gateway_input_ID}    ${networkUI['len2']}
    verify input box character limit    ${net_create_dns1_input_ID}    ${networkUI['len2']}
    verify input box character limit    ${net_create_dns2_input_ID}    ${networkUI['len2']}
    verify lay UI title info    ${networkUI['title5']}

verify network dns1 on the UI
    [Arguments]    ${netName}    ${dns1}
    [Documentation]    网络管理界面验证某网络的DNS服务器
    ...    参数：1.网络名称；2.主DNS服务器
    into network manage UI
    ${nameId}    get network id by database    ${netName}
    verify element text    //a[contains(@onclick,'deleteNetwork(${nameId})')]/../../td[6]    ${dns1}

verify network dns2 on the UI
    [Arguments]    ${netName}    ${dns2}
    [Documentation]    网络管理界面验证某网络的备用DNS
    ...    参数：1.网络名称；2.备用DNS服务器
    into network manage UI
    ${nameId}    get network id by database    ${netName}
    verify element text    //a[contains(@onclick,'deleteNetwork(${nameId})')]/../../td[7]    ${dns2}

verify network end ip error info
    [Arguments]    ${msg}
    [Documentation]    验证结束地址错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${net_create_ipEnd_error_ID}
    verify element text    ${net_create_ipEnd_error_ID}    ${msg}

verify network end ip on the UI
    [Arguments]    ${netName}    ${endIP}
    [Documentation]    网络管理界面验证某网络的结束地址
    ...    参数：1.网络名称；2.结束IP地址
    into network manage UI
    ${nameId}    get network id by database    ${netName}
    verify element text    //a[contains(@onclick,'deleteNetwork(${nameId})')]/../../td[3]    ${endIP}

verify network first DNS error info
    [Arguments]    ${msg}
    [Documentation]    验证DNS服务器提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${net_create_dns1_error_ID}
    verify element text    ${net_create_dns1_error_ID}    ${msg}

verify network gateway error info
    [Arguments]    ${msg}
    [Documentation]    验证网关错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${net_create_gateway_error_ID}
    verify element text    ${net_create_gateway_error_ID}    ${msg}

verify network gateway on the UI
    [Arguments]    ${netName}    ${gateway}
    [Documentation]    网络管理界面验证某网络的网关
    ...    参数：1.网络名称；2.网关地址
    into network manage UI
    ${nameId}    get network id by database    ${netName}
    verify element text    //a[contains(@onclick,'deleteNetwork(${nameId})')]/../../td[5]    ${gateway}

verify network manage UI info
    [Documentation]    验证网络管理界面信息
    verify same element text by UI    ${public_table_head}    @{networkUI['tableH']}
    verify element title attribute value    //a[contains(@onclick,'editNetwork')]    ${networkUI['title3']}
    verify element title attribute value    //a[contains(@onclick,'deleteNetwork')]    ${networkUI['title4']}
    Table Column Should Contain    ${public_table_ID}    1    ${networkUI['nameD1']}
    Table Column Should Contain    ${public_table_ID}    1    ${networkUI['nameD2']}
    Table Should Contain    ${public_table_ID}    ${nomessage}
    verify element title attribute value    ${net_create_button_ID}    ${networkUI['title2']}
    verify element value attribute value    ${net_create_button_ID}    ${networkUI['title5']}
    open the search UI
    verify element text    ${net_search_label_ID}    ${networkUI['srcLabel']}
    verify element text    ${public_manage_title_ID}    ${networkUI['title1']}
    Unselect Frame
    verify element text    ${net_tab_ID}    ${networkUI['title1']}
   
verify network name error info
    [Arguments]    ${msg}
    [Documentation]    验证网络名称错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${net_create_name_error_ID}
    verify element text    ${net_create_name_error_ID}    ${msg}

verify network name exist on the UI
    [Arguments]    ${netName}
    [Documentation]    网络管理界面已存在某网络名称
    ...    参数：网络名称
    into network manage UI
    Table Column Should Contain    ${public_table_ID}    1    ${netName}

verify network netmask error info
    [Arguments]    ${msg}
    [Documentation]    验证子网掩码错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${net_create_mask_error_ID}
    verify element text    ${net_create_mask_error_ID}    ${msg}

verify network netmask on the UI
    [Arguments]    ${netName}    ${mask}
    [Documentation]    网络管理界面验证某网络的子网掩码
    ...    参数：1.网络名称；2.子网掩码
    into network manage UI
    ${nameId}    get network id by database    ${netName}
    verify element text    //a[contains(@onclick,'deleteNetwork(${nameId})')]/../../td[4]    ${mask}

verify network second DNS error info
    [Arguments]    ${msg}
    [Documentation]    验证备用DNS服务器提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${net_create_dns2_error_ID}
    verify element text    ${net_create_dns2_error_ID}    ${msg}

verify network start ip error info
    [Arguments]    ${msg}
    [Documentation]    验证开始地址错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${net_create_ipStart_error_ID}
    verify element text    ${net_create_ipStart_error_ID}    ${msg}

verify network start ip on the UI
    [Arguments]    ${netName}    ${startIP}
    [Documentation]    网络管理界面验证某网络的开始地址
    ...    参数：1.网络名称；2.开始IP地址
    into network manage UI
    ${nameId}    get network id by database    ${netName}
    verify element text    //a[contains(@onclick,'deleteNetwork(${nameId})')]/../../td[2]    ${startIP}