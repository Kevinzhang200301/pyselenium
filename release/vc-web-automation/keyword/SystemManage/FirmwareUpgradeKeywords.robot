*** Settings ***
Resource          ../../ElementLocators/SystemManageElementID.robot
Resource          ../PublicKeywords.robot
Variables         ../../TestData/SystemManage.py

*** Keywords ***
choose vTopCenter iso path
    [Arguments]    ${filePath}
    [Documentation]    在上传升级包界面选择升级包路径
    ...    参数：升级包路径
    Choose File    ${vcup_patch_choose_ID}    ${filePath}

clear env for edit vc package
    [Documentation]    清空编辑vTopCenter的测试环境：1.删除升级包；2.关闭浏览器
    delete all vc upgrade package by UI
    close browser and kill chrome process

click delete vc package button
    [Arguments]    ${patchName}
    [Documentation]    点击删除vTopCenter升级包按钮
    ...    参数：升级包名称
    ${nameId}    get vTopCenter package ID by database    ${patchName}
    Click Element    //a[contains(@onclick,'delVC(${nameId})')]

click download vc package button
    [Arguments]    ${patchName}
    [Documentation]    点击下载vTopCenter升级包按钮
    ...    参数：升级包名称
    ${nameId}    get vTopCenter package ID by database    ${patchName}
    Click Element    //a[contains(@onclick,'downloadVC(${nameId})')]

click edit vc package button
    [Arguments]    ${patchName}
    [Documentation]    点击编辑vTopCenter升级包按钮
    ...    参数：升级包名称
    ${nameId}    get vTopCenter package ID by database    ${patchName}
    Click Element    //a[contains(@onclick,'editVC(${nameId})')]
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${vcup_patch_name_input_ID}

click restart vc button
    [Documentation]    点击vTopCenter重启按钮
    Click Element    ${vcup_restart_button_ID}

click set vc date button
    [Documentation]    点击设置vTopCenter时间按钮
    Click Element    ${vcup_setDate_button_ID}
    Wait Until Element Is Visible    ${vcup_setDate_title_ID}

click shutdown vc button
    [Documentation]    点击vTopCenter关机按钮
    Click Element    ${vcup_shutdown_button_ID}

click upgrade vc button
    [Documentation]    点击vTopCenter升级按钮
    Click Element    ${vcup_upgrade_button_ID}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${vcup_upgrade_patchName_ID}

click upload button of upgrade vc package UI
    [Documentation]    点击vTopCenter上传升级包界面上传按钮
    Wait Until Element Is Visible    ${vcup_patch_upload_button_ID}
    Click Element    ${vcup_patch_upload_button_ID}

click upload vc upgrade package button
    [Documentation]    点击固件升级管理界面上传升级包按钮
    Click Element    ${vcup_upPatch_button_ID}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${vcup_patch_name_input_ID}

create right vc uploade iso by UI
    [Arguments]    ${patchName}
    [Documentation]    创建正确的vTopCenter升级包
    ...    参数：升级包名称
    into firmware upgrade manage UI
    click upload vc upgrade package button
    choose vTopCenter iso path    ${vcupTD['fileR']}
    click upload button of upgrade vc package UI
    wait until file upload down    
    input upgrade package name    ${patchName}
    click save button    True
    verify vc package name on the UI    ${patchName}

delete all vc upgrade package by UI
    [Documentation]    在界面上删除所有的vTopCenter升级包
    into firmware upgrade manage UI
    ${len}    get rows of database table    SELECT id FROM system_vcupdate;
    : FOR    ${i}    IN RANGE    ${len}
    \    ${element}    Get Webelement    //a[contains(@onclick,'delVC')]
    \    Wait Until Element Is Enabled    ${element}
    \    Click Element    ${element}
    \    click confirm box confirm button
    \    Select Frame    ${vcup_manage_iframe_ID}

get vTopCenter package ID by database
    [Arguments]    ${name}
    [Documentation]    从数据库中获取vTopCenter升级包的ID
    ${nameId}    get return value of the database query
    ...    SELECT id FROM system_vcupdate WHERE name='${name}';
    [Return]    ${nameId}

input search vc package name
    [Arguments]    ${name}
    [Documentation]    在固件升级管理界面输入搜索vTopCenter升级包名称
    ...    参数：名称
    open the search UI
    Clear Element Text    ${vcup_search_input_ID}
    Input Text    ${vcup_search_input_ID}    ${name}
    Sleep    ${inputSleep}    

input upgrade package name
    [Arguments]    ${patchName}
    [Documentation]    在上传升级包界面上输入升级包名称
    ...    参数：升级包名称
    Clear Element Text    ${vcup_patch_name_input_ID}
    Input Text    ${vcup_patch_name_input_ID}    ${patchName}
    Sleep    ${inputSleep}

into firmware upgrade manage UI
    [Documentation]    进入到固件升级管理界面
    refresh page
    Wait Until Element Is Enabled    ${system_manage_menu_ID}
    Click Element    ${system_manage_menu_ID}
    Wait Until Element Is Visible    ${vcup_menu_ID}
    Click Element    ${vcup_menu_ID}
    Wait Until Element Is Visible    ${vcup_manage_UI_ID}
    Select Frame    ${vcup_manage_iframe_ID}
    Wait Until Element Is Visible    ${vcup_upgrade_button_ID}

prepare env for edit vc package
    [Documentation]    为测试编辑vTopCenter升级包准备环境：1.admin用户登录
    ...    2.上传升级包
    login by admin
    create right vc uploade iso by UI    ${vcupTD['nameD']}
    create right vc uploade iso by UI    ${vcupTD['editD']}
    create right vc uploade iso by UI    ${vcupTD['del']}
    : FOR    ${name}    IN    @{vcupTD['srcName']}
    \    create right vc uploade iso by UI    ${name}

verify firmware upgrade manage other info
    [Documentation]    验证固件升级管理界面其他信息
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@title='${vcupUI['title1']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@title='${vcupUI['title2']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@title='${vcupUI['title3']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@title='${vcupUI['title4']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@title='${vcupUI['title5']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@value='${vcupUI['button1']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@value='${vcupUI['button2']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@value='${vcupUI['button3']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@value='${vcupUI['button4']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@value='${vcupUI['button5']}']
    open the search UI
    Run Keyword And Continue On Failure    verify element text    ${public_search_label_ID}    ${vcupUI['srcLabel']}
    Run Keyword And Continue On Failure    verify element text     ${public_manage_title_ID}    ${vcupUI['title1']}
    Unselect Frame
    verify element text     ${vcup_tab_ID}    ${vcupUI['title1']}

verify firmware upgrade manage table info
    [Documentation]    验证固件升级管理界面table信息
    verify same element text by UI    ${vcup_table_head}    @{vcupUI['tableH']}    
    Run Keyword And Continue On Failure    Element Should Be Visible    //a[@title='${vcupUI['title6']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //a[@title='${vcupUI['title7']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //a[@title='${vcupUI['title8']}']

verify set vc date UI form info
    [Documentation]    验证固件升级管理界面设置时间界面form信息
    Element Should Contain    ${vcup_setDate_title_ID}    ${vcupUI['title10']}
    verify element value attribute value    ${vcup_setDate_confirm_button}    ${vcupUI['button6']}
    verify element value attribute value    ${vcup_setDate_cancel_button}    ${vcupUI['button7']}

verify upgrade vc iso UI form info
    [Documentation]    验证固件升级管理界面上传升级包界面form信息
    Run Keyword And Continue On Failure    verify same element text by UI    //div[@class='form-group']${layui_label_ID}    @{vcupUI['labelL1']}
    verify input box character limit    ${vcup_patch_name_input_ID}    ${vcupUI['len1']}

verify upload vc iso error info
    [Arguments]    ${errMsg}
    [Documentation]    验证上传升级包文件错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${vcup_patch_file_error_ID}
    Element Should Contain    ${vcup_patch_file_error_ID}    ${errMsg}

verify vc package name error info
    [Arguments]    ${errMsg}
    [Documentation]    验证上传升级包名称错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${vcup_patch_name_error_ID}
    verify element text    ${vcup_patch_name_error_ID}    ${errMsg}

verify vc package name on the UI
    [Arguments]    ${patchName}
    [Documentation]    在固件升级管理界面验证升级包名称
    ...    参数：升级包名称
    into firmware upgrade manage UI
    Table Column Should Contain    ${public_table_ID}    1    ${patchName}