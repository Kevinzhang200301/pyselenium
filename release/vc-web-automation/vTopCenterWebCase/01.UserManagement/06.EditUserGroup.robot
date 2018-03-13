*** Settings ***
Suite Setup       prepare env for edit usergroup
Suite Teardown    clear env for edit usergroup
Force Tags    userGroupManageCase
Resource          ../../Keyword/UserManage/UserKeywords.robot
Resource          ../../Keyword/AdministratorKeywords.robot

*** Test Cases ***
编辑用户组界面信息验证
    [Tags]    userGroupInfoCase
    into usergroup management UI
    click usergroup edit button    ${userGroupTD['nameD']}
    verify edit usergroup UI info    ${userGroupTD['nameD']}

编辑用户组_名称没有任何值
    [Tags]    editUserGroupCase
    into usergroup management UI
    click usergroup edit button    ${userGroupTD['nameD']}
    input usergruop name    ${EMPTY}
    click save button
    verify usergroup name error msg    ${userGroupUI['err1']}

编辑用户组_名称为全为空格
    [Tags]    editUserGroupCase
    into usergroup management UI
    click usergroup edit button    ${userGroupTD['nameD']}
    input usergruop name    ${SPACE*8}
    click save button
    verify usergroup name error msg    ${userGroupUI['err1']}

编辑用户组_名称正确
    [Tags]    editUserGroupCase    smokeCase
    into usergroup management UI
    click usergroup edit button    ${editNameTD}
    input usergruop name    ${userGroupTD['nameR']}
    click save button    True
    verify lobibox info
    verify usergroup name on usergroup manage UI    ${userGroupTD['nameR']}

编辑用户组_用户组名称修改后相关信息变化验证
    [Tags]    editUserGroupCase
    [Setup]    edit usergroup name by UI    ${userGroupTD['nameD']}    ${userGroupTD['nameD']}11
    verify usergroup parent name on usergroup manage UI    ${searchNameList[1]}    ${userGroupTD['nameD']}11
    into user management UI
    verify user usergroup on the UI    ${userGroupTD['user']}    ${userGroupTD['nameD']}11
    click username on user manage UI    ${userGroupTD['user']}
    verify element text    //div[2]/div/div[5]/div[2]    ${userGroupTD['nameD']}11
    [Teardown]    edit usergroup name by UI    ${userGroupTD['nameD']}11    ${userGroupTD['nameD']}

编辑用户组_输入描述
    [Tags]    editUserGroupCase    smokeCase
    into usergroup management UI
    click usergroup edit button    ${userGroupTD['nameD']}
    input usergroup describe    ${userGroupTD['des']}
    click save button    True
    verify usergroup description in databse    ${userGroupTD['nameD']}    ${userGroupTD['des']}

新建用户组_已存在用户组名称(忽略大小写)
    [Tags]    editUserGroupCase
    into usergroup management UI
    click usergroup edit button    ${userGroupTD['nameD']}
    ${upper}    Convert To Uppercase    ${userGroupTD['nameD']}
    input usergruop name    ${upper}
    click save button
    verify usergroup name error msg    ${userGroupUI['err2'][:4]}${upper}${userGroupUI['err2'][4:]}

搜索用户组_不存在的用户组名称
    [Tags]    searchUserGroupCase
    into usergroup management UI
    : FOR    ${name}    IN    @{searchNoName}
    \    input usergroup search name    ${name}
    \    click search button
    \    Run Keyword And Continue On Failure    verify table records current page    0

搜索用户组_已存在完整用户组名称
    [Tags]    searchUserGroupCase
    into usergroup management UI
    input usergroup search name    ${searchNameList[1]}
    click search button
    verify table records current page    1

搜索用户组_已存在用户组名称部分字段
    [Tags]    searchUserGroupCase
    into usergroup management UI
    ${len}    Get Length    ${searchNameList}
    input usergroup search name    ${searchNameList[0]}
    click search button
    verify table records current page    ${len}

删除用户组_弹窗界面信息验证
    [Tags]    userGroupInfoCase
    into usergroup management UI
    click usergroup delete button    ${deleteNameTD}
    verify confirm box info    ${userBox['msg21'][:10]}${deleteNameTD}${userBox['msg21'][10:]}

删除用户组_取消
    [Tags]    deleteUserGroupCase
    into usergroup management UI
    click usergroup delete button    ${deleteNameTD}
    click confirm box cancel button
    verify confirm not exist

删除用户组_有子用户组
    [Tags]    deleteUserGroupCase
    into usergroup management UI
    click usergroup delete button    ${userGroupTD['nameD']}
    click confirm box confirm button
    verify lobibox info    ${userBox['msg22'][:4]}${userGroupTD['nameD']}${userBox['msg22'][4:]}

删除用户组_有用户
    [Tags]    deleteUserGroupCase
    into usergroup management UI
    click usergroup delete button    ${searchNameList[1]}
    click confirm box confirm button
    verify lobibox info    ${userBox['msg23'][:4]}${searchNameList[1]}${userBox['msg23'][4:]}

删除用户组_正常删除
    [Tags]    deleteUserGroupCase    smokeCase
    into usergroup management UI
    click usergroup delete button    ${deleteNameTD}
    click confirm box confirm button
    ${status}    Run Keyword And Return Status    verify usergroup name on usergroup manage UI    ${deleteNameTD}
    Should Be Equal As Strings    ${status}    False    msg=用户组没有删除成功
