*** Settings ***
Suite Setup       prepare env for vtop manage sort
Suite Teardown    clear env for vtop manage sort
Resource          ../../Keyword/vTopManage/vTopSortKeywords.robot

*** Test Cases ***
位置排序_位置名称
    [Tags]    ${localTag['sort']}    ${localTag['default']}
    into location manage UI
    ${list1}    get table column text on UI    1
    click name on location manage UI for sort
    ${list2}    get table column text on UI    1
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}

位置排序_所属位置
    [Tags]    ${localTag['sort']}    ${localTag['default']}
    into location manage UI
    ${list1}    get table column text on UI    2
    click parent on location manage UI for sort
    ${list2}    get table column text on UI    2
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}

虚拟机排序_虚拟机名称
    [Tags]    ${vmTag['sort']}
    into VM manage UI
    click name on vm manage UI for sort

虚拟机排序_镜像名称
    [Tags]    ${vmTag['sort']}
    into VM manage UI
    click vhd on vm manage UI for sort

虚拟机排序_所属vTop
    [Tags]    ${vmTag['sort']}
    into VM manage UI
    click vtop on vm manage UI for sort

虚拟机排序_所属用户
    [Tags]    ${vmTag['sort']}
    into VM manage UI
    click user on vm manage UI for sort

虚拟机排序_虚拟机状态
    [Tags]    ${vmTag['sort']}
    into VM manage UI
    click status on vm manage UI for sort

vTop排序_所在位置
    [Tags]    ${vTopTag['sort']}
    into vtop manage UI
    click group on vtop manage UI for sort

vTop排序_编号
    [Tags]    ${vTopTag['sort']}
    into vtop manage UI
    click mark on vtop manage UI for sort

vTop排序_绑定用户
    [Tags]    ${vTopTag['sort']}
    into vtop manage UI
    click bindUser on vtop manage UI for sort

vTop排序_自动登录
    [Tags]    ${vTopTag['sort']}
    into vtop manage UI
    click anonymous on vtop manage UI for sort

vTop排序_当前状态
    [Tags]    ${vTopTag['sort']}
    into vtop manage UI
    click status on vtop manage UI for sort

vTop排序_主机名
    [Tags]    ${vTopTag['sort']}
    into vtop manage UI
    click name on vtop manage UI for sort
