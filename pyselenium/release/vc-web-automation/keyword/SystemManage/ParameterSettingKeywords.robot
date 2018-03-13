*** Settings ***
Resource          ../../ElementLocators/SystemManageElementID.robot
Resource          ../PublicKeywords.robot
Variables         ../../TestData/SystemManage.py

*** Keywords ***
click DNS server edit button
    [Documentation]    点击域名服务器IP编辑按钮
    Click Element    ${para_DNSIpEdit_button}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${para_editUI_name_input_ID}

click Upper vTop Center address edit button
    [Documentation]    点击上级vTopCenter地址编辑按钮
    Click Element    ${para_superIpEdit_button}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${para_editUI_name_input_ID}

click hard disk percentage edit button
    [Documentation]    点击主机硬盘使用百分比告警阈值编辑按钮
    Click Element    ${para_disk%Edit_button}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${para_editUI_name_input_ID}

click hard disk size edit button
    [Documentation]    点击主机硬盘剩余大小告警阈值编辑按钮
    Click Element    ${para_diskSizeEdit_button}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${para_editUI_name_input_ID}

click hierarchical manage address edit button
    [Documentation]    点击分级管理地址编辑按钮
    Click Element    ${para_gradeIpEdit_button}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${para_editUI_name_input_ID}

click hierarchical manage key edit button
    [Documentation]    点击分级管理密钥编辑按钮
    Click Element    ${para_gradeKeyEdit_button}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${para_editUI_name_input_ID}

click pool percentage edit button
    [Documentation]    点击存储池使用百分比告警阈值编辑按钮
    Click Element    ${para_pool%Edit_button}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${para_editUI_name_input_ID}

click pool size edit button
    [Documentation]    点击存储池剩余大小告警阈值编辑按钮
    Click Element    ${para_poolSizeEdit_button}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${para_editUI_name_input_ID}

click registered password edit button
    [Documentation]    点击注册密码编辑按钮
    Click Element    ${para_registEdit_button}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${para_editUI_name_input_ID}

click storage pool edit button
    [Documentation]    点击储存池位置编辑按钮
    Click Element    ${para_poolEdit_button}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${para_editUI_name_input_ID}

input parameter value
    [Arguments]    ${value}
    [Documentation]    在编辑参数界面输入参数值
    ...    参数：参数值
    Clear Element Text    ${para_editUI_value_input_ID}
    Input Text    ${para_editUI_value_input_ID}    ${value}
    Sleep    ${inputSleep}    

into parameter setting manage UI
    [Documentation]    进入到参数设置管理界面
    refresh page
    Wait Until Element Is Enabled    ${system_manage_menu_ID}
    Click Element    ${system_manage_menu_ID}
    Wait Until Element Is Visible    ${para_menu_ID}
    Click Element    ${para_menu_ID}
    Wait Until Element Is Visible    ${para_manage_UI_ID}
    Select Frame    ${para_manage_iframe_ID}
    Wait Until Element Is Visible    ${para_gradeIpEdit_button}

restore default parameter value by database
    [Documentation]    还原参数值为默认值  
    : FOR    ${i}    ${j}    IN ZIP    ${parameterUI['nameL'][1:]}
    ...    ${parameterUI['valueL'][1:]}
    \    into parameter setting manage UI
    \    ${id}    get return value of the database query
    ...    SELECT id FROM ulms_enumeration WHERE DESCRIPTION='${i}';
    \    Click Element    //a[contains(@onclick,'enumerationEdit(${id})')]
    \    Unselect Frame
    \    Wait Until Element Is Visible    ${layui_title_ID}
    \    Select Frame    ${layui_iframe_ID}
    \    Wait Until Element Is Visible    ${layui_title2_ID}
    \    input parameter value    ${j}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info            
   
verify parameter edit UI info
    [Arguments]    ${paraName}    ${paraValue}
    [Documentation]    验证参数编辑界面信息
    ...    参数：1.参数名称；2.参数值
    verify lay UI title info    ${parameterUI['title2']}    ${parameterUI['title1']}
    verify same element text by UI    ${layui_label_ID}    @{parameterUI['labelL']}
    ${txt}    Get Element Attribute    ${para_editUI_name_input_ID}@readonly
    Should Be Equal As Strings    ${txt}    true    
    verify element value attribute value    ${para_editUI_name_input_ID}    ${paraName}
    verify element value attribute value    ${para_editUI_value_input_ID}    ${paraValue}
    
verify parameter setting manage UI info
    [Documentation]    验证参数设置管理界面table信息
    verify same element text by UI    ${public_table_head}    @{parameterUI['tableH']}    
    verify same element text by UI    ${para_parameterName_ID}    @{parameterUI['nameL']}
    verify same element text by UI    ${para_parameterValue_ID}    @{parameterUI['valueL']}
    Element Should Be Visible    //tr[@title='${parameterUI['title3']}']
    verify table records current page    10
    verify element text    ${public_manage_title_ID}    ${parameterUI['title1']}
    Unselect Frame
    verify element text    ${para_tab_ID}    ${parameterUI['title1']}

verify parameter value error info
    [Arguments]    ${errMsg}
    [Documentation]    验证参数值错误提示信息
    ...    参数：错误提示信息
    Unselect Frame
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${para_parameterValue_error_ID}
    Element Text Should Be    ${para_parameterValue_error_ID}    ${errMsg}

verify parameter value on the UI
    [Arguments]    ${rows}    ${value}
    [Documentation]    在参数设置界面上验证参数值
    ...    参数：1.在table的第几行；2.参数值的内容
    into parameter setting manage UI
    ${rowsInt}    Convert To Integer    ${rows}
    Table Cell Should Contain    ${public_table_ID}    ${rowsInt+1}    2    ${value}
