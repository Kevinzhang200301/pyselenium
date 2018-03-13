*** Settings ***
Suite Setup       login by admin
Suite Teardown    close browser and kill chrome process
Force Tags    userGroupManageCase
Resource          ../../Keyword/UserManage/UserGroupKeywords.robot

*** Test Cases ***
用户组管理界面信息验证
    [Tags]    userGroupInfoCase
    [Setup]    create right usergroup by UI    ${userGroupTD['nameD']}
    into usergroup management UI
    verify usergroup manage UI info
    [Teardown]    delete all usergroup by UI

新建用户组界面信息验证
    [Tags]    userGroupInfoCase
    into usergroup management UI
    click create usergroup button
    verify create usergroup UI info

新建用户组_不输入名称(没有任何值)
    [Tags]    createUserGroupCase
    into usergroup management UI
    click create usergroup button
    input usergruop name    ${EMPTY}
    click save button
    verify usergroup name error msg    ${userGroupUI['err1']}

新建用户组_名称为全为空格
    [Tags]    createUserGroupCase
    into usergroup management UI
    click create usergroup button
    input usergruop name    ${SPACE*8}
    click save button
    verify usergroup name error msg    ${userGroupUI['err1']}

新建用户组_非法字符串
    [Tags]    createUserGroupCase
    into usergroup management UI
    click create usergroup button
    :FOR     ${name}    IN    @{userGroupTD['nameE']}
    \    input usergruop name     ${name}
    \    click save button
    \    Run Keyword And Continue On Failure    verify usergroup name error msg    ${userGroupUI['err3']}

新建用户组_名称正确
    [Tags]    createUserGroupCase    smokeCase
    into usergroup management UI
    click create usergroup button
    input usergruop name    ${userGroupTD['nameR']}
    click save button    True
    verify lobibox info
    verify usergroup name on usergroup manage UI    ${userGroupTD['nameR']}
    [Teardown]    delete all usergroup by UI

新建用户组_输入描述
    [Tags]    createUserGroupCase    smokeCase
    into usergroup management UI
    click create usergroup button
    input usergruop name    ${userGroupTD['nameD']}
    input usergroup describe    ${userGroupTD['des']}
    click save button    True
    verify lobibox info
    verify usergroup description in databse    ${userGroupTD['nameD']}    ${userGroupTD['des']}
    [Teardown]    delete all usergroup by UI

新建用户组_已存在用户组名称(忽略大小写)
    [Tags]    createUserGroupCase
    [Setup]    create right usergroup by UI    ${userGroupTD['nameD']}
    into usergroup management UI
    click create usergroup button
    ${upper}    Convert To Uppercase    ${userGroupTD['nameD']}
    input usergruop name    ${upper}
    click save button
    verify usergroup name error msg    ${userGroupUI['err2'][:4]}${upper}${userGroupUI['err2'][4:]}
    [Teardown]    delete all usergroup by UI

新建用户组_选择所属用户组(非初始用户组)
    [Tags]    createUserGroupCase
    [Setup]    create right usergroup by UI    ${userGroupTD['nameD']}
    into usergroup management UI
    select parent usergroup on usergroup manage UI    ${userGroupTD['nameD']}
    click create usergroup button
    input usergruop name    ${userGroupTD['nameR']}
    click save button    True
    verify lobibox info
    verify usergroup parent name on usergroup manage UI    ${userGroupTD['nameR']}    ${userGroupTD['nameD']}
