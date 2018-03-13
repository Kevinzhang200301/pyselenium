*** Settings ***
Suite Setup       login by admin
Suite Teardown    close browser and kill chrome process
Force Tags    ${policyTag['Ddefault']}
Resource          ../../Keyword/PolicyManage/DevicePolicyKeywords.robot

*** Test Cases ***
设备策略管理界面信息验证
    [Tags]    ${policyTag['Dinfo']}
    [Setup]    create right device policy    ${defaultNameTD}
    into device policy manage UI
    verify device policy manage UI info
    [Teardown]    delete all device policy by UI

新建设备策略界面信息验证
    [Tags]    ${policyTag['Dinfo']}
    into device policy manage UI
    click create device policy button
    verify create device policy UI info

新建设备策略_策略名称为空
    [Tags]    ${policyTag['Dcreate']}
    into device policy manage UI
    click create device policy button
    input device policy name    ${EMPTY}
    click save button
    verify device policy name error msg    ${policyUI['err1']}

新建设备策略_策略名称有单引号
    [Tags]    ${policyTag['Dcreate']}
    into device policy manage UI
    click create device policy button
    input device policy name    ${policyTD['nameE']}
    click save button
    verify device policy name error msg    ${policyUI['err2']}

新建设备策略_策略名称已存在
    [Tags]    ${policyTag['Dcreate']}
    [Setup]    create right device policy    ${defaultNameTD}1
    into device policy manage UI
    click create device policy button
    input device policy name    ${defaultNameTD}1
    select devices by UI    ${policyUI['USB'][0]}
    click save button
    verify device policy name error msg    ${policyUI['err5']}
    [Teardown]    delete all device policy by UI

新建设备策略_忽略大小写
    [Tags]    ${policyTag['Dcreate']}
    [Setup]    create right device policy    ${defaultNameTD}2
    into device policy manage UI
    click create device policy button
    ${upper}    Convert To Uppercase    ${defaultNameTD}2
    input device policy name    ${upper}
    select devices by UI    ${policyUI['USB'][0]}
    click save button
    verify device policy name error msg    ${policyUI['err5']}
    [Teardown]    delete all device policy by UI

新建设备策略_正确的策略名称
    [Tags]    ${policyTag['Dcreate']}    smokeCase
    into device policy manage UI
    click create device policy button
    input device policy name    ${policyTD['nameR']}
    select table checkbox on UI    1
    click save button    True
    verify lobibox info
    verify device policy name by UI    ${policyTD['nameR']}
    [Teardown]    delete all device policy by UI

新建设备策略_黑名单
    [Tags]    ${policyTag['Dcreate']}    smokeCase
    into device policy manage UI
    click create device policy button
    input device policy name    ${defaultNameTD}3
    select device policy type    ${policyUI['Dtype'][0]}
    select devices by UI    ${policyUI['USB'][0]}
    click save button    True
    verify lobibox info
    verify device policy type by UI    ${defaultNameTD}3    ${policyUI['Dtype'][0]}
    [Teardown]    delete all device policy by UI

新建设备策略_白名单
    [Tags]    ${policyTag['Dcreate']}    smokeCase
    into device policy manage UI
    click create device policy button
    input device policy name    ${defaultNameTD}4
    select device policy type    ${policyUI['Dtype'][1]}
    select devices by UI    ${policyUI['USB'][0]}
    click save button    True
    verify lobibox info
    verify device policy type by UI    ${defaultNameTD}4    ${policyUI['Dtype'][1]}
    [Teardown]    delete all device policy by UI

新建设备策略_空设备
    [Tags]    ${policyTag['Dcreate']}
    into device policy manage UI
    click create device policy button
    input device policy name    ${defaultNameTD}5
    click save button
    verify device policy device error msg    ${policyUI['err6']}

新建设备策略_选择一个设备
    [Tags]    ${policyTag['Dcreate']}    smokeCase
    into device policy manage UI
    click create device policy button
    input device policy name    ${defaultNameTD}6
    select devices by UI    ${policyUI['USB'][0]}
    click save button    True
    verify lobibox info
    verify device policy device by UI    ${defaultNameTD}6    ${policyUI['USB'][0]}
    [Teardown]    delete all device policy by UI

新建设备策略_选择多个设备
    [Tags]    ${policyTag['Dcreate']}    smokeCase
    into device policy manage UI
    click create device policy button
    input device policy name    ${defaultNameTD}7
    select table checkbox on UI    3
    click save button    True
    verify lobibox info
    verify device policy device by UI    ${defaultNameTD}7    ${policyUI['USB'][0]}    ${policyUI['CD'][0]}    ${policyUI['VCD'][0]}
    [Teardown]    delete all device policy by UI

新建设备策略_输入说明
    [Tags]    ${policyTag['Dcreate']}    smokeCase
    into device policy manage UI
    click create device policy button
    input device policy name    ${defaultNameTD}8
    select table checkbox on UI    1
    input device policy description    ${policyTD['nameR']}
    click save button    True
    verify lobibox info
    [Teardown]    delete all device policy by UI

新建设备策略_取消按钮
    [Tags]    ${policyTag['Dcreate']}
    into device policy manage UI
    click create device policy button
    click cancle button
    verify create device policy UI not exist

新建用户策略_取消“x”
    [Tags]    ${policyTag['Dcreate']}
    into device policy manage UI
    click create device policy button
    click "x" button
    verify create device policy UI not exist