*** Settings ***
Resource          ../../ElementLocators/UserElementID.robot
Resource          ../PublicKeywords.robot
Resource          UserKeywords.robot
Variables         ../../TestData/UserManage.py

*** Keywords ***
clear env for edit usergroup
    [Documentation]    清空用户组测试环境:1.删除所有用户，2.删除所有用户组，3.关闭浏览器
    delete all user by UI
    delete all usergroup by UI
    close browser and kill chrome process

click create usergroup button
    [Documentation]    在用户组管理界面点击新建用户组按钮
    Click Element    ${ugrp_add_button_ID}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${layui_title2_ID}

click usergroup delete button
    [Arguments]    ${groupName}
    [Documentation]    根据用户组名点击删除按钮
    ...    参数：用户组名称
    ${name_id}    get usergroup name ID in database    ${groupName}
    Click Element    //a[contains(@onclick,'orgDelete(${name_id},')]

click usergroup edit button
    [Arguments]    ${groupName}
    [Documentation]    根据用户组名称点击编辑按钮
    ...    参数：用户组名称
    ${name_id}    get usergroup name ID in database    ${groupName}
    Click Element    //a[contains(@onclick,'orgEdit(${name_id})')]
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${layui_title2_ID}

create right usergroup by UI
    [Arguments]    ${groupName}    ${parentGroup}=init
    [Documentation]    创建正确的用户组
    ...    参数：1.创建的用户组名称，2.上级用户组名称(默认值：初始用户组)
    into usergroup management UI
    Run Keyword If    '${parentGroup}'!='init'    select parent usergroup on usergroup manage UI    ${parentGroup}
    click create usergroup button
    input usergruop name    ${groupName}
    click save button    True
    verify usergroup name on usergroup manage UI    ${groupName}

delete all usergroup by UI
    [Documentation]    删除所有用户组（不包括初始用户组）
    into usergroup management UI
    ${len}    get rows of database table    SELECT * FROM account_groups WHERE id>1;
    : FOR    ${i}    IN RANGE    ${len}
    \    ${element}    Get Webelement    //a[contains(@onclick,'orgDelete')]
    \    Wait Until Element Is Enabled    ${element}
    \    Click Element    ${element}
    \    click confirm box confirm button
    \    Select Frame    ${ugrp_tabiframe_ID}
    \    Select Frame    ${ugrp_mgriframe_ID}
    ${len}    get rows of database table    SELECT * FROM account_groups WHERE id>1;
    Should Be Equal As Integers    ${len}    0    msg=新建的用户组没有全部删除

edit usergroup name by UI
    [Arguments]    ${oldName}    ${newName}
    [Documentation]    在界面上修改用户组
    ...    参数：1.旧的用户组名称；2.新的用户组名称
    into usergroup management UI
    log    ${oldName}
    click usergroup edit button    ${oldName}
    input usergruop name    ${newName}
    click save button    True
    verify lobibox info

get usergroup name ID in database
    [Arguments]    ${groupName}
    [Documentation]    获取数据库中用户组名的ID
    ...    参数：用户组名称
    ${nameId}    get return value of the database query    SELECT id FROM account_groups WHERE NAME='${groupName}';
    [Return]    ${nameId}

input usergroup describe
    [Arguments]    ${describe}
    [Documentation]    新建或者编辑用户组界面输入用户组描述
    ...    参数：用户组描述
    Clear Element Text    ${ugrp_add_describe_input_ID}
    Input Text    ${ugrp_add_describe_input_ID}    ${describe}
    Sleep    ${inputSleep}

input usergroup search name
    [Arguments]    ${groupName}
    [Documentation]    点开搜索图标，输入搜索的用户组名称
    ...    参数：待搜索的用户组名称
    open the search UI
    Clear Element Text    ${ugrp_search_nameinput_ID}
    Input Text    ${ugrp_search_nameinput_ID}    ${groupName}
    Sleep    ${inputSleep}

input usergruop name
    [Arguments]    ${groupName}
    [Documentation]    新建或者编辑用户组界面输入用户组名字
    ...    参数：用户组名称
    Clear Element Text    ${ugrp_add_nameinput_ID}
    Input Text    ${ugrp_add_nameinput_ID}    ${groupName}
    Sleep    ${inputSleep}

into usergroup management UI
    [Documentation]    进入到用户组管理界面
    refresh page
    Wait Until Element Is Enabled    ${user_manage_menu_ID}    error=用户管理按钮不可用
    Click Element    ${user_manage_menu_ID}
    Wait Until Element Is Visible    ${ugrp_manage_menu_ID}    error=用户组菜单不可见
    Click Element    ${ugrp_manage_menu_ID}
    Wait Until Element Is Visible    ${ugrp_manage_UI}    error=用户组管理界面不可见
    Select Frame    ${ugrp_tabiframe_ID}
    Select Frame    ${ugrp_mgriframe_ID}
    Wait Until Element Is Visible    ${ugrp_add_button_ID}    error=新建用户组按钮不可见

prepare env for edit usergroup
    [Documentation]    测试编辑用户组准备环境:1.打开浏览器，2.创建用户组(编辑，搜索，删除)，
    ...    3.在创建的用户组中创建用户
    login by admin
    create right usergroup by UI    ${userGroupTD['nameD']}
    create right usergroup by UI    ${editNameTD}
    : FOR    ${name}    IN    ${searchNameList[0]}    @{searchNameList[2:]}
    \    create right usergroup by UI    ${name}
    create right usergroup by UI    ${deleteNameTD}
    create right usergroup by UI    ${searchNameList[1]}    ${userGroupTD['nameD']}
    create right user by UI    ${userGroupTD['user']}    group=${userGroupTD['nameD']}
    create right user by UI    ${userGroupTD['user']}11    group=${searchNameList[1]}

select parent usergroup on usergroup manage UI
    [Arguments]    ${groupName}
    [Documentation]    选择上级用户组
    ...    参数：用户组名称
    Unselect Frame
    Select Frame    ${ugrp_tabiframe_ID}
    select name in the tree structure    ${groupName}    account_groups    ${userGroupUI['initName']}
    Select Frame    ${ugrp_mgriframe_ID}

select usergroup on layer UI
    [Arguments]    ${groupName}    ${locator}=default
    [Documentation]    在layer界面上选择用户组
    ...    参数：1.用户组名称,2.用户组选择框元素位置
    ${locatorNew}    Set Variable If    '${locator}'=='default'    ${layui_group_select}    '${locator}'=='default'    ${locator}
    Click Element    ${locatorNew}
    Wait Until Element Is Visible    ${public_firstTree_switch}    error=选择用户组的树形界面不可见
    Click Element    ${public_firstTree_switch}
    select name in the tree structure    ${groupName}    account_groups    ${userGroupUI['initName']}

verify create usergroup UI info
    [Documentation]    新建用户组界面信息验证
    verify same element text by UI    ${layui_label_ID}    @{userGroupUI['label']}
    verify element text    ${ugrp_add_superior_input_ID}    ${userGroupUI['initName']}
    verify lay UI title info    ${userGroupUI['title5']}

verify edit usergroup UI info
    [Arguments]    ${groupName}
    [Documentation]    编辑用户组界面信息验证
    ...    参数：编辑用户组名称
    verify same element text by UI    ${layui_label_ID}    @{userGroupUI['label']}
    verify element text    ${ugrp_add_superior_input_ID}    ${userGroupUI['initName']}
    verify element value attribute value    ${ugrp_add_nameinput_ID}    ${groupName}
    verify lay UI title info    ${userGroupUI['title6']}

verify usergroup description in databse
    [Arguments]    ${groupName}    ${description}
    [Documentation]    在数据库中验证用户组描述信息
    ...    参数：1.用户组名称，2.用户组描述
    ${des}    get return value of the database query    select DESCRIPTION from account_groups where NAME='${group_name}';
    Should Be Equal As Strings    ${description}    ${des}    msg=验证值"${description}"与实际值"${des}"不相等

verify usergroup manage UI info
    [Documentation]    用户组管理界面信息验证
    verify same element text by UI    ${public_table_head}    @{userGroupUI['tableH']}
    verify element value attribute value    ${ugrp_add_button_ID}    ${userGroupUI['button1']}
    verify element title attribute value    ${ugrp_add_button_ID}    ${userGroupUI['title2']}
    verify element title attribute value    //a[contains(@onclick,'orgEdit')]    ${userGroupUI['title3']}
    verify element title attribute value    //a[contains(@onclick,'orgDelete')]    ${userGroupUI['title4']}
    open the search UI
    verify element text    ${public_search_label_ID}    ${userGroupUI['srcLabel']}
    Table Cell Should Contain    ${public_table_ID}    2    3    ${userGroupUI['admin']}
    verify element text    ${public_manage_title_ID}    ${userGroupUI['title1']}
    Unselect Frame
    verify element text    ${ugrp_manage_tab_ID}    ${userGroupUI['title1']}

verify usergroup name error msg
    [Arguments]    ${errMsg}
    [Documentation]    新建或者编辑用户组时错误用户组名称信息验证
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${ugrp_add_name_error_ID}
    Element Text Should Be    ${ugrp_add_name_error_ID}    ${errMsg}

verify usergroup name on usergroup manage UI
    [Arguments]    ${groupName}
    [Documentation]    检查当前页面某用户组名称
    ...    参数：用户组名称
    into usergroup management UI
    Table Column Should Contain    ${public_table_ID}    1    ${groupName}

verify usergroup parent name on usergroup manage UI
    [Arguments]    ${groupName}    ${parentName}
    [Documentation]    在用户组管理界面上验证某用户的所属用户组名称
    ...    参数：1.用户组名称，2.所属用户组名称
    into usergroup management UI
    ${nameId}    get usergroup name ID in database    ${groupName}
    verify element text    //a[contains(@onclick,'orgEdit(${name_id})')]/../../td[2]    ${parentName}
