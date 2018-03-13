*** Settings ***
Resource          ../../ElementLocators/PolicyElementID.robot
Resource          ../PublicKeywords.robot
Resource          ../ResourceManage/TemplateKeywords.robot
Resource          ../ResourceManage/DeviceKeywords.robot
Variables         ../../TestData/PolicyManage.py

*** Keywords ***
clear env for edit device policy
    [Documentation]    清空测试编辑设备策略环境
    delete all template by UI
    delete all device policy by UI
    delete all vhd by UI
    close browser and kill chrome process

click create device policy button
    [Documentation]    点击新建设备策略按钮
    Click Element    ${dply_create_button_ID}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${dply_create_name_input_ID}

click delete device policy button
    [Arguments]    ${policyName}
    [Documentation]    点击删除设备策略按钮
    ...    参数：设备策略名称
    ${name_id}    get device policy ID by database    ${policyName}
    Click Element    //a[contains(@onclick,'delPolicy(${name_id})')]

click edit device policy button
    [Arguments]    ${policyName}
    [Documentation]    点击编辑设备策略按钮
    ...    参数：设备策略的名称
    ${name_id}    get device policy ID by database    ${policyName}
    Click Element    //a[contains(@onclick,'editPolicy(${name_id})')]
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${dply_create_name_input_ID}

create right device policy
    [Arguments]    ${policyName}    ${type}=black    ${number}=1    ${deviceName}=None
    [Documentation]    创建一个正确的设备策略
    ...    参数：1.设备策略名称；2.设备策略类型；3.设备个数
    into device policy manage UI
    click create device policy button
    input device policy name    ${policyName}
    Run Keyword If    '${type}'!='black'    select device policy type    ${type}
    Run Keyword If    '${deviceName}'=='None'    select table checkbox on UI    ${number}
    Run Keyword If    '${deviceName}'!='None'    select devices by UI    ${deviceName}   
    click save button    True
    verify lobibox info

delete all device policy by UI
    [Documentation]    删除所有的设备策略（除去默认策略）
    into device policy manage UI
    ${len}    get rows of database table    SELECT * FROM policy_policy_device WHERE id>1;
    : FOR    ${i}    IN RANGE    ${len}
    \    ${element}    Get Webelement    //a[contains(@onclick,'delPolicy')]
    \    Wait Until Element Is Enabled    ${element}
    \    Click Element    ${element}
    \    click confirm box confirm button
    \    Select Frame    ${dply_manage_iframe_ID}

get device policy ID by database
    [Arguments]    ${policyName}
    [Documentation]    获取设备策略的ID
    ...    参数：设备策略名称
    ${id}    get return value of the database query    select id from policy_policy_device where policy_name='${policyName}';
    [Return]    ${id}

input device policy description
    [Arguments]    ${policyDes}
    [Documentation]    输入设备策略说明
    ...    参数：描述信息
    Clear Element Text    ${dply_create_desc_ID}
    Input Text    ${dply_create_desc_ID}    ${policyDes}
    Sleep    ${inputSleep}

input device policy name
    [Arguments]    ${policyName}
    [Documentation]    输入新建设备策略名称
    ...    参数：设备策略名称
    Clear Element Text    ${dply_create_name_input_ID}
    Input Text    ${dply_create_name_input_ID}    ${policyName}
    Sleep    ${inputSleep}

input search device policy name
    [Arguments]    ${txt}
    [Documentation]    输入搜索的设备策略字段
    ...    参数：搜索设备策略字段
    open the search UI
    Clear Element Text    ${dply_search_input_ID}
    Input Text    ${dply_search_input_ID}    ${txt}
    Sleep    ${inputSleep}

into device policy manage UI
    [Documentation]    进入到设备策略管理界面
    refresh page
    Wait Until Element Is Enabled    ${policy_manage_button_ID}
    Click Element    ${policy_manage_button_ID}
    Wait Until Element Is Visible    ${dply_menu_ID}
    Click Element    ${dply_menu_ID}
    Wait Until Element Is Visible    ${dply_manage_UI_ID}
    Select Frame    ${dply_manage_iframe_ID}
    Wait Until Element Is Visible    ${dply_create_button_ID}

prepare env for edit device policy
    [Documentation]    为测试编辑设备策略准备环境：1.admin用户登录；3.创建设备策略；4.创建镜像；
    ...    5.创建模板
    login by admin
    create right device policy    ${defaultNameTD}
    create right device policy    ${deleteNameTD}
    create right device policy    ${editNameTD}
    : FOR    ${name}    IN    @{searchNameList}
    \    create right device policy    ${name}
    create right vhd by UI    ${vhdNameP}
    create right template by UI    ${defaultNameTD}    vhdName=${vhdNameP}    devicePolicy=${defaultNameTD}

select device policy type
    [Arguments]    ${policyType}
    [Documentation]    选择设备类型
    ...    参数为设备类型（白名单，黑名单）
    Select From List By Label    ${dply_create_select_ID}    ${policyType}
    Sleep    ${selectSleep}
    List Selection Should Be    ${dply_create_select_ID}    ${policyType}

select devices by UI
    [Arguments]    @{devices}
    [Documentation]    选择设备
    ...    参数：设备名称集合(list)
    : FOR    ${name}    IN    @{devices}
    \    ${name_id}    get device ID by database    ${name}
    \    Select Checkbox    //input[@value="${name_id}"]
    \    Sleep    ${selectSleep}
    \    Checkbox Should Be Selected    //input[@value="${name_id}"]

unselect devices by UI
    [Arguments]    @{devices}
    [Documentation]    去掉选择的设备
    ...    参数：设备名称的集合(list)
    : FOR    ${name}    IN    @{devices}
    \    ${name_id}    get device ID by database    ${name}
    \    Unselect Checkbox    //input[@value="${name_id}"]
    \    Sleep    ${selectSleep}
    \    Checkbox Should Not Be Selected    //input[@value="${name_id}"]

verify create device policy UI info
    [Documentation]    验证新建设备策略界面信息
    verify same element text by UI    ${layui_label_ID}    @{policyUI['labelL1'][:4]}    ${EMPTY}    @{policyUI['labelL1'][4:]}
    verify input box character limit    ${dply_create_name_input_ID}    ${policyUI['len1']}
    ${list1}    Get List Items    ${dply_create_select_ID}
    Lists Should Be Equal    ${list1}    ${policyUI['Dtype']}
    List Selection Should Be    ${dply_create_select_ID}    ${policyUI['Dtype'][0]}
    verify same element text by UI    //tbody/tr[1]/td    ${EMPTY}    @{policyUI['tableH2']}
    verify same element text by UI    //tbody/tr[2]/td    ${EMPTY}    @{policyUI['USB']}
    verify same element text by UI    //tbody/tr[3]/td    ${EMPTY}    @{policyUI['CD']}
    verify same element text by UI    //tbody/tr[4]/td    ${EMPTY}    @{policyUI['VCD']}
    verify lay UI title info    ${policyUI['title5']}

verify create device policy UI not exist
    [Documentation]    验证创建设备策略界面不存在
    Unselect Frame
    Element Should Not Be Visible    ${layui_save_button_ID}
    Select Frame    ${dply_manage_iframe_ID}
    Element Should Be Visible    ${dply_create_button_ID}

verify device policy manage UI info
    [Documentation]    设备策略管理界面上信息验证
    verify same element text by UI    ${public_table_head}    @{policyUI['tableH1']}
    ${len}    get current table record number
    verify same element text by UI    //tbody/tr[${len}]/td    @{policyUI['tableD1']}    ${EMPTY}
    verify element title attribute value    //a[contains(@onclick,'editPolicy')]    ${policyUI['title3']}
    verify element title attribute value    //a[contains(@onclick,'delPolicy')]    ${policyUI['title4']}
    verify element title attribute value    ${dply_manage_device_ID}    ${policyUI['title7']}
    verify element value attribute value    ${dply_create_button_ID}    ${policyUI['button1']}
    verify element title attribute value    ${dply_create_button_ID}    ${policyUI['title2']}
    open the search UI
    verify element text    ${public_search_label_ID}    ${policyUI['srcBar']}
    verify element text    ${public_manage_title_ID}    ${policyUI['title1']}
    Unselect Frame
    verify element text    ${dply_manage_tab_ID}    ${policyUI['title1']}

verify device policy creater by UI
    [Arguments]    ${policyName}    ${creater}
    [Documentation]    在设备策略管理界面验证创建人
    ...    参数:1.设备策略名称；2.创建人
    into device policy manage UI
    ${name_id}    get device policy ID by database    ${policyName}
    Element Should Contain    //a[contains(@onclick,'editPolicy(${name_id})')]/../../td[5]    ${creater}

verify device policy device by UI
    [Arguments]    ${policyName}    @{devices}
    [Documentation]    在设备策略管理界面验证设备信息
    ...    参数：1.设备策略名称；2.具体设备名称集合(list)
    into device policy manage UI
    ${name_id}    get device policy ID by database    ${policyName}
    ${len}    Get Length    ${devices}
    ${devicesTit}    Set Variable    ${devices[0]}
    : FOR    ${a}    IN RANGE    1    ${len}
    \    ${devicesTit}    Set Variable    ${devicesTit} | ${devices[${a}]}
    ${devicesName}    Set Variable If    '${len}'>'2'    ${devices[0]} | ${devices[1]} ……    '${len}'=='2'    ${devices[0]} | ${devices[1]}    '${len}'=='1'
    ...    ${devices[0]}
    verify element text    //a[contains(@onclick,'editPolicy(${name_id})')]/../../td[3]    ${devicesName}
    verify element title attribute value    //a[contains(@onclick,'editPolicy(${name_id})')]/../../td[3]    ${devicesTit}
    verify element text    //a[contains(@onclick,'editPolicy(${name_id})')]/../../td[4]    ${len}

verify device policy device error msg
    [Arguments]    ${msg}
    [Documentation]    验证选择设备错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${dply_create_device_error_ID}
    Element Text Should Be    ${dply_create_device_error_ID}    ${msg}

verify device policy name by UI
    [Arguments]    ${policyName}
    [Documentation]    在设备策略管理界面上验证策略名称
    ...    参数：设备策略名称
    into device policy manage UI
    Table Column Should Contain    ${public_table_ID}    1    ${policyName}

verify device policy name error msg
    [Arguments]    ${msg}
    [Documentation]    验证设备策略名称错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${dply_create_name_error_ID}
    Element Text Should Be    ${dply_create_name_error_ID}    ${msg}

verify device policy type by UI
    [Arguments]    ${policyName}    ${type}
    [Documentation]    在设备策略管理界面验证策略类型
    ...    参数：1.设备策略名称；2.设备策略类型
    into device policy manage UI
    ${name_id}    get device policy ID by database    ${policyName}
    Element Should Contain    //a[contains(@onclick,'editPolicy(${name_id})')]/../../td[2]    ${type}
