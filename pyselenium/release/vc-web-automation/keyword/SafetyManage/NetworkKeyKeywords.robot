*** Settings ***
Resource          ../../ElementLocators/SafetyManageElementID.robot
Resource          ../PublicKeywords.robot
Resource    ../../Keyword/ResourceManage/TemplateKeywords.robot
Variables         ../../TestData/SafetyManage.py

*** Keywords ***
clear env for edit network key
    [Documentation]    清空编辑网络密钥环境：1.删除模板；2.删除镜像；
    ...    3.删除网络密钥；4.关闭浏览器
    delete all template by UI
    delete all vhd by UI
    delete all network key by UI
    close browser and kill chrome process

click create network key button
    [Documentation]    点击新建网络密钥按钮
    Click Element    ${netKey_create_button_ID}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${netKey_create_name_input_ID}

click delete network key button
    [Arguments]    ${netKeyName}
    [Documentation]    点击删除网络密钥按钮
    ...    参数：网络密钥名称
    ${nameId}    get network key id by database    ${netKeyName}
    Click Element    //a[contains(@onclick,'deleteNetkey(${nameId})')]

click edit network key button
    [Arguments]    ${netKeyName}
    [Documentation]    点击编辑网络密钥按钮
    ...    参数：网络密钥名称
    ${nameId}    get network key id by database    ${netKeyName}
    Click Element    //a[contains(@onclick,'editNetkey(${nameId})')]
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${netKey_create_name_input_ID}

create right network key by UI
    [Arguments]    ${netKeyName}
    [Documentation]    在界面上创建正确的网络密钥
    ...    参数：网络密钥名称
    into network key manage UI
    click create network key button
    input network key name    ${netKeyName}
    input network key value    ${netKeyTD['valueD']}
    click save button    True
    verify network key name on the UI    ${netKeyName}

delete all network key by UI
    [Documentation]    在数据库中删除所有的网络密钥
    into network key manage UI
    ${len}    get rows of database table
    ...    SELECT id FROM resource_netkey;
    : FOR    ${i}    IN RANGE    ${len}
    \    ${element}    Get Webelement    //a[contains(@onclick,'deleteNetkey')]
    \    Wait Until Element Is Enabled    ${element}
    \    Click Element    ${element}
    \    click confirm box confirm button
    \    Select Frame    ${netKey_manage_iframe_ID}

get network key id by database
    [Arguments]    ${netKeyName}
    [Documentation]    从数据库中获取网络密钥的ID
    ...    参数：网络密码名称
    ${nameId}    get return value of the database query
    ...    SELECT id FROM resource_netkey WHERE key_name='${netKeyName}';
    [Return]    ${nameId}

input network key name
    [Arguments]    ${netKeyName}
    [Documentation]    输入网络密钥的名称
    ...    参数：网络密码名称
    Clear Element Text    ${netKey_create_name_input_ID}
    Input Text    ${netKey_create_name_input_ID}    ${netKeyName}
    Sleep    ${inputSleep}    

input network key value
    [Arguments]    ${netKeyValue}
    [Documentation]    输入网络密钥的值
    ...    参数：网络密钥的值
    Clear Element Text    ${netKey_create_key_input_ID}
    Input Text    ${netKey_create_key_input_ID}    ${netKeyValue}
    Sleep    ${inputSleep}
    
input search network key name
    [Arguments]    ${netKeyName}
    [Documentation]    输入搜索网络密钥名称
    ...    参数：网络密钥的名称
    open the search UI
    Clear Element Text    ${netKey_search_input_ID}
    Input Text    ${netKey_search_input_ID}    ${netKeyName}
    Sleep    ${inputSleep}

into network key manage UI
    [Documentation]    进入到网络密钥管理界面
    refresh page
    Wait Until Element Is Enabled    ${safety_manage_menu_ID}
    Click Element    ${safety_manage_menu_ID}
    Wait Until Element Is Visible    ${netKey_menu_ID}
    Click Element    ${netKey_menu_ID}
    Wait Until Element Is Visible    ${netKey_manage_UI_ID}
    Select Frame    ${netKey_manage_iframe_ID}
    Wait Until Element Is Visible    ${netKey_create_button_ID}

prepare env for edit network key
    [Documentation]    为测试编辑网络密钥准备环境：1.admin用户登录；2.创建网络密钥
    login by admin
    create right vhd by UI    ${tempTD['vhdD']}
    create right network key by UI    ${netKeyTD['nameD']}
    create right network key by UI    ${netKeyTD['editD']}
    create right network key by UI    ${netKeyTD['del']}
    : FOR    ${name}    IN    @{netKeyTD['srcName']}
    \    create right network key by UI    ${name}

verify create network key UI info
    [Documentation]    验证新建网络密钥界面form信息
    verify same element text by UI    ${layui_label_ID}    @{netKeyUI['labelL']}
    verify input box character limit    ${netKey_create_name_input_ID}    ${netKeyUI['len1']}
    verify input box character limit    ${netKey_create_key_input_ID}    ${netKeyUI['len2']}
    verify element placeholder attribute value    ${netKey_create_key_input_ID}    ${netKeyUI['msg1']}
    verify lay UI title info    ${netKeyUI['title5']}    

verify network key manage UI info
    [Documentation]    验证网络密钥管理界面其他信息
    verify same element text by UI    ${netKey_table_head}    @{netKeyUI['tableH']}   
    Run Keyword And Continue On Failure    Element Should Be Visible    //a[@title='${netKeyUI['title3']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //a[@title='${netKeyUI['title4']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@value='${netKeyUI['button1']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@title='${netKeyUI['title2']}']
    open the search UI
    Run Keyword And Continue On Failure    verify element text    ${public_search_label_ID}    ${netKeyUI['srcLabel']}
    Run Keyword And Continue On Failure    verify element text    ${public_manage_title_ID}    ${netKeyUI['title1']}
    Unselect Frame
    verify element text    ${netKey_tab_ID}    ${netKeyUI['title1']}
    
verify network key name error info
    [Arguments]    ${errMsg}
    [Documentation]    验证网络密钥名称错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${netKey_create_name_error_ID}
    verify element text    ${netKey_create_name_error_ID}    ${errMsg}

verify network key name on the UI
    [Arguments]    ${netKeyName}
    [Documentation]    在网络密钥界面验证某网络密钥的名字
    ...    参数：网络密钥名称
    into network key manage UI
    Table Column Should Contain    ${public_table_ID}    1    ${netKeyName}

verify network key value error info
    [Arguments]    ${errMsg}
    [Documentation]    验证网络密钥值错误提示信息
    ...    参数：网络密钥名称
    Wait Until Element Is Visible    ${netKey_create_key_error_ID}
    verify element text    ${netKey_create_key_error_ID}    ${errMsg}

verify network key value on the UI
    [Arguments]    ${netKeyName}    ${netKeyValue}
    [Documentation]    在网络密钥界面验证某网络密钥的值
    ...    参数：1.网络密钥名称；2.网络密钥的值
    into network key manage UI
    ${nameId}    get network key id by database    ${netKeyName}
    verify element text    //a[contains(@onclick,'editNetkey(${nameId})')]/../../td[2]    ${netKeyValue}
