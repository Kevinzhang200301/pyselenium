*** Settings ***
Suite Setup       prepare env for user and usergroup sort
Suite Teardown    clear env for user and usergroup sort
Resource          ../../Keyword/UserManage/UserSortKeywords.robot

*** Test Cases ***
用户管理界面_用户名排序
    [Tags]    userSortCase    userManageCase
    into user management UI
    ${list1}    get table column text on UI    2
    Capture Page Screenshot
    click username on user UI for sort
    ${list2}    get table column text on UI    2
    Capture Page Screenshot
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}    msg=用户管理界面用户名排序错误

用户管理界面_真实姓名排序
    [Tags]    userSortCase    userManageCase
    into user management UI
    ${list1}    get table column text on UI    3
    Capture Page Screenshot
    click realname on user UI for sort
    ${list2}    get table column text on UI    3
    Capture Page Screenshot
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}    msg=用户管理界面真实姓名排序错误

用户管理界面_所属用户组排序
    [Tags]    userSortCase    userManageCase
    into user management UI
    ${list1}    get table column text on UI    4
    Capture Page Screenshot
    click parent group on user UI for sort
    ${list2}    get table column text on UI    4
    Capture Page Screenshot
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}    msg=用户管理界面所属用户排序错误

用户管理界面_发布者排序
    [Tags]    userSortCase    userManageCase
    into user management UI
    ${list1}    get table column text on UI    5
    Capture Page Screenshot
    click publish on user UI for sort
    ${list2}    get table column text on UI    5
    Capture Page Screenshot
    Lists Should Be Equal    ${list1}    ${list2}    msg=用户管理界面发布者排序错误

用户管理界面_模板数量排序
    [Tags]    userSortCase    userManageCase
    into user management UI
    ${list1}    get table column text on UI    6
    Capture Page Screenshot
    click template number on user UI for sort
    ${list2}    get table column text on UI    6
    Capture Page Screenshot
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}    msg=模板数量排序错误

用户组管理界面_用户组名称排序
    [Tags]    userGroupSortCase    userGroupManageCase
    into usergroup management UI
    ${list1}    get table column text on UI    1
    Capture Page Screenshot
    click name on usergroup UI for sort
    ${list2}    get table column text on UI    1
    Capture Page Screenshot
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}    msg=用户组管理界面用户组名称排序错误

用户组管理界面_所属用户组排序
    [Tags]    userGroupSortCase    userGroupManageCase
    into usergroup management UI
    ${list1}    get table column text on UI    2
    Capture Page Screenshot
    click parent group on usergroup UI for sort
    ${list2}    get table column text on UI    2
    Capture Page Screenshot
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}    msg=用户组管理界面所属用户组排序错误
