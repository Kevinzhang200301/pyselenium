*** Settings ***
Resource          ../PublicKeywords.robot
Resource          ../../ElementLocators/ResourceElementID.robot
Resource          TemplateKeywords.robot
Variables         ../../TestData/ResourceTestData.py

*** Keywords ***
clear env for edit ad
    [Documentation]    清空编辑ad域的测试环境
    delete all template by UI
    delete all vhd by UI
    delete all ad by UI
    close browser and kill chrome process

click create ad button
    [Documentation]    点击新建AD域按钮
    Click Element    ${ad_create_button_ID}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${ad_create_name_input_ID}

click delete ad button
    [Arguments]    ${adName}
    [Documentation]    点击删除ad域按钮
    ...    参数：AD域名称
    ${adId}    get ad id by database    ${adName}
    Click Element    //a[contains(@onclick,'deleteDomain(${adId})')]

click edit ad button
    [Arguments]    ${adName}
    [Documentation]    点击编辑ad域按钮
    ...    参数：AD域名称
    ${nameId}    get ad id by database    ${adName}
    Click Element    //a[contains(@onclick,'editDomain(${nameId})')]
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${ad_create_name_input_ID}

create right ad
    [Arguments]    ${adName}
    [Documentation]    创建正确的ad域
    ...    参数：AD域名称
    into ad manage UI
    click create ad button
    input ad name    ${adName}
    input ad IP    ${ADTD['ipD']}
    input ad user    ${defaultNameTD}13
    input ad password    ${defaultNameTD}13
    click save button    True
    verify lobibox info    

delete all ad by UI
    [Documentation]    在数据库中删除所有的AD域
    into ad manage UI
    ${len}    get rows of database table    SELECT id FROM resource_domain_manage;
    : FOR    ${i}    IN RANGE    ${len}
    \    ${element}    Get Webelement    //a[contains(@onclick,'deleteDomain')]
    \    Wait Until Element Is Enabled    ${element}
    \    Click Element    ${element}
    \    click confirm box confirm button
    \    Select Frame    ${ad_manage_iframe_ID}

get ad id by database
    [Arguments]    ${adName}
    [Documentation]    在数据库中获取AD域的ID
    ...    参数：AD域名称
    ${nameId}    get return value of the database query
    ...    SELECT id FROM resource_domain_manage WHERE domainName='${adName}';
    [Return]    ${nameId}

input ad IP
    [Arguments]    ${ip}
    [Documentation]    输入AD域服务器地址
    ...    参数：服务器ip地址
    Clear Element Text    ${ad_create_ip_input_ID}
    Input Text    ${ad_create_ip_input_ID}    ${ip}
    Sleep    ${inputSleep}    

input ad description
    [Arguments]    ${des}
    [Documentation]    输入AD域说明
    ...    参数：说明内容
    Clear Element Text    ${ad_create_des_input_ID}
    Input Text    ${ad_create_des_input_ID}    ${des}
    Sleep    ${inputSleep}

input ad name
    [Arguments]    ${name}
    [Documentation]    输入AD域名称
    ...    参数：AD域名称
    Clear Element Text    ${ad_create_name_input_ID}
    Input Text    ${ad_create_name_input_ID}    ${name}
    Sleep    ${inputSleep}

input ad password
    [Arguments]    ${pwd}
    [Documentation]    输入AD域密码
    ...    参数：AD域用户密码
    Clear Element Text    ${ad_create_pwd_input_ID}
    Input Text    ${ad_create_pwd_input_ID}    ${pwd}
    Sleep    ${inputSleep}

input ad user
    [Arguments]    ${user}
    [Documentation]    输入AD域用户名
    ...    参数：AD域用户名
    Clear Element Text    ${ad_create_user_input_ID}
    Input Text    ${ad_create_user_input_ID}    ${user}
    Sleep    ${inputSleep}

input search ad name
    [Arguments]    ${adName}
    [Documentation]    输入搜索的AD名称
    ...    参数：AD域名称
    open the search UI
    Clear Element Text    ${ad_search_input_ID}
    Input Text    ${ad_search_input_ID}    ${adName}
    Sleep    ${inputSleep}

into ad manage UI
    [Documentation]    进入到AD域管理界面
    refresh page
    Wait Until Element Is Enabled    ${resource_manage_ID}
    Click Element    ${resource_manage_ID}
    Wait Until Element Is Visible    ${ad_menu_ID}
    Click Element    ${ad_menu_ID}
    Wait Until Element Is Visible    ${ad_manage_UI_ID}
    Select Frame    ${ad_manage_iframe_ID}
    Wait Until Element Is Visible    ${ad_create_button_ID}

prepare env for edit ad
    [Documentation]    为测试编辑ad域准备测试环境：1.admin用户登录；2.创建AD域；3.创建镜像；
    ...    4.创建模板
    login by admin
    create right ad    ${defaultNameTD}
    create right ad    ${editNameTD}
    create right ad    ${deleteNameTD}
    :FOR    ${name}    IN    @{searchNameList}
    \    create right ad    ${name}   
    create right vhd by UI    ${vhdNameP}
    create right template by UI    ${defaultNameTD}    vhdName=${vhdNameP}    ad=${defaultNameTD}

verify ad IP by UI
    [Arguments]    ${adName}    ${ip}
    [Documentation]    在ad域管理界上验证服务器ip地址
    ...    参数：1.ad域名称；2.ip地址
    into ad manage UI
    ${adId}    get ad id by database    ${adName}
    verify element text    //a[contains(@onclick,'deleteDomain(${adId})')]/../../td[2]    ${ip}

verify ad ip error info
    [Arguments]    ${msg}
    [Documentation]    验证AD域服务器地址错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${ad_create_ip_error_ID}
    verify element text    ${ad_create_ip_error_ID}    ${msg}

verify ad manage UI info
    [Documentation]    验证AD与界面其他信息
    verify same element text by UI    ${public_table_head}    @{ADUI['tableH']}
    verify element value attribute value    ${ad_create_button_ID}    ${ADUI['button1']}
    verify element title attribute value    ${ad_create_button_ID}    ${ADUI['title2']}
    verify element title attribute value    //a[contains(@onclick,'editDomain')]    ${ADUI['title3']}
    verify element title attribute value    //a[contains(@onclick,'deleteDomain')]    ${ADUI['title4']}
    open the search UI
    verify element text    ${ad_search_label_ID}    ${ADUI['srcLabel']}
    verify element text    ${public_manage_title_ID}    ${ADUI['title1']}
    Unselect Frame
    verify element text    ${ad_tab_ID}    ${ADUI['title1']}

verify ad name error info
    [Arguments]    ${msg}
    [Documentation]    验证AD域名称错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${ad_create_name_error_ID}
    verify element text    ${ad_create_name_error_ID}    ${msg}

verify ad name exist by UI
    [Arguments]    ${adName}
    [Documentation]    在ad域管理界面上验证ad域已存在
    ...    参数：ad域名称
    into ad manage UI
    Table Column Should Contain    ${public_table_ID}    1    ${adName}

verify ad password error info
    [Arguments]    ${msg}
    [Documentation]    验证AD域密码错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${ad_create_pwd_error_ID}
    verify element text    ${ad_create_pwd_error_ID}    ${msg}

verify ad user error info
    [Arguments]    ${msg}
    [Documentation]    验证AD域用户名错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${ad_create_user_error_ID}
    verify element text    ${ad_create_user_error_ID}    ${msg}

verify create ad UI info
    [Documentation]    验证新建AD域界面form信息
    verify same element text by UI    ${ad_create_label_ID}    @{ADUI['labelList']}
    verify element placeholder attribute value    ${ad_create_name_input_ID}    ${ADUI['msg2']}
    verify element placeholder attribute value    ${ad_create_ip_input_ID}    ${ADUI['msg3']}
    verify input box character limit    ${ad_create_name_input_ID}    ${ADUI['len1']}
    verify input box character limit    ${ad_create_ip_input_ID}    ${ADUI['len2']}
    verify input box character limit    ${ad_create_user_input_ID}    ${ADUI['len2']}
    verify input box character limit    ${ad_create_pwd_input_ID}    ${ADUI['len2']}
    verify lay UI title info    ${ADUI['title5']}