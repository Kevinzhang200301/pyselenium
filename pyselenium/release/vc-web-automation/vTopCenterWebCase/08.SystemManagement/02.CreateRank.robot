*** Settings ***
Suite Setup       prepare env for create rank
Suite Teardown    clear env for create rank
Force Tags    ${rankTag['default']}
Resource          ../../Keyword/SystemManage/RankManageKeywords.robot

*** Test Cases ***
分级管理界面信息验证
    [Tags]    ${rankTag['info']}
    [Setup]    create right rank by UI    ${rankTD['nameD']}1
    into rank manage UI
    verify rank manage UI info
    [Teardown]    delete all rank by UI

新建下级vTopCenter界面信息验证
    [Tags]    ${rankTag['info']}
    into rank manage UI
    click create rank button
    verify create rank UI info

新建下级vTopCenter_名称为空
    [Tags]    ${rankTag['create']}
    into rank manage UI
    click create rank button
    input rank name    ${EMPTY}
    click save button
    verify rank name error info    ${rankUI['err1']}

新建下级vTopCenter_名称正确
    [Tags]    ${rankTag['create']}    smokeCase
    :FOR    ${name}    IN    @{rankTD['nameR']}
    \    into rank manage UI
    \    click create rank button
    \    input rank name    ${name}
    \    input rank ip    ${rankTD['addrD']}
    \    input rank key    ${rankTD['keyD']}
    \    select rank vhd    ${rankTD['vhdNameD']}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify rank name on the UI    ${name}
    [Teardown]    delete all rank by UI

新建下级vTopCenter_下级管理中心为空
    [Tags]    ${rankTag['create']}
    into rank manage UI
    click create rank button
    input rank name    ${rankTD['nameD']}
    input rank ip    ${EMPTY}
    click save button
    verify rank ip error info    ${rankUI['err2']}

新建下级vTopCenter_下级管理中心正确
    [Tags]    ${rankTag['create']}    smokeCase
    :FOR    ${i}    ${j}    IN ENUMERATE    @{rankTD['addrR']}
    \    into rank manage UI
    \    click create rank button
    \    input rank name    ${i}
    \    input rank ip    ${j}
    \    input rank key    ${rankTD['keyD']}
    \    select rank vhd    ${rankTD['vhdNameD']}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify rank IP on the UI    ${i}    ${j}
    [Teardown]    delete all rank by UI

新建下级vTopCenter_密钥为空
    [Tags]    ${rankTag['create']}
    into rank manage UI
    click create rank button
    input rank name    ${rankTD['nameD']}
    input rank ip    ${rankTD['addrD']}
    input rank key    ${EMPTY}
    click save button
    verify rank key error info    ${rankUI['err3']}

新建下级vTopCenter_密钥正确
    [Tags]    ${rankTag['create']}    smokeCase
    :FOR    ${i}    ${j}    IN ENUMERATE    @{rankTD['keyR']}
    \    into rank manage UI
    \    click create rank button
    \    input rank name    ${i}
    \    input rank ip    ${rankTD['addrD']}
    \    input rank key    ${j}
    \    select rank vhd    ${rankTD['vhdNameD']}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    [Teardown]    delete all rank by UI

新建下级vTopCenter_联系人正确
    [Tags]    ${rankTag['create']}    smokeCase
    :FOR    ${i}    ${j}    IN ENUMERATE    @{rankTD['person']}
    \    into rank manage UI
    \    click create rank button
    \    input rank name    ${i}
    \    input rank ip    ${rankTD['addrD']}
    \    input rank key    ${rankTD['keyD']}
    \    input contact person    ${j}
    \    select rank vhd    ${rankTD['vhdNameD']}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify rank contact person on the UI    ${i}    ${j}
    [Teardown]    delete all rank by UI

新建下级vTopCenter_联系电话正确
    [Tags]    ${rankTag['create']}    smokeCase
    :FOR    ${i}    ${j}    IN ENUMERATE    @{rankTD['mobile']}
    \    into rank manage UI
    \    click create rank button
    \    input rank name    ${i}
    \    input rank ip    ${rankTD['addrD']}
    \    input rank key    ${rankTD['keyD']}
    \    input contact mobile    ${j}
    \    select rank vhd    ${rankTD['vhdNameD']}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify rank contact mobile on the UI    ${i}    ${j}
    [Teardown]    delete all rank by UI

新建下级vTopCenter_未选择镜像
    [Tags]    ${rankTag['create']}
    into rank manage UI
    click create rank button
    input rank name    ${rankTD['nameD']}
    input rank ip    ${rankTD['addrD']}
    input rank key    ${rankTD['keyD']}
    click save button
    verify rank vhd error info    ${rankUI['err4']}

新建下级vTopCenter_选择几个镜像
    [Tags]    ${rankTag['create']}    smokeCase
    into rank manage UI
    click create rank button
    input rank name    ${rankTD['nameD']}
    input rank ip    ${rankTD['addrD']}
    input rank key    ${rankTD['keyD']}
    select rank vhd    @{rankTD['vhdNameR']}
    click save button    True
    verify lobibox info
    verify rank vhd info on the UI    ${rankTD['nameD']}    @{rankTD['vhdNameR']}
    [Teardown]    delete all rank by UI
