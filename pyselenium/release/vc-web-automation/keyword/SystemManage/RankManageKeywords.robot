*** Settings ***
Resource          ../PublicKeywords.robot
Resource          ../../ElementLocators/SystemManageElementID.robot
Resource          ../ResourceManage/VhdKeywords.robot
Variables         ../../TestData/SystemManage.py

*** Keywords ***
clear env for create rank
    [Documentation]    清空新建分级管理环境：1.删除镜像；2.关闭浏览器
    delete all vhd by UI
    close browser and kill chrome process

clear env for edit rank
    [Documentation]    清空编辑分级管理环境：1.删除分级管理；2.删除镜像；3.关闭浏览器
    delete all rank by UI
    delete all vhd by UI
    close browser and kill chrome process

click create rank button
    [Documentation]    点击新建下级vTopCenter按钮
    Click Element    ${rank_create_button_ID}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${rank_create_name_input_ID}

click delete rank button
    [Arguments]    ${rankName}
    [Documentation]    点击删除下级VC按钮
    ...    参数：下级VC名称
    ${nameId}    get rank id by database    ${rankName}
    Click Element    //a[contains(@onclick,'delRank(${nameId})')]

click edit rank button
    [Arguments]    ${rankName}
    [Documentation]    点击编辑下级VC的按钮
    ...    参数：下级VC名称
    ${nameId}    get rank id by database    ${rankName}
    Click Element    //a[contains(@onclick,'editRank(${nameId})')]
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${rank_create_name_input_ID}

create right rank by UI
    [Arguments]    ${rankName}    ${rankIp}=default    ${key}=default
    ...    ${vhdNum}=1
    [Documentation]    创建正确的下级VC
    ...    参数；1.下级VC名称；2.下级VC的IP地址；3.密码(有默认值)
    into rank manage UI
    ${ipNew}    Set Variable If
    ...    '${rankIp}'=='default'    ${rankTD['addrD']}
    ...    '${rankIp}'!='default'    ${rankIp}     
    ${keyNew}    Set Variable If
    ...    '${key}'=='default'    ${rankTD['keyD']}
    ...    '${key}'!='default'    ${key} 
    click create rank button
    input rank name    ${rankName}
    input rank ip    ${ipNew}
    input rank key    ${keyNew}
    select table checkbox on UI    ${vhdNum}
    click save button    True
    verify rank name on the UI    ${rankName}

delete all rank by UI
    [Documentation]    在数据库中删除所有的分级管理
    into rank manage UI
    ${len}    get rows of database table    SELECT id FROM system_rank;
    : FOR    ${i}    IN RANGE    ${len}
    \    ${element}    Get Webelement    //a[contains(@onclick,'delRank')]
    \    Wait Until Element Is Enabled    ${element}
    \    Click Element    ${element}
    \    click confirm box confirm button
    \    Select Frame    ${rank_manage_iframe_ID}

get rank id by database
    [Arguments]    ${rankName}
    [Documentation]    在数据库中获取下级VC的ID
    ...    参数：下级VC的名称
    ${nameId}    get return value of the database query    SELECT id FROM system_rank WHERE rank_name='${rankName}';
    [Return]    ${nameId}

input contact mobile
    [Arguments]    ${mobile}
    [Documentation]    输入联系电话
    ...    参数：电话信息
    Clear Element Text    ${rank_create_mobile_input_ID}
    Input Text    ${rank_create_mobile_input_ID}    ${mobile}
    Sleep    ${inputSleep}

input contact person
    [Arguments]    ${name}
    [Documentation]    输入联系人
    ...    参数：联系人信息
    Clear Element Text    ${rank_create_people_input_ID}
    Input Text    ${rank_create_people_input_ID}    ${name}
    Sleep    ${inputSleep}

input rank ip
    [Arguments]    ${rankIp}
    [Documentation]    输入下级VC的IP地址
    ...    参数：下级VC的IP地址
    Clear Element Text    ${rank_create_ip_input_ID}
    Input Text    ${rank_create_ip_input_ID}    ${rankIp}
    Sleep    ${inputSleep}

input rank key
    [Arguments]    ${rankKey}
    [Documentation]    输入密钥
    ...    参数：密钥信息
    Clear Element Text    ${rank_create_key_input_ID}
    Input Text    ${rank_create_key_input_ID}    ${rankKey}
    Sleep    ${inputSleep}

input rank name
    [Arguments]    ${rankName}
    [Documentation]    输入下级VC的名称
    ...    参数：下级VC名称
    Clear Element Text    ${rank_create_name_input_ID}
    Input Text    ${rank_create_name_input_ID}    ${rankName}
    Sleep    ${inputSleep}

input search rank ip
    [Arguments]    ${rankIp}
    [Documentation]    输入搜索下级VC的IP
    ...    参数：下级VC的IP地址
    Clear Element Text    ${rank_search_IP_input_ID}
    Input Text    ${rank_search_IP_input_ID}    ${rankIp}
    Sleep    ${inputSleep}

input search rank name
    [Arguments]    ${rankName}
    [Documentation]    输入搜索下级VC的名称
    ...    参数：下级VC的名称
    Clear Element Text    ${rank_search_name_input_ID}
    Input Text    ${rank_search_name_input_ID}    ${rankName}
    Sleep    ${inputSleep}

into rank manage UI
    [Documentation]    进入到分级管理界面
    refresh page
    Wait Until Element Is Enabled    ${system_manage_menu_ID}
    Click Element    ${system_manage_menu_ID}
    Wait Until Element Is Visible    ${rank_menu_ID}
    Click Element    ${rank_menu_ID}
    Wait Until Element Is Visible    ${rank_manage_UI_ID}
    Select Frame    ${rank_manage_iframe_ID}
    Wait Until Element Is Visible    ${rank_create_button_ID}

prepare env for create rank
    [Documentation]    为测试新建分级管理准备环境：1.admin登录；2.创建镜像
    login by admin
    create right vhd by UI    ${rankTD['vhdNameD']}
    : FOR    ${vhd}    IN    @{rankTD['vhdNameR']}
    \    create right vhd by UI    ${vhd}

prepare env for edit rank
    [Documentation]    为测试编辑分级管理准备环境:1.admin登录；2.创建镜像；
    ...    3.创建分级中心
    login by admin
    create right vhd by UI    ${rankTd['vhdNameD']}
    : FOR    ${vhd}    IN    @{rankTD['vhdNameR']}
    \    create right vhd by UI    ${vhd}
    create right rank by UI    ${rankTD['nameD']}
    create right rank by UI    ${rankTD['editD']}
    create right rank by UI    ${rankTD['del']}
    ${len}    Get Length    ${rankTD['srcName']}
    : FOR    ${i}    IN RANGE    ${len}
    \    create right rank by UI    ${rankTD['srcName'][${i}]}    ${rankTD['srcIp'][${i}]}

select rank vhd
    [Arguments]    @{vhdName}
    [Documentation]    选择用于下级VC的镜像
    ...    参数：镜像名称
    Execute Javascript    window.scrollTo(0,10000000)
    : FOR    ${vhd}    IN    @{vhdName}
    \    ${nameId}    get vhd id by database    ${vhd}
    \    select Checkbox    //input[@value='${nameId}']
    \    Sleep    ${selectSleep}
    \    Checkbox Should Be Selected    //input[@value='${nameId}']

unselect rank vhd
    [Arguments]    @{vhdName}
    [Documentation]    去掉已选择用于下级VC的镜像
    ...    参数：镜像名称
    : FOR    ${vhd}    IN    @{vhdName}
    \    ${nameId}    get vhd id by database    ${vhd}
    \    Unselect Checkbox    //input[@value='${nameId}']
    \    Sleep    ${selectSleep}
    \    Checkbox Should Not Be Selected    //input[@value='${nameId}']

verify create rank UI info
    [Documentation]    验证新建下级VC界面信息验证
    verify same element text by UI    ${layui_label_ID}    @{rankUI['labelL']}    ${EMPTY}
    verify same element text by UI    ${public_table_head}    ${EMPTY}    @{rankUI['tableH2']}
    verify input box character limit    ${rank_create_name_input_ID}    ${rankUI['len1']}
    verify input box character limit    ${rank_create_ip_input_ID}    ${rankUI['len2']}
    verify input box character limit    ${rank_create_key_input_ID}    ${rankUI['len1']}
    verify input box character limit    ${rank_create_people_input_ID}    ${rankUI['len1']}
    verify input box character limit    ${rank_create_mobile_input_ID}    ${rankUI['len1']}
    verify lay UI title info    ${rankUI['title5']}    ${rankUI['title6']}

verify rank IP on the UI
    [Arguments]    ${rankName}    ${rankIp}
    [Documentation]    在分级管理界面上验证vTopCenter地址
    ...    参数：1.名称；2.IP地址
    into rank manage UI
    ${nameId}    get rank id by database    ${rankName}
    verify element text    //a[contains(@onclick,'editRank(${nameId})')]/../../td[2]    ${rankIp}

verify rank contact mobile on the UI
    [Arguments]    ${rankName}    ${mobile}
    [Documentation]    在分级管理界面验证联系电话
    ...    参数：1.名称；2.联系电话
    into rank manage UI
    ${nameId}    get rank id by database    ${rankName}
    verify element text    //a[contains(@onclick,'editRank(${nameId})')]/../../td[5]    ${mobile}

verify rank contact person on the UI
    [Arguments]    ${rankName}    ${contact}
    [Documentation]    在分级管理界面验证联系人信息
    ...    参数：1.名称；2.联系人信息
    into rank manage UI
    ${nameId}    get rank id by database    ${rankName}
    verify element text    //a[contains(@onclick,'editRank(${nameId})')]/../../td[4]    ${contact}

verify rank ip error info
    [Arguments]    ${errMsg}
    [Documentation]    下级管理中心IP错误提示信息验证
    ...    参数：错题提示信息
    Wait Until Element Is Visible    ${rank_create_ip_error_ID}
    verify element text    ${rank_create_ip_error_ID}    ${errMsg}

verify rank key error info
    [Arguments]    ${errMsg}
    [Documentation]    密钥错误提示信息验证
    ...    参数：错题提示信息
    Wait Until Element Is Visible    ${rank_create_key_error_ID}
    verify element text    ${rank_create_key_error_ID}    ${errMsg}

verify rank manage UI info
    [Documentation]    验证分级管理界面其他信息
    verify same element text by UI    ${public_table_head}    @{rankUI['tableH1']}
    Element Should Be Visible    //a[@title='${rankUI['title3']}']
    Element Should Be Visible    //a[@title='${rankUI['title4']}']
    verify element value attribute value    ${rank_create_button_ID}    ${rankUI['button1']}
    Element Should Be Visible    //input[@title='${rankUI['title2']}']
    open the search UI
    verify same element text by UI    ${public_search_label_ID}    @{rankUI['srcLabel']}
    verify element text    ${public_manage_title_ID}    ${rankUI['title1']}
    Unselect Frame
    verify element text    ${rank_tab_ID}    ${rankUI['title1']}

verify rank name error info
    [Arguments]    ${errMsg}
    [Documentation]    下级VC错误提示信息验证
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${rank_create_name_error_ID}
    verify element text    ${rank_create_name_error_ID}    ${errMsg}

verify rank name on the UI
    [Arguments]    ${rankName}
    [Documentation]    在分级管理界面验证下级VC的名称
    ...    参数：错误提示信息
    into rank manage UI
    Table Column Should Contain    ${public_table_ID}    1    ${rankName}

verify rank vhd error info
    [Arguments]    ${errMsg}
    [Documentation]    选择镜像错误提示信息验证
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${rank_create_vhd_error_ID}
    verify element text    ${rank_create_vhd_error_ID}    ${errMsg}

verify rank vhd info on the UI
    [Arguments]    ${rankName}    @{vhdName}
    [Documentation]    在分级管理界面验证镜像信息
    into rank manage UI
    ${nameId}    get rank id by database    ${rankName}
    ${len}    Get Length    ${vhdName}
    ${vhdInfo}    Get Text    //a[contains(@onclick,'editRank(${nameId})')]/../../td[3]
    Should Contain    ${vhdInfo}    共${SPACE}${len}${SPACE}个
    ${titleName}    Set Variable    ${EMPTY}
    : FOR    ${txt}    IN    @{vhdName}
    \    ${titleName}    Set Variable    ${titleName},${txt}
    ${titleName}    Set Variable    ${titleName[1:]}
    Element Should Be Visible    //td[@title='${titleName}']
