*** Settings ***
Resource          ../PublicKeywords.robot
Resource          ../../ElementLocators/vTopElementID.robot
Resource          ../ResourceManage/NetworkKeywords.robot
Resource          ../AdministratorKeywords.robot
Variables         ../../TestData/vTopManage.py

*** Keywords ***
clear env for edit location
    [Documentation]    清空编辑位置测试环境：1.删除所有位置；2.删除所有网络；3.关闭浏览器
    delete all admin by UI
    delete all location by UI
    delete all network by UI
    close browser and kill chrome process

click create location button
    [Documentation]    点击新建位置按钮
    Click Element    ${local_create_button_ID}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${local_create_name_input_ID}

click delete location button
    [Arguments]    ${localName}
    [Documentation]    点击删除按钮
    ...    参数：删除的位置名称
    ${nameId}    get location id by database    ${localName}
    Click Element    //a[contains(@onclick,'orgDelete(${nameId}')]
    Sleep    ${clickSleep}

click edit location button
    [Arguments]    ${localName}
    [Documentation]    点击编辑按钮
    ...    参数:编辑的位置名称
    ${nameId}    get location id by database    ${localName}
    Click Element    //a[contains(@onclick,'orgEdit(${nameId}')]
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${local_create_name_input_ID}

click set default location button
    [Arguments]    ${localName}
    [Documentation]    点击设置默认位置按钮,参数为设置默认位置的名称
    ${nameId}    get location id by database    ${localName}
    Click Element    //a[contains(@onclick,'orgDefault(${nameId},')]
    Sleep    ${clickSleep}

create right location by UI
    [Arguments]    ${localName}    ${parent}=init
    [Documentation]    在位置管理界面创建正确的位置
    ...    参数：1.位置名称；2.所属位置(默认值为初始位置)
    into location manage UI
    Run Keyword If    '${parent}'!='init'    select parent location on location manage UI    ${parent}
    click create location button
    input location name    ${localName}
    click save button    True
    verify lobibox info    
    verify location name exist on the UI    ${localName}

delete all location by UI
    [Documentation]    在数据库中删除所有添加位置
    into location manage UI
    ${len}    get rows of database table    SELECT * FROM vtop_manage_group WHERE id>2;
    : FOR    ${i}    IN RANGE    ${len}
    \    ${element}    Get Webelement    //a[contains(@onclick,'orgDelete')]
    \    Wait Until Element Is Enabled    ${element}
    \    Click Element    ${element}
    \    click confirm box confirm button
    \    Select Frame    ${local_tab_iframe_ID}
    \    Select Frame    ${local_manage_iframe_ID}

get location id by database
    [Arguments]    ${localName}
    [Documentation]    通过位置名称获取其名字的ID
    ${nameId}    get return value of the database query
    ...    SELECT id FROM vtop_manage_group WHERE NAME='${localName}';
    [Return]    ${nameId}

input location description
    [Arguments]    ${des}
    [Documentation]    输入位置的描述
    ...    参数：描述信息
    Clear Element Text    ${local_create_description_ID}
    Input Text    ${local_create_description_ID}    ${des}
    Sleep    ${inputSleep}    

input location group mark
    [Arguments]    ${mark}
    [Documentation]    输入位置的前缀
    ...    参数：前缀的字段
    Clear Element Text    ${local_create_mark_ID}
    Input Text    ${local_create_mark_ID}    ${mark}
    Sleep    ${inputSleep}

input location name
    [Arguments]    ${locationName}
    [Documentation]    输入位置的名称
    ...    参数：位置的名称
    Clear Element Text    ${local_create_name_input_ID}
    Input Text    ${local_create_name_input_ID}    ${locationName}
    Sleep    ${inputSleep}

input search location name
    [Arguments]    ${localName}
    [Documentation]    输入搜索的位置名称
    ...    参数：位置名称
    open the search UI
    Clear Element Text    ${local_search_input_ID}
    Input Text    ${local_search_input_ID}    ${localName}
    Sleep    ${inputSleep}

into location manage UI
    [Documentation]    进入到位置管理界面
    refresh page
    Wait Until Element Is Enabled    ${vtop_manage_ID}
    Click Element    ${vtop_manage_ID}
    Wait Until Element Is Visible    ${local_menu_ID}
    Click Element    ${local_menu_ID}
    Wait Until Element Is Visible    ${local_manage_UI_ID}
    Select Frame    ${local_tab_iframe_ID}
    Select Frame    ${local_manage_iframe_ID}
    Wait Until Element Is Visible    ${local_create_button_ID}

prepare env for edit location
    [Documentation]    为测试编辑位置准备环境：1.admin用户登录vTopCenter；2.创建网络
    ...    3.新建位置(搜索，删除等)
    login by admin
    create right network by UI    ${localTD['networkD']}
    create right location by UI    ${localTD['nameD']}
    create right location by UI    ${localTD['editD']}
    create right location by UI    ${localTD['del']}
    : FOR    ${name}    IN    @{localTD['srcName']}
    \    create right location by UI    ${name}
    create right location by UI    ${localTD['editD']}11    parent=${localTD['editD']}
    create admin user by UI    ${defaultNameTD}    local=${localTD['editD']}
    
select location network
    [Arguments]    ${netName}
    [Documentation]    新建位置时选择网络
    ...    参数：网络的名字
    ${netId}    get network id by database    ${netName}
    ${netId}    Convert To String    ${netId}
    Select Radio Button    ${lcoal_network_radio_name}    ${netId}
    Sleep    ${selectSleep}
    Radio Button Should Be Set To    ${lcoal_network_radio_name}    ${netId}

select parent location on location manage UI
    [Arguments]    ${localName}
    [Documentation]    在位置管理界面选择左侧树中所有位置
    ...    参数：位置名称
    Unselect Frame
    Select Frame    ${local_tab_iframe_ID}
    select name in the tree structure    ${localName}    vtop_manage_group    ${localUI['init']}
    Select Frame    ${local_manage_iframe_ID}

verify location parent name on location manage UI
    [Arguments]    ${localName}    ${parent}
    [Documentation]    在位置管理界面验证某位置所属位置信息
    ...    参数：1.位置名称；2.所属位置名称
    into location manage UI
    ${nameId}    get location id by database    ${localName}
    verify element text    //a[contains(@onclick,'orgEdit(${nameId})')]/../../td[2]    ${parent}
    
verify location mark error info
    [Arguments]    ${errMsg}
    [Documentation]    验证位置前缀输入错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${local_create_mark_error_ID}
    verify element text    ${local_create_mark_error_ID}    ${errMsg}

verify location mark on the UI
    [Arguments]    ${localName}    ${mark}
    [Documentation]    验证位置管理界面上某位置的前缀信息
    ...    参数：1.位置名称；2.前缀信息
    into location manage UI
    ${nameId}    get location id by database    ${localName}
    verify element text    //a[contains(@onclick,'orgEdit(${nameId})')]/../../td[3]    ${mark}

verify location name error info
    [Arguments]    ${errMsg}
    [Documentation]    验证位置名称输入错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${local_create_name_error_ID}
    verify element text    ${local_create_name_error_ID}    ${errMsg}

verify location name exist on the UI
    [Arguments]    ${localName}
    [Documentation]    验证位置管理界面上某位置已存在
    into location manage UI
    Table Column Should Contain    ${public_table_ID}    1    ${localName}

verify location manage UI info
    [Documentation]    位置管理界面信息验证
    verify same element text by UI    ${public_table_head}    @{localUI['tableH1']}
    verify element text    ${local_create_button_ID}    ${localUI['button1']}
    verify element title attribute value    ${local_create_button_ID}    ${localUI['title2']}
    verify element title attribute value    //a[contains(@onclick,'orgEdit')]    ${localUI['title5']}
    verify element title attribute value    //a[contains(@onclick,'orgDelete')]    ${localUI['title6']}
    verify element title attribute value    //a[contains(@onclick,'orgDefault')]    ${localUI['title7']}
    open the search UI
    verify element text    ${public_search_label_ID}    ${localUI['srcLabel']}
    verify element title attribute value    ${search_button_ID}    ${localUI['title8']}
    verify element text    ${public_manage_title_ID}    ${localUI['title1']}
    Unselect Frame
    verify element text    ${local_tab_ID}    ${localUI['title1']}

set default location on location manage UI
    [Arguments]    ${localName}
    [Documentation]    在位置管理界面设置某位置为默认位置
    ...    参数：位置名称 
    into location manage UI
    click set default location button    ${localName}
    click confirm box confirm button
    verify lobibox info    ${vtopBox['msg6'][:3]}${localName}${vtopBox['msg6'][3:]}
        
verify create location manage UI info
    [Documentation]    新建位置界面信息验证
    verify same element text by UI    ${local_create_label_ID}    @{localUI['labelL']}
    verify input box character limit    ${local_create_name_input_ID}    ${localUI['len1']}
    verify input box character limit    ${local_create_mark_ID}    ${localUI['len2']}
    verify same element text by UI    ${public_table_head}    @{localUI['tableH2']}
    verify element text    ${local_create_Location_ID}    ${localUI['init']}
    verify lay UI title info    ${localUI['title3']}    