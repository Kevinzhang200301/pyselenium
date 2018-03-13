*** Settings ***
Suite Setup       login by admin
Suite Teardown    close browser and kill chrome process
Force Tags    ${adTag['default']}
Resource          ../../Keyword/ResourceManage/ActiveDirectoryKeywords.robot

*** Test Cases ***
AD域管理界面信息验证
    [Tags]    ${adTag['info']}
    [Setup]    create right ad    ${ADTD['nameD']}
    into ad manage UI
    verify ad manage UI info
    [Teardown]    delete all ad by UI

新建AD域界面信息验证
    [Tags]    ${adTag['info']}
    into ad manage UI
    click create ad button
    verify create ad UI info

新建AD域_名称为空
    [Tags]    ${adTag['create']}
    into ad manage UI
    click create ad button
    input ad name    ${EMPTY}
    click save button
    verify ad name error info    ${ADUI['msg1']}

新建AD域_错误格式的名称
    [Tags]    ${adTag['create']}
    into ad manage UI
    click create ad button
    : FOR    ${name}    IN    @{ADTD['nameE']}
    \    input ad name    ${name}
    \    click save button
    \    Run Keyword And Continue On Failure    verify ad name error info    ${ADUI['msg9']}

新建AD域_名称正确
    [Tags]    ${adTag['create']}    smokeCase
    into ad manage UI
    : FOR    ${name}    IN    @{ADTD['nameR']}
    \    click create ad button
    \    input ad name    ${name}
    \    input ad IP    ${ADTD['ipD']}
    \    input ad user    ${defaultNameTD}
    \    input ad password    ${defaultNameTD}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify ad name exist by UI    ${name}
    [Teardown]    delete all ad by UI

新建AD域_名称重复
    [Tags]    ${adTag['create']}
    [Setup]    create right ad    ${ADTD['nameD']}
    into ad manage UI
    click create ad button
    input ad name    ${ADTD['nameD']}
    click save button
    verify ad name error info    ${ADUI['msg4']}
    [Teardown]    delete all ad by UI

新建AD域_名称忽略大小写
    [Tags]    ${adTag['create']}
    [Setup]    create right ad    ${ADTD['nameD']}
    into ad manage UI
    click create ad button
    ${upper}    Convert To Uppercase    ${ADTD['nameD']}
    input ad name    ${upper}
    click save button
    verify ad name error info    ${ADUI['msg4']}
    [Teardown]    delete all ad by UI

新建AD域_服务器地址为空
    [Tags]    ${adTag['create']}
    into ad manage UI
    click create ad button
    input ad name    ${ADTD['nameD']}
    click save button
    verify ad ip error info    ${ADUI['msg5']}

新建AD域_服务器地址格式异常
    [Tags]    ${adTag['create']}
    into ad manage UI
    click create ad button
    input ad name    ${ADTD['nameD']}
    : FOR    ${ip}    IN    ${ADTD['ipE']}
    \    input ad IP    ${ip}
    \    click save button
    \    Run Keyword And Continue On Failure    verify ad ip error info    ${ADUI['msg7']}

新建AD域_服务器地址正确
    [Tags]    ${adTag['create']}    smokeCase
    into ad manage UI
    click create ad button
    input ad name    ${ADTD['nameD']}
    input ad IP    ${ADTD['ipR']}
    input ad user    ${defaultNameTD}
    input ad password    ${defaultNameTD}
    click save button    True
    verify lobibox info
    verify ad IP by UI    ${ADTD['nameD']}    ${ADTD['ipR']}
    [Teardown]    delete all ad by UI

新建AD域_用户名为空
    [Tags]    ${adTag['create']}
    into ad manage UI
    click create ad button
    input ad name    ${ADTD['nameD']}
    input ad IP    ${ADTD['ipD']}
    input ad user    ${EMPTY}
    click save button
    verify ad user error info    ${ADUI['msg6']}

新建AD域_密码为空
    [Tags]    ${adTag['create']}
    into ad manage UI
    click create ad button
    input ad name    ${ADTD['nameD']}
    input ad IP    ${ADTD['ipD']}
    input ad user    ${defaultNameTD}
    input ad password    ${EMPTY}
    click save button
    verify ad password error info    ${ADUI['msg8']}

新建AD域_输入说明
    [Tags]    ${adTag['create']}
    into ad manage UI
    click create ad button
    input ad name    ${ADTD['nameD']}
    input ad IP    ${ADTD['ipD']}
    input ad user    ${defaultNameTD}
    input ad password    ${defaultNameTD}
    input ad description    ${allSymbolTD}${numberTD}${lettersTD}
    click save button    True
    verify lobibox info
    [Teardown]    delete all ad by UI