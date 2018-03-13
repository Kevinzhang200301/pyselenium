*** Settings ***
Suite Setup       prepare env for edit location
Suite Teardown    clear env for edit location
Force Tags      ${localTag['default']}
Resource          ../../keyword/vTopManage/LocationKeywords.robot

*** Test Cases ***
编辑位置界面信息验证
    [Tags]    ${localTag['info']}
    into location manage UI
    click edit location button    ${localTD['nameD']}
    verify lay UI title info    ${localUI['title4']}

编辑位置_位置名称为空
    [Tags]    ${localTag['edit']}
    into location manage UI
    click edit location button    ${localTD['nameD']}
    input location name    ${EMPTY}
    click save button
    verify location name error info    ${localUI['err1']}

编辑位置_位置名称小于3位
    [Tags]    ${localTag['edit']}
    into location manage UI
    click edit location button    ${localTD['nameD']}
    input location name    ${localTD['nameE1']}
    click save button
    verify location name error info    ${localUI['err4']}

编辑位置_位置名称大于20位
    [Tags]    ${localTag['edit']}
    into location manage UI
    click edit location button    ${localTD['nameD']}
    input location name    ${localTD['nameE2']}
    click save button
    verify location name error info    ${localUI['err4']}

编辑位置_位置名称非法字符
    [Tags]    ${localTag['edit']}
    into location manage UI
    click edit location button    ${localTD['nameD']}
    : FOR    ${i}    IN    @{localTD['nameE3']}
    \    input location name    ${i*8}
    \    click save button
    \    Run Keyword And Continue On Failure    verify location name error info    ${localUI['err4']}

编辑位置_位置名称正确
    [Tags]    ${localTag['edit']}    smokeCase
    ${nameNew}    Set Variable    ${localTD['editD']}
    : FOR    ${name}    IN    @{localTD['nameR']}
    \    into location manage UI
    \    click edit location button    ${nameNew}
    \    input location name    ${name}
    \    click save button    True
    \    verify lobibox info
    \    Run Keyword And Continue On Failure    verify location name exist on the UI    ${name}
    \    verify location parent name on location manage UI    ${localTD['editD']}11    ${name}
    \    Comment    verify admin range on admin manage UI    ${defaultNameTD}    ${name}
    \    ${nameNew}    Set Variable    ${name}

编辑位置_前缀错误
    [Tags]    ${localTag['edit']}
    into location manage UI
    click edit location button    ${localTD['nameD']}
    input location group mark    ${localTD['markE']}
    click save button
    verify location mark error info    ${localUI['err2']}

编辑位置_前缀正确
    [Tags]    ${localTag['edit']}    smokeCase
    into location manage UI
    click edit location button    ${localTD['nameD']}
    input location group mark    ${localTD['markR']}
    click save button    True
    verify location mark on the UI    ${localTD['nameD']}    ${localTD['markR']}

编辑位置_选择网络
    [Tags]    ${localTag['edit']}    smokeCase
    into location manage UI
    click edit location button    ${localTD['nameD']}
    select location network    ${localTD['networkD']}
    click save button    True
    verify lobibox info

编辑位置_输入描述
    [Tags]    ${localTag['edit']}    smokeCase
    into location manage UI
    click edit location button    ${localTD['nameD']}
    input location description    ${localTD['des']}
    click save button    True
    verify lobibox info

设置默认位置_弹窗信息验证
    [Tags]    ${localTag['info']}
    into location manage UI
    click set default location button    ${localTD['nameD']}
    verify confirm box info    ${vtopBox['msg1'][:6]}${localTD['nameD']}${vtopBox['msg1'][6:]}

设置默认位置_取消
    [Tags]    ${localTag['setDefault']}
    into location manage UI
    click set default location button    ${localTD['nameD']}
    click confirm box cancel button
    verify confirm not exist

设置默认位置_确定
    [Tags]    ${localTag['setDefault']}
    into location manage UI
    click set default location button    ${localTD['nameD']}
    click confirm box confirm button
    verify lobibox info    ${vtopBox['msg6'][:3]}${localTD['nameD']}${vtopBox['msg6'][3:]}
    verify location name exist on the UI    ${localTD['nameD']}(${localUI['localD']})
    [Teardown]    set default location on location manage UI    ${localUI['localD']}

搜索位置_不存在的位置名称
    [Tags]    ${localTag['search']}
    into location manage UI
    : FOR    ${txt}    IN    @{searchNoName}
    \    input search location name    ${txt}
    \    click search button
    \    Run Keyword And Continue On Failure    verify table records current page    0

搜索位置_已存在的位置名称
    [Tags]    ${localTag['search']}
    into location manage UI
    input search location name    ${localTD['srcName'][1]}
    click search button
    verify table records current page    1

搜索位置_已存在位置名称的部分字段
    [Tags]    ${localTag['search']}
    into location manage UI
    ${len}    Get Length    ${localTD['srcName']}
    input search location name    ${localTD['srcName'][0]}
    click search button
    verify table records current page    ${len}

删除位置_弹窗信息验证
    [Tags]    ${localTag['info']}
    into location manage UI
    click delete location button    ${localTD['del']}
    verify confirm box info    ${vtopBox['msg7'][:6]}${localTD['del']}${vtopBox['msg7'][6:]}

删除位置_取消
    [Tags]    ${localTag['del']}
    into location manage UI
    click delete location button    ${localTD['del']}
    click confirm box cancel button
    verify confirm not exist

删除位置_确定
    [Tags]    ${localTag['del']}
    into location manage UI
    click delete location button    ${localTD['del']}
    click confirm box confirm button
    ${status}    Run Keyword And Return Status    verify location name exist on the UI    ${localTD['del']}
    Should Be Equal As Strings    ${status}    False

删除位置_有子位置
    [Tags]    ${localTag['del']}
    [Setup]    create right location by UI    ${localTD['nameD']}11    parent=${localTD['srcName'][1]}
    into location manage UI
    click delete location button    ${localTD['srcName'][1]}
    click confirm box confirm button
    verify lobibox info    ${vtopBox['msg8'][:1]}${localTD['srcName'][1]}${vtopBox['msg8'][1:]}

删除位置_默认位置
    [Tags]    ${localTag['del']}
    [Setup]    set default location on location manage UI    ${localTD['srcName'][0]}
    into location manage UI
    click delete location button    ${localTD['srcName'][0]}
    click confirm box confirm button
    verify lobibox info    ${vtopBox['msg9'][:5]}${localTD['srcName'][0]}${vtopBox['msg9'][5:]}
    [Teardown]    set default location on location manage UI    ${localUI['localD']}
