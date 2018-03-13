*** Settings ***
Resource    ../../Keyword/SystemManage/SystemSortKeywords.robot
Suite Setup    prepare env for system sort
Suite Teardown    clear env for system sort

*** Test Cases ***
分级管理界面_名称排序
    [Tags]    ${rankTag['sort']}
    into rank manage UI
    ${list1}    get table column text on UI    1
    click name on rank UI for sort
    ${list2}    get table column text on UI    1
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}
    
分级管理界面_vTopCenter地址排序
    [Tags]    ${rankTag['sort']}
    into rank manage UI
    ${list1}    get table column text on UI    2
    click IP on rank UI for sort
    ${list2}    get table column text on UI    2
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}
    
集中部署界面_文件名排序
    [Tags]    ${pxeTag['sort']}
    into rank manage UI
    ${list1}    get table column text on UI    1
    click name on pxe UI for sort
    ${list2}    get table column text on UI    1
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}    
    
固件升级界面_名称排序
    [Tags]    ${vcupTag['sort']}
    into rank manage UI
    ${list1}    get table column text on UI    1
    click name on FirmwareUpgrade UI for sort
    ${list2}    get table column text on UI    1
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}           