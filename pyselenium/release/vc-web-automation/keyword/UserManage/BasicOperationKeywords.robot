*** Settings ***
Resource          UserKeywords.robot
Resource          ../PolicyManage/UserPolicyKeywords.robot

*** Keywords ***
click confirm button on confige userpolicy UI
    [Documentation]    在配置用户策略界面上点击确定按钮
    Wait Until Element Is Visible    ${tuser_policy_confirm_button_ID}
    Click Element    ${tuser_policy_confirm_button_ID}

click cancel button on confige userPolicy UI
    [Documentation]    在配置用户策略界面点击取消按钮
    Wait Until Element Is Visible    ${tuser_policy_cancel_button_ID}
    Click Element    ${tuser_policy_cancel_button_ID}
    
click change usergroup button
    [Arguments]    ${status}=True
    [Documentation]    在基础操作里面选择更换用户组
    ...    参数：点击更换用户组按钮后是否有layer界面(默认有)
    click Basics button
    Click Element    ${tuser_basis_changegroup_ID}    
    :FOR    ${i}    IN RANGE    1
    \    Exit For Loop If    '${status}'!='True'
    \    Unselect Frame
    \    Wait Until Element Is Visible    ${layui_title_ID}
    \    Select Frame    ${layui_iframe_ID}
    \    Wait Until Element Is Visible    ${layui_title2_ID}    
    
click import user button
    [Documentation]    在基础操作里面选择导入用户
    click Basics button
    Click Element    ${tuser_basis_import_ID}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${layui_title2_ID}

click change usergroup clear button
    [Documentation]    点击更换用户组界面上清空按钮
    Click Element    ${tuser_group_clear_button_ID}
    Sleep    ${clickSleep}    

click userpolicy button
    [Arguments]    ${status}=True
    [Documentation]    在基础操作里面选择用户策略
    ...    参数：点击用户策略按钮后是否有layer界面(默认有)
    click Basics button
    Click Element    ${tuser_basis_policy_ID}
    :FOR    ${i}    IN RANGE    1
    \    Exit For Loop If    '${status}'!='True'
    \    Unselect Frame
    \    Wait Until Element Is Visible    ${layui_title_ID}
    \    Select Frame    ${layui_iframe_ID}
    \    Wait Until Element Is Visible    ${layui_title2_ID}
    
click open user button
    [Documentation]    在基础操作里面选择开通用户
    click Basics button
    Click Element    ${tuser_basis_openuser_ID}

click reset passwrod button
    [Documentation]    在基础操作里面选择重置密码
    click Basics button
    Click Element    ${tuser_basis_resetpwd_ID}

click stop user button
    [Documentation]    在基础操作里面选择停用用户
    click Basics button
    Click Element    ${tuser_basis_stopuser_ID}

select userpolicy on config userpolicy UI
    [Arguments]    ${policyName}
    [Documentation]    在配置用户界面选择某用户策略
    ...    参数：用户策略名称
    ${NameId}    get user policy ID in databse    ${policyName}
    ${idInt}    Convert To String    ${NameId}    
    Select Radio Button    ${tuser_policy_nameattribute}    ${idInt}
    Sleep    ${selectSleep}
    Radio Button Should Be Set To     ${tuser_policy_nameattribute}    ${idInt}

verify import user error msg
    [Arguments]    ${errMsg}
    [Documentation]    导入用户错误提示信息验证
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${tuser_import_error_ID}
    Element Text Should Be    ${tuser_import_error_ID}    ${errMsg}
    
verify change usergroup UI info
    [Documentation]    更换用户组界面信息验证    
    verify same element text by UI    ${tuser_group_heaher_info_ID}    @{userUI['headerH']}    
    verify element text    ${layui_label_ID}    ${userUI['label5']}
    verify element text    ${tuser_group_clear_button_ID}    ${clearButton}
    verify same element text by UI    ${public_table_head}    @{userUI['tableH4']}
    verify lay UI title info    ${userUI['title20']}    
    
verify config userpolicy UI info
    [Arguments]    ${userNumb}=1    ${userName}=None
    [Documentation]    配置用户策略界面信息验证
    ...    参数：1.用户个数(默认为1)，2.用户名称(用户个数为1的时候需要，默认为None)
    verify same element text by UI    ${public_table_head}    ${EMPTY}    @{userUI['tableH3']}
    verify element text    ${tuser_policy_title2_ID}    ${userUI['title19']}
    Run Keyword If    '${userNumb}'=='1'    verify element text    ${tuser_policy_title_userinfo_ID}
    ...    （${userUI['title19-1']}${userName};${userUI['title19-2']}${userTD['realD']};${userUI['title19-3']}${userGroupUI['initName']}）
    Run Keyword If    '${userNumb}'!='1'    verify element text    ${tuser_policy_title_userinfo_ID}    
    ...    ${userUI['title19-4'][:4]}${userTD['realD']}${userUI['title19-4'][4:6]}${userNumb}${userUI['title19-4'][6:]}
    verify element text    ${tuser_policy_confirm_button_ID}    ${confirmButton}
    verify element text    ${tuser_policy_cancel_button_ID}    ${cancelButton}
    verify same element text by UI    ${tuser_policy_default}    ${EMPTY}
    ...    ${policyUI['policyD']}
    ...    ${policyUI['UplyD'][0]} | ${policyUI['UplyD'][1]} ……    3
    verify element title attribute value    ${tuser_policy_default}[3]
    ...    ${policyUI['UplyD'][0]} | ${policyUI['UplyD'][1]} | ${policyUI['UplyD'][2]}

verify import user UI info
    [Documentation]    导入用户界面信息验证
    verify element text    ${layui_label_ID}    ${userUI['label6']}
    verify lay UI title info    ${userUI['title21']}    

prepare env for basic operation
    [Documentation]    测试基础操作准备环境：1.admin用户登录vTopCenter，2.创建用户(密码非默认值)
    ...    3.创建用户组，4.创建用户策略
    login by admin
    create right user by UI    ${userTD['nameD']}    pwd=${userTD['pwdR'][1]}
    :FOR    ${user}    IN    @{userTD['srcName']}
    \    create right user by UI    ${user}    pwd=${userTD['pwdR'][1]}
    create right usergroup by UI    ${userTD['groupD']}
    create right user policy by UI    ${userTD['policyD']}        
        
clear env for basic operation
    [Documentation]    情况基础操作环境：1.删除所有用户，2.删除用户组，3.删除用户策略
    ...    4.关闭浏览器
    delete all user by UI
    delete all usergroup by UI
    delete all userpolicy by UI
    close browser and kill chrome process
    
verify userGroup error info on change userGroup UI
    [Arguments]    ${errMsg}
    [Documentation]    更换用户界面用户组错误提示信息验证
    ...    参数：错误提示信息    
    Wait Until Element Is Visible    ${tuser_group_error_ID}
    verify element text    ${tuser_group_error_ID}    ${errMsg}    
            