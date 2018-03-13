*** Settings ***
Suite Setup       login by admin
Suite Teardown    close browser and kill chrome process
Force Tags    ${deviceTag['default']}
Resource          ../../Keyword/ResourceManage/DeviceKeywords.robot

*** Test Cases ***
设备管理界面信息验证
    [Tags]    ${deviceTag['info']}
    [Setup]    create right device by UI    ${defaultNameTD}
    into device manage UI
    verify device manage default device info
    verify device manage UI info
    [Teardown]    delete all device by UI

新建设备界面信息验证
    [Tags]    ${deviceTag['info']}
    into device manage UI
    click create device button
    verify lay UI title info    ${deviceUI['title2']}
    verify create device UI info

新建设备_名称为空
    [Tags]    ${deviceTag['create']}
    into device manage UI
    click create device button
    input device name    ${EMPTY}
    click save button
    verify device name error info    ${deviceUI['msg1']}

新建设备_名称为单引号
    [Tags]    ${deviceTag['create']}
    into device manage UI
    click create device button
    input device name    ${deviceTD['nameE']}
    click save button
    verify device name error info    ${deviceUI['msg6']}

新建设备_名称正确
    [Tags]    ${deviceTag['create']}    smokeCase
    into device manage UI
    : FOR    ${name}    IN    @{deviceTD['nameR']}
    \    click create device button
    \    input device name    ${name}
    \    input device vid    ${defaultNameTD}
    \    input device pid    ${defaultNameTD}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify device exist on the UI    ${name}
    [Teardown]    delete all device by UI

新建设备_名称重复
    [Tags]    ${deviceTag['create']}
    [Setup]    create right device by UI    ${defaultNameTD}
    into device manage UI
    click create device button
    input device name    ${defaultNameTD}
    input device vid    ${defaultNameTD}
    input device pid    ${defaultNameTD}
    click save button
    verify device name error info    ${deviceUI['msg4']}
    [Teardown]    delete all device by UI

新建设备_名称忽略大小写
    [Tags]    ${deviceTag['create']}
    [Setup]    create right device by UI    ${defaultNameTD}
    into device manage UI
    click create device button
    ${upper}    Convert To Uppercase    ${defaultNameTD}
    input device name    ${upper}
    input device vid    ${defaultNameTD}
    input device pid    ${defaultNameTD}
    click save button
    verify device name error info    ${deviceUI['msg4']}
    [Teardown]    delete all device by UI

新建设备_输入标签
    [Tags]    ${deviceTag['create']}    smokeCase
    into device manage UI
    click create device button
    input device name    ${defaultNameTD}
    input device tag    ${defaultNameTD}
    input device vid    ${defaultNameTD}
    input device pid    ${allSymbolTD}
    click save button    True
    verify lobibox info
    [Teardown]    delete all device by UI

新建设备_设备类型
    [Tags]    ${deviceTag['create']}    smokeCase
    into device manage UI
    ${len}    Get Length    ${deviceUI['typeList']}
    : FOR    ${name}    IN RANGE    ${len}
    \    click create device button
    \    input device name    ${name}
    \    select device type    ${deviceUI['typeList'][${name}]}
    \    input device vid    ${defaultNameTD}
    \    input device pid    ${defaultNameTD}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify device type on the UI    ${name}    ${deviceUI['typeList'][${name}]}
    [Teardown]    delete all device by UI

新建设备_产商ID为空
    [Tags]    ${deviceTag['create']}
    into device manage UI
    click create device button
    input device name    ${defaultNameTD}
    input device vid    ${EMPTY}
    input device pid    ${defaultNameTD}
    click save button
    verify device vid error info    ${deviceUI['msg3']}

新建设备_正确的产商ID
    [Tags]    ${deviceTag['create']}    smokeCase
    into device manage UI
    click create device button
    input device name    ${defaultNameTD}
    input device vid    ${allSymbolTD}
    input device pid    ${defaultNameTD}
    click save button    True
    verify lobibox info
    verify device vid on the UI    ${defaultNameTD}    ${allSymbolTD}

新建设备_产品ID为空
    [Tags]    ${deviceTag['create']}
    into device manage UI
    click create device button
    input device name    ${defaultNameTD}
    input device pid    ${EMPTY}
    input device vid    ${defaultNameTD}
    click save button
    verify device pid error info    ${deviceUI['msg2']}
    [Teardown]    delete all device by UI

新建设备_正确的产品ID
    [Tags]    ${deviceTag['create']}    smokeCase
    into device manage UI
    click create device button
    input device name    ${defaultNameTD}
    input device vid    ${defaultNameTD}
    input device pid    ${allSymbolTD}
    click save button    True
    verify lobibox info
    verify device pid on the UI    ${defaultNameTD}    ${allSymbolTD}
    [Teardown]    delete all device by UI

新建设备_输入描述
    [Tags]    ${deviceTag['create']}    smokeCase
    into device manage UI
    click create device button
    input device name    ${defaultNameTD}
    input device vid    ${defaultNameTD}
    input device pid    ${defaultNameTD}
    input device description    ${allSymbolTD}
    click save button    True
    verify lobibox info
    [Teardown]    delete all device by UI
