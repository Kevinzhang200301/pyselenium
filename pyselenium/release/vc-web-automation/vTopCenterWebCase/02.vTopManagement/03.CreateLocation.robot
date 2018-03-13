*** Settings ***
Suite Setup       login by admin
Suite Teardown    close browser and kill chrome process
Force Tags    ${localTag['defualt']}
Resource          ../../keyword/vTopManage/LocationKeywords.robot

*** Test Cases ***
位置管理界面信息验证
    [Tags]    ${localTag['info']}
    into location manage UI
    verify location manage UI info

新建位置界面信息验证
    [Tags]    ${localTag['info']}
    into location manage UI
    click create location button
    verify create location manage UI info

新建位置_位置名称为空
    [Tags]    ${localTag['create']}
    into location manage UI
    click create location button
    input location name    ${EMPTY}
    click save button
    verify location name error info    ${localUI['err1']}

新建位置_位置名称小于3位
    [Tags]    ${localTag['create']}
    into location manage UI
    click create location button
    input location name    ${localTD['nameE1']}
    click save button    
    verify location name error info    ${localUI['err4']}
    
新建位置_位置名称大于20位
    [Tags]    ${localTag['create']}
    into location manage UI
    click create location button
    input location name    ${localTD['nameE2']}
    click save button    
    verify location name error info    ${localUI['err4']}

新建位置_位置名称非法字符
    [Tags]    ${localTag['create']}
    into location manage UI
    click create location button
    :FOR    ${i}    IN    @{localTD['nameE3']}
    \    input location name    ${i*8}
    \    click save button    
    \    Run Keyword And Continue On Failure    verify location name error info    ${localUI['err4']}

新建位置_位置名称正确
    [Tags]    ${localTag['create']}    smokeCase
    :FOR    ${name}    IN    @{localTD['nameR']}
    \    into location manage UI
    \    click create location button
    \    input location name    ${name}
    \    click save button    True
    \    verify lobibox info
    \    Run Keyword And Continue On Failure    verify location name exist on the UI    ${name}
    [Teardown]    delete all location by UI

新建位置_已存在名称
    [Tags]    ${localTag['create']}
    [Setup]    create right location by UI    ${localTD['nameD']}
    into location manage UI
    click create location button
    input location name    ${localTD['nameD']}
    click save button    
    verify location name error info    ${localUI['err3'][:3]}${localTD['nameD']}${localUI['err3'][3:]}
    [Teardown]    delete all location by UI

新建位置_选择所属位置(非初始化位置)
    [Tags]    ${localTag['create']}    smokeCase
    [Setup]    create right location by UI    ${localTD['nameD']}
    into location manage UI
    select parent location on location manage UI    ${localTD['nameD']}
    click create location button
    input location name    ${localTD['nameD']}66
    click save button    True
    verify lobibox info
    verify location parent name on location manage UI    ${localTD['nameD']}66    ${localTD['nameD']}
    [Teardown]    delete all location by UI

新建位置_前缀错误
    [Tags]    ${localTag['create']}
    into location manage UI
    click create location button
    input location name    ${localTD['nameD']}
    input location group mark    ${localTD['markE']}
    click save button
    verify location mark error info    ${localUI['err2']}

新建位置_前缀正确
    [Tags]    ${localTag['create']}    smokeCase
    into location manage UI
    click create location button
    input location name    ${localTD['nameD']}
    input location group mark    ${localTD['markR']}
    click save button    True
    verify lobibox info
    verify location mark on the UI    ${localTD['nameD']}    ${localTD['markR']}
    [Teardown]    delete all location by UI

新建位置_描述正确
    [Tags]    ${localTag['create']}    smokeCase
    into location manage UI
    click create location button
    input location name    ${localTD['nameD']}
    input location description    ${localTD['des']}
    click save button    True
    verify lobibox info
    [Teardown]    delete all location by UI

新建位置_选择网络
    [Tags]    ${localTag['create']}    smokeCase
    [Setup]    create right network by UI    ${localTD['networkD']}
    into location manage UI
    click create location button
    input location name    ${localTD['nameD']}
    select location network    ${localTD['networkD']}
    click save button    True
    verify lobibox info
    [Teardown]    Run Keywords    delete all location by UI    delete all location by UI
