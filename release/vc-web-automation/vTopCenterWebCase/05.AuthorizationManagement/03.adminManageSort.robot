*** Settings ***
Suite Setup       prepare env for admin sort test
Suite Teardown    clear env for edit admin
Force Tags      adminSortCase
Resource          ../../Keyword/AdministratorKeywords.robot

*** Test Cases ***
管理员界面_用户名排序
    into admin manage UI
    ${list1}    get table column text on UI    2
    click name for admin sort
    ${list2}    get table column text on UI    2
    Capture Page Screenshot
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}

管理员界面_真实姓名排序
    into admin manage UI
    ${list1}    get table column text on UI    3
    click realname for admin sort
    ${list2}    get table column text on UI    3
    Capture Page Screenshot
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}

管理员界面_用户角色排序
    into admin manage UI
    ${list1}    get table column text on UI    4
    click rolename for admin sort
    ${list2}    get table column text on UI    4
    Capture Page Screenshot
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}

管理员界面_管理范围排序
    into admin manage UI
    ${list1}    get table column text on UI    5
    click range for admin sort
    ${list2}    get table column text on UI    5
    Capture Page Screenshot
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}

管理员界面_有效期排序
    into admin manage UI
    ${list1}    get table column text on UI    6
    click expiry for admin sort
    ${list2}    get table column text on UI    6
    Capture Page Screenshot
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}

管理员界面_用户状态排序
    into admin manage UI
    ${list1}    get table column text on UI    7
    click status for admin sort
    ${list2}    get table column text on UI    7
    Capture Page Screenshot
    Sort List    ${list1}
    Reverse List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}
