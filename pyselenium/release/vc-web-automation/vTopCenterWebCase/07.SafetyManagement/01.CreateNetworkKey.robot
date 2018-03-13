*** Settings ***
Suite Setup       login by admin
Suite Teardown    close browser and kill chrome process
Force Tags    ${networkKeyTag['default']}
Resource          ../../Keyword/SafetyManage/NetworkKeyKeywords.robot

*** Test Cases ***
验证网络密钥管理界面信息
    [Tags]    ${networkKeyTag['info']}
    [Setup]    create right network key by UI    ${netKeyTD['nameD']}
    into network key manage UI
    verify network key manage UI info
    [Teardown]    delete all network key by UI

验证新建网络密钥界面信息
    [Tags]    ${networkKeyTag['info']}
    into network key manage UI
    click create network key button
    verify create network key UI info
    verify lay UI title info    ${netKeyUI['title5']}

新建网络密钥_名称为空
    [Tags]    ${networkKeyTag['create']}
    into network key manage UI
    click create network key button
    input network key name    ${EMPTY}
    click save button
    verify network key name error info    ${netKeyUI['err1']}

新建网络密钥_名称正确
    [Tags]    ${networkKeyTag['create']}    smokeCase
    into network key manage UI
    click create network key button
    input network key name    ${netKeyTD['nameR']}
    input network key value    ${netKeyTD['valueD']}
    click save button    True
    verify lobibox info
    verify network key name on the UI    ${netKeyTD['nameR']}
    [Teardown]    delete all network key by UI

新建网络密钥_名称重复
    [Tags]    ${networkKeyTag['create']}
    [Setup]    create right network key by UI    ${defaultNameTD}3
    into network key manage UI
    click create network key button
    input network key name    ${defaultNameTD}3
    input network key value    ${netKeyTD['valueD']}
    click save button
    verify network key name error info    ${netKeyUI['err6']}
    [Teardown]    delete all network key by UI

新建网络密钥_名称忽略大小写
    [Tags]    ${networkKeyTag['create']}
    [Setup]    create right network key by UI    ${defaultNameTD}6
    into network key manage UI
    click create network key button
    ${upper}    Convert To Uppercase    ${defaultNameTD}6
    input network key name    ${upper}
    input network key value    ${netKeyTD['valueD']}
    click save button
    verify network key name error info    ${netKeyUI['err6']}
    [Teardown]    delete all network key by UI

新建网络密钥_值为空
    [Tags]    ${networkKeyTag['create']}
    into network key manage UI
    click create network key button
    input network key name    ${netKeyTD['nameD']}
    input network key value    ${EMPTY}
    click save button
    verify network key value error info    ${netKeyUI['err2']}

新建网络密钥_值小于16位
    [Tags]    ${networkKeyTag['create']}
    into network key manage UI
    click create network key button
    input network key name    ${netKeyTD['nameD']}
    input network key value    ${netKeyTD['valueE1']}
    click save button
    verify network key value error info    ${netKeyUI['err3']}

新建网络密钥_值大于16位小于32位(不包括24位)
    [Tags]    ${networkKeyTag['create']}
    into network key manage UI
    click create network key button
    input network key name    ${netKeyTD['nameD']}
    input network key value    ${netKeyTD['valueE2']}
    click save button
    verify network key value error info    ${netKeyUI['err4']}

新建网络密钥_值是非数字、字母、下划线
    [Tags]    ${networkKeyTag['create']}
    into network key manage UI
    click create network key button
    input network key name    ${netKeyTD['nameD']}
    input network key value    ${netKeyTD['valueE3']}
    click save button
    verify network key value error info    ${netKeyUI['err5']}

新建网络密钥_值正确
    [Tags]    ${networkKeyTag['create']}    smokeCase
    ${len}    Get Length    ${netKeyTD['valueR']}
    into network key manage UI
    : FOR    ${i}    IN RANGE    ${len}
    \    click create network key button
    \    input network key name    ${i}
    \    input network key value    ${netKeyTD['valueR'][${i}]}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify network key value on the UI    ${i}    ${netKeyTD['valueR'][${i}]}
