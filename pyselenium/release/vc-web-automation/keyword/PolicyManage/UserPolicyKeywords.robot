*** Settings ***
Resource          ../PublicKeywords.robot
Resource          ../../ElementLocators/PolicyElementID.robot
Resource          ../UserManage/BasicOperationKeywords.robot
Variables         ../../TestData/PolicyManage.py

*** Keywords ***
clear env for edit user policy
    [Documentation]    清空编辑用户策略的环境
    delete all user by UI
    delete all userpolicy by UI
    close browser and kill chrome process

click create user policy button
    [Documentation]    在用户策略界面点击新建策略按钮
    Click Button    ${uply_add_button_ID}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${uply_add_policyname_ID}

click delete user policy button
    [Arguments]    ${policyName}
    [Documentation]    点击删除策略按钮
    ...    参数：用户策略名称
    ${policyID}    get user policy ID in databse    ${policyName}
    Click Element    //a[contains(@onclick,'delUserdata(${policyID})')]

click edit user policy button
    [Arguments]    ${policyName}
    [Documentation]    点击编辑策略按钮
    ...    参数：用户策略名称
    ${policyID}    get user policy ID in databse    ${policyName}
    Click Element    //a[contains(@onclick,'editUserdata(${policyID})')]
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${uply_add_policyname_ID}

create right user policy by UI
    [Arguments]    ${policyName}    ${ruleNum}=1
    [Documentation]    在用户策略管理界面创建用户策略
    ...    参数:1.创建用户策略名称；2.用户规则个数(默认为1，最多为8)
    into userpolicy manage UI
    click create user policy button
    input user policy name    ${policyName}
    select user policy    @{policyUI['ruleL'][:${ruleNum}]}
    click save button    True
    verify lobibox info

delete all userpolicy by UI
    [Documentation]    删除所有的用户策略（不包括默认策略）
    into userpolicy manage UI
    ${len}    get rows of database table    SELECT * FROM policy_policy_userdata WHERE id>1;
    : FOR    ${i}    IN RANGE    ${len}
    \    ${element}    Get Webelement    //a[contains(@onclick,'delUserdata')]
    \    Wait Until Element Is Enabled    ${element}
    \    Click Element    ${element}
    \    click confirm box confirm button
    \    Select Frame    ${uply_manage_iframe_ID}

get userPolicy title from rules
    [Arguments]    @{rules}
    [Documentation]    从用户策略规则获取用户策略的title
    ...    参数：用户策略规则集合(list)
    ${len}    Get Length    ${rules}
    ${title}    Set Variable    ${rules[0]}
    :FOR    ${i}    IN RANGE    1    ${len}
    \    ${title}    Set Variable    ${title} | ${rules[${i}]}
    [Return]    ${title}

get user policy ID in databse
    [Arguments]    ${policy_name}
    [Documentation]    获取数据库中用户策略的ID，参数为用户策略的名字
    ${mysql_name_id}    get return value of the database query
    ...    select id from policy_policy_userdata where policy_name='${policy_name}';
    [Return]    ${mysql_name_id}

input search user policy name
    [Arguments]    ${policyName}
    [Documentation]    输入要搜索的用户策略名字
    ...    参数：搜索用户策略内容
    open the search UI
    Clear Element Text    ${uply_search_input_ID}
    Input Text    ${uply_search_input_ID}    ${policyName}
    Sleep    ${inputSleep}    

input user policy description
    [Arguments]    ${text}
    [Documentation]    在用户策略界面中输入策略说明
    ...    参数：用户策略描述信息
    Clear Element Text    ${uply_add_desc_input_ID}
    Input Text    ${uply_add_desc_input_ID}    ${text}
    Sleep    ${inputSleep}

input user policy name
    [Arguments]    ${userpolicy_name}
    [Documentation]    输入用户策略的名字
    ...    参数：用户策略名称
    Clear Element Text    ${uply_add_policyname_ID}
    Input Text    ${uply_add_policyname_ID}    ${userpolicy_name}
    Sleep    ${inputSleep}

into userpolicy manage UI
    [Documentation]    进入到用户策略管理界面
    refresh page
    Wait Until Element Is Enabled    ${policy_manage_button_ID}
    Click Element    ${policy_manage_button_ID}
    Wait Until Element Is Visible    ${uply_manage_button_ID}
    Click Element    ${uply_manage_button_ID}
    Wait Until Element Is Visible    ${uply_tab_ID}
    Select Frame    ${uply_manage_iframe_ID}
    Wait Until Element Is Visible    ${uply_add_button_ID}

prepare env for edit user policy
    [Documentation]    为测试编辑用户策略准备环境
    login by admin
    create right user policy by UI    ${defaultNameTD}
    create right user policy by UI    ${deleteNameTD}
    create right user policy by UI    ${editNameTD}
    : FOR    ${name}    IN    @{searchNameList}
    \    create right user policy by UI    ${name}
    create right user by UI    ${defaultNameTD}
    into user management UI
    select user on the user manage UI    ${defaultNameTD}
    click userpolicy button
    select userpolicy on config userpolicy UI    ${defaultNameTD}
    click confirm button on confige userpolicy UI
    verify lobibox info    

select user policy
    [Arguments]    @{policyName}
    [Documentation]    选择具体的策略
    ...    参数：用户策略的中文名称(可一个或多个)
    : FOR    ${name}    IN    @{policy_name}
    \    ${tag}    get userPolicy tag in database    ${name}
    \    Click Element    //li[contains(@id,'selectable') and @title='${tag}']
    \    Wait Until Element Is Not Visible    //li[contains(@id,'selectable') and @title='${tag}']    
    \    Wait Until Element Is Visible    //li[contains(@id,'selection') and @title='${tag}']

get userPolicy tag in database
    [Arguments]    ${policyName}
    [Documentation]    在数据库中获取用户策略的英文tag
    ...    参数：用户策略的名称
    ${tag}    get return value of the database query
    ...    SELECT userdata_tag FROM policy_resource_userdata WHERE userdata_name='${policyName}';
    [Return]    ${tag}

unselect all userpolicy
    [Documentation]    清空所有勾选的策略    
    ${elements}    Get Webelements    ${uply_add_no_select_policy}
    ${len}    Get Length    ${elements}
    @{elementsRule}    Create List    ${EMPTY}
    :FOR    ${i}    IN RANGE    1
    \    Exit For Loop If    '${len}'=='10'
    \    ${elementsRule}    Get Webelements    ${uply_add_selected_policy}
    Run Keyword If    '${len}'=='10'    Append To List    ${elementsRule}    10
    : FOR    ${rule}    IN    @{elementsRule}
    \    Exit For Loop If    '${len}'=='10'   
    \    Click Element    ${rule}
    \    Wait Until Element Is Not Visible    ${rule}

unselect user policy
    [Arguments]    @{policy_name}
    [Documentation]    去掉某策略，
    ...    参数：策略名称(list)
    : FOR    ${name}    IN    @{policy_name}
    \    ${tag}    get userPolicy tag in database    ${name}
    \    Click Element    //li[contains(@id,'selection') and @title='${tag}']
    \    Wait Until Element Is Not Visible    //li[contains(@id,'selection') and @title='${tag}']    
    \    Wait Until Element Is Visible    //li[contains(@id,'selectable') and @title='${tag}']

verify create user policy UI not exist
    [Documentation]    验证创建用户策略界面不存在
    Unselect Frame
    Element Should Not Be Visible    ${layui_save_button_ID}
    Select Frame    ${uply_manage_iframe_ID}
    Element Should Be Visible    ${uply_add_button_ID}

verify no rules on userPolicy manage UI
    [Arguments]    ${policyName}
    [Documentation]    在用户策略管理界面验证没有用户规则信息
    ...    参数：用户策略名称
    into userpolicy manage UI
    ${nameId}    get user policy ID in databse    ${policyName}
    verify element text    //a[contains(@onclick,'editUserdata(${nameId})')]/../../td[2]
    ...    ${policyUI['noRule']}
    verify element title attribute value    //a[contains(@onclick,'editUserdata(${nameId})')]/../../td[2]
    ...    ${policyUI['title15']}
    verify element text    //a[contains(@onclick,'editUserdata(${nameId})')]/../../td[3]    0

verify user policy manage UI info
    [Documentation]    验证用户策略管理界面信息
    verify same element text by UI    ${public_table_head}    @{policyUI['tableH3']}    
    ${len}    get current table record number
    verify element text    //tbody/tr[${len}]/td[1]    ${policyUI['policyD']}
    verify element text    //tbody/tr[${len}]/td[2]    ${policyUI['UplyD'][0]} | ${policyUI['UplyD'][1]} ……
    verify element title attribute value    //tbody/tr[${len}]/td[2]
    ...    ${policyUI['UplyD'][0]} | ${policyUI['UplyD'][1]} | ${policyUI['UplyD'][2]} 
    verify element text    //tbody/tr[${len}]/td[3]    3   
    verify element title attribute value    ${uply_manage_table_rule}    ${policyUI['title16']}
    verify element title attribute value    //a[contains(@onclick,'delUserdata')]    ${policyUI['title11']}
    verify element title attribute value    //a[contains(@onclick,'editUserdata')]    ${policyUI['title10']}
    verify element value attribute value    ${uply_add_button_ID}    ${policyUI['button1']}
    verify element title attribute value    ${uply_add_button_ID}    ${policyUI['title9']}
    open the search UI
    verify element text    ${public_search_label_ID}    ${policyUI['srcBar']}
    verify element text    ${public_manage_title_ID}    ${policyUI['title8']}
    Unselect Frame
    verify element text    ${uply_tab_ID}    ${policyUI['title8']}

verify user policy name by UI
    [Arguments]    ${policy_name}
    [Documentation]    验证用户策略管理界面包含某策略名称
    ...    参数：用户策略名称
    into userpolicy manage UI
    Table Column Should Contain    ${public_table_ID}    1    ${policy_name}

verify user policy name error msg
    [Arguments]    ${msg}
    [Documentation]    验证用户策略名称错误提示信息
    ...    参数：错误信息
    Wait Until Element Is Visible    ${uply_add_name_error_ID}
    Element Text Should Be    ${uply_add_name_error_ID}    ${msg}

verify user policy number by UI
    [Arguments]    ${policyName}    ${policyNumber}
    [Documentation]    在用户策略管理界面验证规则数量
    ...    参数：1.用户策略名称；2.规则数量
    ${policyID}    get user policy ID in databse    ${policyName}
    verify element text    //a[contains(@onclick,'editUserdata(${policyID})')]/../../td[3]
    ...     ${policyNumber}    

verify user policy rule by UI
    [Arguments]    ${policyName}    @{ruleName}
    [Documentation]    在用户策略管理界面验证某用户策略的用户规则
    ...    参数：1.用户策略名称；2.用户规则
    into userpolicy manage UI
    ${policyID}    get user policy ID in databse    ${policyName}
    ${len}    Get Length    ${ruleName}
    ${title}    Set Variable    ${ruleName[0]}
    :FOR    ${i}    IN RANGE    1    ${len}
    \    ${title}    Set Variable    ${title} | ${ruleName[${i}]}    
    verify element title attribute value    //a[contains(@onclick,'editUserdata(${policyID})')]/../../td[2]
    ...    ${title}
    ${displayTxt}    Set Variable If    '${len}'>'2'    ${ruleName[0]} | ${ruleName[1]} ……
    ...    '${len}'=='2'    ${ruleName[0]} | ${ruleName[1]}
    ...    '${len}'=='1'    ${ruleName[0]}    
    verify element text    //a[contains(@onclick,'editUserdata(${policyID})')]/../../td[2]
    ...    ${displayTxt}
    verify element text    //a[contains(@onclick,'editUserdata(${policyID})')]/../../td[3]    ${len}
    
verify user policy rule error msg
    [Arguments]    ${msg}
    [Documentation]    验证用户规则错误提示信息
    ...    参数：错误信息
    Wait Until Element Is Visible    ${uply_add_rule_error_ID}
    Element Text Should Be    ${uply_add_rule_error_ID}    ${msg}

verify create userPolicy UI info
    [Documentation]    新建用户策略界面信息验证
    verify same element text by UI    ${layui_label_ID}    @{policyUI['labelL2'][:2]}
    ...    ${EMPTY}    ${EMPTY}    @{policyUI['labelL2'][2:]}
    verify same element text by UI    ${uply_add_selectRule_label}
    ...    @{policyUI['labelL3']}
    verify input box character limit    ${uply_add_policyname_ID}
    ...    ${policyUI['len1']}
    verify same element text by UI    ${uply_add_no_select_policy}
    ...    @{policyUI['ruleL']}
    verify lay UI title info    ${policyUI['title13']}    