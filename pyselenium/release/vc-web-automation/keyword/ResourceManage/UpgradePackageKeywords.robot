*** Settings ***
Resource          ../PublicKeywords.robot
Resource          ../../ElementLocators/ResourceElementID.robot
Variables         ../../TestData/ResourceTestData.py

*** Keywords ***
clear env for edit patch
    [Documentation]    情况编辑升级包环境
    delete all patch by UI
    close browser and kill chrome process

click delete patch button
    [Arguments]    ${packageName}
    [Documentation]    点击删除升级包按钮
    ...    参数：升级包名称
    ${nameId}    get patch name ID by database    ${packageName}
    Click Element    //a[contains(@onclick,'deletePatch(${nameId})')]

click download patch button
    [Arguments]    ${packageName}
    [Documentation]    点击下载升级包按钮
    ...    参数：升级包名称
    ${nameId}    get patch name ID by database    ${packageName}
    Click Element    //a[contains(@onclick,'downloadPatch(${nameId})')]

click edit patch button
    [Arguments]    ${packageName}
    [Documentation]    点击编辑升级包按钮
    ...    参数：升级包名称
    ${nameId}    get patch name ID by database    ${packageName}
    Click Element    //a[contains(@onclick,'editPatch(${nameId})')]
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${up_package_name_input_ID}

click upload button
    [Documentation]    点击上传按钮
    Wait Until Element Is Enabled    ${up_package_upButton_ID}
    Click Element    ${up_package_upButton_ID}

click upload patch button
    [Documentation]    点击升级包管理界面上传升级包按钮
    Click Element    ${up_upPackage_button_ID}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${up_package_name_input_ID}

delete all patch by UI
    [Documentation]    在界面上删除升级包
    into patch manage UI
    ${len}    get rows of database table    SELECT id FROM resource_vtop_patch;
    : FOR    ${i}    IN RANGE    ${len}
    \    ${element}    Get Webelement    //a[contains(@onclick,'delete')]
    \    Wait Until Element Is Enabled    ${element}
    \    Click Element    ${element}
    \    click confirm box confirm button
    \    Select Frame    ${up_package_iframe_ID}

get patch name ID by database
    [Arguments]    ${packageName}
    [Documentation]    在数据库中获取升级包的ID
    ...    参数：升级包名称   
    ${nameId}    get return value of the database query
    ...    SELECT id FROM resource_vtop_patch WHERE NAME='${packageName}';
    [Return]    ${nameId}

input patch description
    [Arguments]    ${des}
    [Documentation]    在升级包上传界面输入说明
    ...    参数：升级包说明字段
    Clear Element Text    ${up_package_des_input_ID}
    Input Text    ${up_package_des_input_ID}    ${des}
    Sleep    ${inputSleep}    

input patch name
    [Arguments]    ${name}
    [Documentation]    在升级包上传界面输入升级包名称
    Clear Element Text    ${up_package_name_input_ID}
    Input Text    ${up_package_name_input_ID}    ${name}

input patch version
    [Arguments]    ${version}
    [Documentation]    在升级包上传界面输入版本号
    ...    参数：升级版本号
    Clear Element Text    ${up_package_version_input_ID}
    Input Text    ${up_package_version_input_ID}    ${version}
    Sleep    ${inputSleep}

into patch manage UI
    [Documentation]    进入到升级包管理界面
    refresh page
    Wait Until Element Is Enabled    ${resource_manage_ID}
    Click Element    ${resource_manage_ID}
    Wait Until Element Is Visible    ${up_menu_ID}
    Click Element    ${up_menu_ID}
    Wait Until Element Is Visible    ${up_UI_ID}
    Select Frame    ${up_package_iframe_ID}
    Wait Until Element Is Visible    ${up_upPackage_button_ID}

prepare env for edit patch
    [Documentation]    为测试编辑升级包准备环境
    login by admin
    up right patch by UI    ${patchTD['name']}
    up right patch by UI    ${patchTD['editN']}

up right patch by UI
    [Arguments]    ${patchName}
    [Documentation]    正确上传升级包
    ...    参数：升级包名称
    into patch manage UI
    click upload patch button
    Choose File    ${up_package_choose_ID}    ${patchTD['ritPatch']}
    click upload button
    wait until file upload down    
    input patch name    ${patchName}
    click save button    True
    verify lobibox info    

verify patch error info
    [Arguments]    ${msg}
    [Documentation]    验证升级包错误时
    ...    参数：错误提示
    Wait Until Element Is Visible    ${public_upFile_prompt}
    :FOR    ${i}    IN RANGE    10
    \    Sleep    1
    \    ${txt}    Get Text    ${public_upFile_prompt}
    \    Exit For Loop If    '${txt}'!='${upFile['msg3']}'    
    Element Text Should Be    ${public_upFile_prompt}    ${msg}

verify patch manage UI info
    [Documentation]    验证升级包管理界面其他信息
    verify same element text by UI    ${public_table_head}    @{patchUI['tableHead']}
    verify element value attribute value    ${up_upPackage_button_ID}    ${patchUI['button1']}
    verify element title attribute value    ${up_upPackage_button_ID}    ${patchUI['title4']}
    verify element title attribute value    //a[contains(@onclick,'editPatch')]    ${patchUI['title5']}
    verify element title attribute value    //a[contains(@onclick,'delete')]    ${patchUI['title6']}
    verify element title attribute value    //a[contains(@onclick,'downloadPatch')]    ${patchUI['title7']}
    verify element text    ${public_manage_title_ID}    ${patchUI['title1']}
    Unselect Frame
    verify element text    ${up_tab_ID}    ${patchUI['title1']}

verify patch name exist by UI
    [Arguments]    ${patchName}
    [Documentation]    验证升级包已在界面上
    ...    参数：升级包名称
    into patch manage UI
    Table Column Should Contain    ${public_table_ID}    1    ${patchName}

verify patch version by UI
    [Arguments]    ${patchName}    ${version}
    [Documentation]    在界面上验证升级包的版本号
    ...    参数：1.升级包名称；2.升级包版本号
    into patch manage UI
    ${nameId}    get patch name ID by database    ${patchName}
    Element Should Contain    //a[contains(@onclick,'deletePatch(${nameId})')]/../../td[3]    ${version}

verify path name error info
    [Arguments]    ${msg}
    [Documentation]    验证升级包名称错误时提示信息
    ...    参数：错误信息
    Wait Until Element Is Visible    ${up_package_name_err_ID}
    Element Text Should Be    ${up_package_name_err_ID}    ${msg}

verify path version error info
    [Arguments]    ${msg}
    [Documentation]    验证升级版本错误时提示信息
    ...    参数：错误信息
    Wait Until Element Is Visible    ${up_package_version_err_ID}
    Element Text Should Be    ${up_package_version_err_ID}    ${msg}

verify up patch UI info
    [Documentation]    验证上传升级包界面表单信息
    verify same element text by UI    ${up_package_label_ID}    @{patchUI['upLabelList']}
    verify input box character limit    ${up_package_name_input_ID}    ${patchUI['length1']}
    verify input box character limit    ${up_package_version_input_ID}    ${patchUI['length2']}
    verify lay UI title info    ${patchUI['title2']}    

verify up patch UI not exist
    [Documentation]    验证升级包界面不存在
    Unselect Frame
    Wait Until Element Is Not Visible    ${layui_title_ID}
    Select Frame    ${up_package_iframe_ID}
    Wait Until Element Is Visible    ${up_upPackage_button_ID}