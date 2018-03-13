*** Settings ***
Suite Setup       prepare env for edit device policy
Suite Teardown    clear env for edit device policy
Force Tags    ${policyTag['Ddefault']}
Resource          ../../Keyword/PolicyManage/DevicePolicyKeywords.robot

*** Test Cases ***
编辑设备策略界面信息验证
    [Tags]    ${policyTag['Dinfo']}
    into device policy manage UI
    click edit device policy button    ${defaultNameTD}
    verify lay UI title info    ${policyUI['title6']}

编辑设备策略_策略名称为空
    [Tags]    ${policyTag['Dedit']}
    into device policy manage UI
    click edit device policy button    ${defaultNameTD}
    input device policy name    ${EMPTY}
    click save button
    verify device policy name error msg    ${policyUI['err1']}

编辑设备策略_策略名称有单引号
    [Tags]    ${policyTag['Dedit']}
    into device policy manage UI
    click edit device policy button    ${defaultNameTD}
    input device policy name    ${policyTD['nameE']}
    click save button
    verify device policy name error msg    ${policyUI['err2']}

编辑设备策略_策略名称已存在
    [Tags]    ${policyTag['Dedit']}
    into device policy manage UI
    click edit device policy button    ${editNameTD}
    input device policy name    ${defaultNameTD}
    click save button
    verify device policy name error msg    ${policyUI['err5']}

编辑设备策略_策略名称忽略大小写
    [Tags]    ${policyTag['Dedit']}
    into device policy manage UI
    click edit device policy button    ${editNameTD}
    ${upper}    Convert To Uppercase    ${defaultNameTD}
    input device policy name    ${upper}
    click save button
    verify device policy name error msg    ${policyUI['err5']}

编辑设备策略_正确的策略名称
    [Tags]    ${policyTag['Dedit']}    smokeCase
    into device policy manage UI
    click edit device policy button    ${editNameTD}
    input device policy name    ${policyTD['nameR']}
    click save button    True
    verify lobibox info
    verify device policy name by UI    ${policyTD['nameR']}

编辑设备策略_黑名单
    [Tags]    ${policyTag['Dedit']}    smokeCase
    [Setup]    create right device policy    ${editNameTD}1    type=${policyUI['Dtype'][1]}
    into device policy manage UI
    click edit device policy button    ${editNameTD}1
    select device policy type    ${policyUI['Dtype'][0]}
    click save button    True
    verify lobibox info
    verify device policy type by UI    ${editNameTD}1    ${policyUI['Dtype'][0]}

编辑设备策略_白名单
    [Tags]    ${policyTag['Dedit']}    smokeCase
    into device policy manage UI
    click edit device policy button    ${defaultNameTD}
    select device policy type    ${policyUI['Dtype'][1]}
    click save button    True
    verify lobibox info
    verify device policy type by UI    ${defaultNameTD}    ${policyUI['Dtype'][1]}

编辑设备策略_空设备
    [Tags]    ${policyTag['Dedit']}
    into device policy manage UI
    click edit device policy button    ${defaultNameTD}
    unselect devices by UI    ${policyUI['USB'][0]}
    click save button
    verify device policy device error msg    ${policyUI['err6']}

编辑设备策略_选择一个设备
    [Tags]    ${policyTag['Dedit']}    smokeCase
    into device policy manage UI
    click edit device policy button    ${defaultNameTD}
    unselect devices by UI    ${policyUI['USB'][0]}
    select devices by UI    ${policyUI['CD'][0]}
    click save button    True
    verify lobibox info
    verify device policy device by UI    ${defaultNameTD}    ${policyUI['CD'][0]}

编辑设备策略_选择多个设备
    [Tags]    ${policyTag['Dedit']}    smokeCase
    into device policy manage UI
    click edit device policy button    ${defaultNameTD}
    unselect devices by UI    ${policyUI['USB'][0]}
    ${list1}    get table column text on UI    2    ${dply_create_table_ID}
    ${len}    Get Length    ${list1}
    select table checkbox on UI    ${len}
    click save button    True
    verify lobibox info
    verify device policy device by UI    ${defaultNameTD}    @{list1}

编辑设备策略_输入说明
    [Tags]    ${policyTag['Dedit']}    smokeCase
    into device policy manage UI
    click edit device policy button    ${defaultNameTD}
    input device policy description    ${policyTD['nameR']}
    click save button    True
    verify lobibox info

删除设备策略_弹窗信息验证
    [Tags]    ${policyTag['Dinfo']}
    into device policy manage UI
    click delete device policy button    ${deleteNameTD}
    verify confirm box info    ${policyBox['msg1']}

删除设备策略_取消
    [Tags]    ${policyTag['Ddel']}
    into device policy manage UI
    click delete device policy button    ${deleteNameTD}
    click confirm box cancel button
    verify confirm not exist

删除设备策略_确认
    [Tags]    ${policyTag['Ddel']}
    into device policy manage UI
    click delete device policy button    ${deleteNameTD}
    click confirm box confirm button
    verify confirm not exist
    ${status}    Run Keyword And Return Status    verify device policy name by UI    ${deleteNameTD}
    Should Be Equal As Strings    ${status}    False

删除设备策略_已分配模板
    [Tags]    ${policyTag['Ddel']}
    into device policy manage UI
    click delete device policy button    ${defaultNameTD}
    click confirm box confirm button
    verify lobibox info    ${policyBox['msg3']}

搜索设备策略_不输入任何值点击搜索按钮
    [Tags]    ${policyTag['Dsearch']}
    into device policy manage UI
    ${ply_num}    get current table record number
    input search device policy name    ${EMPTY}
    click search button
    verify table records current page    ${ply_num}

搜索设备策略_不存在的用户策略搜索(包括特殊符号)
    [Tags]    ${policyTag['Dsearch']}
    into device policy manage UI
    : FOR    ${name}    IN    @{searchNoName}
    \    input search device policy name    ${name}
    \    click search button
    \    Run Keyword And Continue On Failure    verify table records current page    0

搜索设备策略_已存在用户策略
    [Tags]    ${policyTag['Dsearch']}
    into device policy manage UI
    input search device policy name    ${searchNameList[1]}
    click search button
    verify table records current page    1

搜索设备策略_策略名称部分字段
    [Tags]    ${policyTag['Dsearch']}
    into device policy manage UI
    input search device policy name    ${searchNameList[0]}
    click search button
    ${len}    Get Length    ${searchNameList}
    verify table records current page    ${len}
