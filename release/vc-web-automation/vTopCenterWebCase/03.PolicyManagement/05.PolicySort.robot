*** Settings ***
Suite Setup       prepare env for policy sort
Suite Teardown    clear env for policy sort
Resource          ../../Keyword/PolicyManage/SortKeywords.robot

*** Test Cases ***
用户策略界面_策略名称排序
    [Tags]    ${policyTag['Usort']}    ${policyTag['Udefault']}
    into userpolicy manage UI
    ${list1}    get table column text on UI    1
    click policy name for sort
    ${list2}    get table column text on UI    1
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}

用户策略界面_规则数量排序
    [Tags]    ${policyTag['Usort']}    ${policyTag['Udefault']}
    into userpolicy manage UI
    ${list1}    get table column text on UI    3
    click policy number for sort
    ${list2}    get table column text on UI    3
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}

设备策略界面_策略名称排序
    [Tags]    ${policyTag['Dsort']}    ${policyTag['Ddefault']}
    into device policy manage UI
    ${list1}    get table column text on UI    1
    click policy name for sort
    ${list2}    get table column text on UI    1
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}

设备策略界面_策略类型排序
    [Tags]    ${policyTag['Dsort']}    ${policyTag['Ddefault']}
    into device policy manage UI
    ${list1}    get table column text on UI    2
    click policy type for sort
    ${list2}    get table column text on UI    2
    Sort List    ${list1}
    Reverse List    ${list1}     
    Lists Should Be Equal    ${list1}    ${list2}

设备策略界面_设备数量排序
    [Tags]    ${policyTag['Dsort']}    ${policyTag['Ddefault']}
    into device policy manage UI
    ${list1}    get table column text on UI    4
    click policy number for sort
    ${list2}    get table column text on UI    4
    ${lise1_copy}    Copy List    ${list1[:-1]}
    Sort List    ${lise1_copy}
    Insert Into List    ${lise1_copy}    0    无限制
    Lists Should Be Equal    ${lise1_copy}    ${list2}