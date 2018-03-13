*** Settings ***
Resource          ../../ElementLocators/ResourceElementID.robot
Resource          ../PublicKeywords.robot
Resource          TemplateKeywords.robot
Variables         ../../TestData/ResourceTestData.py

*** Keywords ***
clear env for edit vlan
    [Documentation]    清空vlan测试环境:1.删除模板；2.删除vhd；3.删除vlan；4.关闭浏览器
    delete all template by UI
    delete all vhd by UI
    delete all vlan by UI
    close browser and kill chrome process

click create vlan button
    [Documentation]    点击新建vlan按钮
    Click Element    ${vlan_create_button_ID}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${vlan_create_key_input_ID}

click delete vlan button
    [Arguments]    ${vlanName}
    [Documentation]    点击删除vlan按钮,参数为vlan的名称
    ${id}    get vlan name ID by database    ${vlanName}
    Click Element    //a[contains(@onclick,'deleteVlan(${id})')]
    Unselect Frame
    Wait Until Element Is Visible    ${confirm_div_ID}

click edit vlan button
    [Arguments]    ${vlanName}
    [Documentation]    点击编辑vlan按钮,参数为vlan的名称
    ${id}    get vlan name ID by database    ${vlanName}
    Click Element    //a[contains(@onclick,'editVlan(${id})')]
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${vlan_create_key_input_ID}

create right vlan by UI
    [Arguments]    ${vlanName}    ${vlanValue}=default
    [Documentation]    新建正确的vlan
    ...    参数：1.vlan名称；2.vlan的值
    into vlan manage UI
    click create vlan button
    input vlan name    ${vlanName}
    ${value}    Set Variable If    '${vlanValue}'=='default'    ${vlanTD['valueD']}    '${vlanValue}'!='default'    ${vlanValue}
    input vlan value    ${value}
    click save button    True
    verify lobibox info

delete all vlan by UI
    [Documentation]    在数据库中删除所有vlan
    into vlan manage UI
    ${len}    get rows of database table    SELECT id FROM resource_vlan;
    : FOR    ${i}    IN RANGE    ${len}
    \    ${element}    Get Webelement    //a[contains(@onclick,'deleteVlan')]
    \    Wait Until Element Is Enabled    ${element}
    \    Click Element    ${element}
    \    click confirm box confirm button
    \    Select Frame    ${vlan_manage_iframe_ID}

get vlan name ID by database
    [Arguments]    ${vlanName}
    [Documentation]    通过数据库获取vlan的ID
    ...    参数：vlan的名称
    ${id}    get return value of the database query    SELECT id FROM resource_vlan WHERE key_name='${vlanName}';
    [Return]    ${id}

input search vlan name
    [Arguments]    ${searchName}
    [Documentation]    输入搜索的vlan名称
    ...    参数：vlan的名称
    open the search UI
    Clear Element Text    ${vlan_search_input_ID}
    Input Text    ${vlan_search_input_ID}    ${searchName}
    Sleep    ${inputSleep}

input vlan name
    [Arguments]    ${vlanName}
    [Documentation]    输入vlan的名称
    ...    参数：vlan的名称
    Clear Element Text    ${vlan_create_name_input_ID}
    Input Text    ${vlan_create_name_input_ID}    ${vlanName}
    Sleep    ${inputSleep}

input vlan value
    [Arguments]    ${vlanValue}
    [Documentation]    输入vlan的值
    ...    参数：vlan的值
    Clear Element Text    ${vlan_create_key_input_ID}
    Input Text    ${vlan_create_key_input_ID}    ${vlanValue}
    Sleep    ${inputSleep}

into vlan manage UI
    [Documentation]    进入到vlan管理界面
    refresh page
    Wait Until Element Is Enabled    ${resource_manage_ID}
    Click Element    ${resource_manage_ID}
    Wait Until Element Is Visible    ${vlan_menu_ID}
    Click Element    ${vlan_menu_ID}
    Wait Until Element Is Visible    ${vlan_UI_ID}
    Select Frame    ${vlan_manage_iframe_ID}
    Wait Until Element Is Visible    ${vlan_create_button_ID}

prepare env for edit vlan
    [Documentation]    为测试vlan准备环境：1.admin用户登录；2.创建vlan；3.创建镜像；4.创建模板
    login by admin
    create right vlan by UI    ${defaultNameTD}
    create right vlan by UI    ${editNameTD}
    create right vlan by UI    ${deleteNameTD}
    : FOR    ${name}    IN    @{searchNameList}
    \    create right vlan by UI    ${name}
    create right vhd by UI    ${vhdNameP}
    create right template by UI    ${defaultNameTD}8     vhdName=${vhdNameP}    vlan=${defaultNameTD}

verify create vlan UI not exist
    [Documentation]    验证新建vlan界面不存在
    Unselect Frame
    Wait Until Element Is Not Visible    ${layui_title_ID}
    Select Frame    ${vlan_manage_iframe_ID}
    Wait Until Element Is Visible    ${vlan_create_button_ID}

verify create vlan UI info
    [Documentation]    验证新建vlan界面信息
    verify same element text by UI    ${layui_label_ID}    @{vlanUI['labelL']}
    verify input box character limit    ${vlan_create_name_input_ID}    ${vlanUI['len1']}
    verify input box character limit    ${vlan_create_key_input_ID}    ${vlanUI['len2']}
    verify lay UI title info    ${vlanUI['title2']}

verify vlan manage UI info
    [Documentation]    验证vlan管理界面其他信息（按钮等）
    verify same element text by UI    ${vlan_manage_table_head}    @{vlanUI['tableH']}
    verify element title attribute value    //a[contains(@onclick,'editVlan')]    ${vlanUI['title6']}
    verify element title attribute value    //a[contains(@onclick,'deleteVlan')]    ${vlanUI['title5']}
    verify element title attribute value    ${vlan_create_button_ID}    ${vlanUI['title4']}
    verify element value attribute value    ${vlan_create_button_ID}    ${vlanUI['button1']}
    verify element text    ${public_manage_title_ID}    ${vlanUI['title1']}
    open the search UI
    verify element text    ${vlan_search_label_ID}    ${vlanUI['srcLabel']}
    Unselect Frame
    verify element text    ${vlan_tab_ID}    ${vlanUI['title1']}

verify vlan name error msg
    [Arguments]    ${msg}
    [Documentation]    验证vlan名称错误信息
    ...    参数：错误信息
    Wait Until Element Is Visible    ${vlan_create_name_error_ID}
    verify element text    ${vlan_create_name_error_ID}    ${msg}

verify vlan name exist by UI
    [Arguments]    ${vlanName}
    [Documentation]    在当前界面上已存在vlan名称
    ...    参数：vlan名称
    into vlan manage UI
    Table Column Should Contain    ${public_table_ID}    1    ${vlanName}

verify vlan value by UI
    [Arguments]    ${vlanName}    ${vlanVaule}
    [Documentation]    在页面上验证vlan值
    ...    参数：1.vlan的名称；2.vlan的值
    into vlan manage UI
    verify element text    //td[@title='${vlanName}']/../td[2]    ${vlanVaule}

verify vlan value error msg
    [Arguments]    ${msg}
    [Documentation]    验证vlan值错误信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${vlan_create_key_error_ID}
    verify element text    ${vlan_create_key_error_ID}    ${msg}
