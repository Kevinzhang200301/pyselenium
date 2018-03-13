*** Settings ***
Resource          ../PublicKeywords.robot
Resource          ../../ElementLocators/ResourceElementID.robot
Resource          ../PolicyManage/DevicePolicyKeywords.robot
Variables         ../../TestData/ResourceTestData.py

*** Keywords ***
clear env for edit device
    [Documentation]    清空编辑设备测试环境：1.删除设备策略；2.删除设备；3.关闭浏览器
    delete all device policy by UI
    delete all device by UI
    close browser and kill chrome process

click create device button
    [Documentation]    点击新建设备按钮
    Click Element    ${device_create_button_ID}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${device_create_name_input_ID}

click delete device button
    [Arguments]    ${deviceName}
    [Documentation]    点击删除设备按钮
    ...    参数：设备名称
    ${nameId}    get device id by database    ${deviceName}
    Click Element    //a[contains(@onclick,'deleteDevice(${nameId})')]

click edit device button
    [Arguments]    ${deviceName}
    [Documentation]    点击编辑设备按钮
    ...    参数：设备名称
    ${nameId}    get device id by database    ${deviceName}
    Click Element    //a[contains(@onclick,'editDevice(${nameId})')]
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${device_create_name_input_ID}

create right device by UI
    [Arguments]    ${deviceName}
    [Documentation]    正确创建一个简单的设备
    ...    参数：设备名称
    into device manage UI
    click create device button
    input device name    ${deviceName}
    input device vid    ${defaultNameTD}
    input device pid    ${defaultNameTD}
    click save button    True
    verify device exist on the UI    ${deviceName}

delete all device by UI
    [Documentation]    在数据库中删除所有设备(除默认设备外)
    into device manage UI
    ${len}    get rows of database table    SELECT * FROM policy_resource_device WHERE id>12;
    : FOR    ${i}    IN RANGE    ${len}
    \    ${element}    Get Webelement    //a[contains(@onclick,'deleteDevice')]
    \    Wait Until Element Is Enabled    ${element}
    \    Click Element    ${element}
    \    click confirm box confirm button
    \    Select Frame    ${device_manage_iframe_ID}

get device id by database
    [Arguments]    ${deviceName}
    [Documentation]    在数据库中获取设备的ID
    ...    参数：设备名称
    ${nameId}    get return value of the database query
    ...    SELECT id FROM policy_resource_device WHERE device_name='${deviceName}';
    [Return]    ${nameId}

input device description
    [Arguments]    ${des}
    [Documentation]    输入设备描述
    ...    参数：设备描述信息
    Clear Element Text    ${device_create_des_ID}
    Input Text    ${device_create_des_ID}    ${des}
    Sleep    ${inputSleep}    

input device name
    [Arguments]    ${deviceName}
    [Documentation]    输入设备名称
    ...    参数：设备名称
    Clear Element Text    ${device_create_name_input_ID}
    Input Text    ${device_create_name_input_ID}    ${deviceName}
    Sleep    ${inputSleep}

input device pid
    [Arguments]    ${pid}
    [Documentation]    输入产品ID
    ...    参数：产品PID
    Clear Element Text    ${device_create_pid_input_ID}
    Input Text    ${device_create_pid_input_ID}    ${pid}
    Sleep    ${inputSleep}
    
input device tag
    [Arguments]    ${tag}
    [Documentation]    输入设备标签
    ...    参数：设备标签
    Clear Element Text    ${device_create_tag_input_ID}
    Input Text    ${device_create_tag_input_ID}    ${tag}

input device vid
    [Arguments]    ${vid}
    [Documentation]    输入厂商ID
    ...    参数：厂商VID
    Clear Element Text    ${device_create_vid_input_ID}
    Input Text    ${device_create_vid_input_ID}    ${vid}
    Sleep    ${inputSleep}

input search device name
    [Arguments]    ${deviceName}
    [Documentation]    输入搜索的设备名称
    ...    参数：设备名称
    open the search UI
    Clear Element Text    ${device_search_input_ID}
    Input Text    ${device_search_input_ID}    ${deviceName}
    Sleep    ${inputSleep}

into device manage UI
    [Documentation]    进入到设备管理界面
    refresh page
    Wait Until Element Is Enabled    ${resource_manage_ID}
    Click Element    ${resource_manage_ID}
    Wait Until Element Is Visible    ${device_menu_ID}
    Click Element    ${device_menu_ID}
    Wait Until Element Is Visible    ${device_manage_UI_ID}
    Select Frame    ${device_manage_iframe_ID}
    Wait Until Element Is Visible    ${device_create_button_ID}

prepare env for edit device
    [Documentation]    为编辑设备测试准备环境：1.admin用户登录；2.创建设备；3.创建设备策略
    login by admin
    create right device by UI    ${defaultNameTD}
    : FOR    ${name}    IN    @{searchNameList}
    \    create right device by UI    ${name}
    create right device by UI    ${editNameTD}
    create right device by UI    ${deleteNameTD}
    create right device policy    ${defaultNameTD}    deviceName=${defaultNameTD}   
    
select device type
    [Arguments]    ${typeName}
    [Documentation]    选择设备类型
    ...    参数：设备类型
    Select From List By Label    ${device_create_type_input_ID}    ${typeName}
    Sleep    ${selectSleep}
    List Selection Should Be    ${device_create_type_input_ID}    ${typeName}    

verify create device UI info
    [Documentation]    验证新建设备界面信息
    verify same element text by UI    ${layui_label_ID}    @{deviceUI['labelList']}
    verify input box character limit    ${device_create_name_input_ID}    ${deviceUI['len1']}
    verify input box character limit    ${device_create_tag_input_ID}    ${deviceUI['len1']}
    ${a}    Get List Items    ${device_create_type_input_ID}
    Lists Should Be Equal    ${a}    ${deviceUI['typeList']}
    verify input box character limit    ${device_create_pid_input_ID}    ${deviceUI['len1']}
    verify input box character limit    ${device_create_vid_input_ID}    ${deviceUI['len1']}
    verify lay UI title info    ${deviceUI['title2']}    

verify device creater on the UI
    [Arguments]    ${deviceName}    ${creater}
    [Documentation]    界面上验证某设备的创建人
    ...    参数：1.设备名称；2.创建人
    into device manage UI
    ${deviceId}    get device id by database    ${deviceName}
    Element Should Contain    //a[contains(@onclick,'editDevice(${deviceId})')]/../../td[5]    ${creater}

verify device exist on the UI
    [Arguments]    ${deviceName}
    [Documentation]    验证界面上已存在某设备
    ...    参数：设备名称
    into device manage UI
    Table Column Should Contain    ${public_table_ID}    1    ${deviceName}

verify device manage UI info
    [Documentation]    验证设备管理界面其他信息
    verify same element text by UI    ${public_table_head}    @{deviceUI['tableH']}
    verify element value attribute value    ${device_create_button_ID}    ${deviceUI['title2']}
    verify element title attribute value    ${device_create_button_ID}    ${deviceUI['title4']}
    verify element title attribute value    //a[contains(@onclick,'editDevice')]    ${deviceUI['title5']}
    verify element title attribute value    //a[contains(@onclick,'deleteDevice')]    ${deviceUI['title6']}
    open the search UI
    verify element text    ${device_search_label_ID}    ${deviceUI['srcLabel']}
    verify element text    ${public_manage_title_ID}    ${deviceUI['title1']}
    Unselect Frame
    verify element text    ${device_tab_ID}    ${deviceUI['title1']}

verify device manage default device info
    [Documentation]    验证设备管理界面默认设备信息
    Table Cell Should Contain    ${public_table_ID}    3    1    ${deviceUI['NameD1']}
    Table Cell Should Contain    ${public_table_ID}    4    1    ${deviceUI['NameD2']}
    Table Cell Should Contain    ${public_table_ID}    5    1    ${deviceUI['NameD3']}
    Table Cell Should Contain    ${public_table_ID}    3    2    ${deviceUI['typeD1']}
    Table Cell Should Contain    ${public_table_ID}    4    2    ${deviceUI['typeD1']}
    Table Cell Should Contain    ${public_table_ID}    5    2    ${deviceUI['typeD2']}
    Table Cell Should Contain    ${public_table_ID}    -1    3    ${noMessage}
    Table Cell Should Contain    ${public_table_ID}    -1    4    ${noMessage}

verify device name error info
    [Arguments]    ${msg}
    [Documentation]    验证设备名称错误提示信息
    ...    参数：错误信息
    Wait Until Element Is Visible    ${device_create_name_error_ID}
    Element Text Should Be    ${device_create_name_error_ID}    ${msg}

verify device pid error info
    [Arguments]    ${msg}
    [Documentation]    验证产品ID错误提示信息
    ...    参数：错误信息
    Wait Until Element Is Visible    ${device_create_pid_error_ID}
    Element Text Should Be    ${device_create_pid_error_ID}    ${msg}

verify device pid on the UI
    [Arguments]    ${deviceName}    ${pid}
    [Documentation]    界面上验证某设备的产品ID
    ...    参数：1.设备名称；2.产品PID
    into device manage UI
    ${deviceId}    get device id by database    ${deviceName}
    Element Should Contain    //a[contains(@onclick,'editDevice(${deviceId})')]/../../td[4]    ${pid}

verify device type on the UI
    [Arguments]    ${deviceName}    ${type}
    [Documentation]    界面上验证某设备的设备类型
    ...    参数：1.设备名称；2.设备类型
    into device manage UI
    ${deviceId}    get device id by database    ${deviceName}
    Element Should Contain    //a[contains(@onclick,'editDevice(${deviceId})')]/../../td[2]    ${type}

verify device vid error info
    [Arguments]    ${msg}
    [Documentation]    验证厂商ID错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${device_create_vid_error_ID}
    Element Text Should Be    ${device_create_vid_error_ID}    ${msg}

verify device vid on the UI
    [Arguments]    ${deviceName}    ${vid}
    [Documentation]    界面上验证某设备的厂商ID
    ...    参数：1.设备名称；2.厂商VID
    into device manage UI
    ${deviceId}    get device id by database    ${deviceName}
    Element Should Contain    //a[contains(@onclick,'editDevice(${deviceId})')]/../../td[3]    ${vid}
