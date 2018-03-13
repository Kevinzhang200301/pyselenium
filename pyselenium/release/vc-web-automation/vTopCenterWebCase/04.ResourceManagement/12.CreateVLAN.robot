*** Settings ***
Suite Setup       login by admin
Suite Teardown    close browser and kill chrome process
Force Tags    ${vlanTag['default']}
Resource          ../../Keyword/ResourceManage/VlanKeywords.robot

*** Test Cases ***
VLAN管理界面信息验证
    [Tags]    ${vlanTag['info']}
    [Setup]    create right vlan by UI    ${defaultNameTD}1
    into vlan manage UI
    verify vlan manage UI info
    [Teardown]    delete all vlan by UI

新建vlan界面信息验证
    [Tags]    ${vlanTag['create']}
    into vlan manage UI
    click create vlan button
    verify create vlan UI info

新建vlan_名称不输入任何值
    [Tags]    ${vlanTag['create']}
    into vlan manage UI
    click create vlan button
    input vlan name    ${EMPTY}
    click save button
    verify vlan name error msg    ${vlanUI['msg1']}

新建vlan_名称全为空格
    [Tags]    ${vlanTag['create']}
    into vlan manage UI
    click create vlan button
    input vlan name    ${SPACE*8}
    click save button
    verify vlan name error msg    ${vlanUI['msg1']}

新建vlan_名称正确
    [Tags]    ${vlanTag['create']}    smokeCase
    into vlan manage UI
    click create vlan button
    input vlan name    ${vlanTD['nameR']}
    input vlan value    ${vlanTD['valueD']}
    click save button    True
    verify lobibox info
    verify vlan name exist by UI    ${vlanTD['nameR']}
    [Teardown]    delete all vlan by UI

新建vlan_名称重复
    [Tags]    ${vlanTag['create']}
    [Setup]    create right vlan by UI    ${defaultNameTD}2
    into vlan manage UI
    click create vlan button
    input vlan name    ${defaultNameTD}2
    click save button
    verify vlan name error msg    ${vlanUI['msg7']}
    [Teardown]    delete all vlan by UI

新建vlan_名称忽略大小写
    [Tags]    ${vlanTag['create']}
    [Setup]    create right vlan by UI    ${defaultNameTD}3
    into vlan manage UI
    click create vlan button
    ${upper}    Convert To Uppercase    ${defaultNameTD}3
    input vlan name    ${upper}
    click save button
    verify vlan name error msg    ${vlanUI['msg7']}
    [Teardown]    delete all vlan by UI

新建vlan_vlan值没有任何字串
    [Tags]    ${vlanTag['create']}
    into vlan manage UI
    click create vlan button
    input vlan name    ${defaultNameTD}4
    input vlan value    ${EMPTY}
    click save button
    verify vlan value error msg    ${vlanUI['msg2']}

新建vlan_vlan值全为空格
    [Tags]    ${vlanTag['create']}
    into vlan manage UI
    click create vlan button
    input vlan name    ${defaultNameTD}5
    input vlan value    ${SPACE*8}
    click save button
    verify vlan value error msg    ${vlanUI['msg2']}

新建vlan_vlan值格式错误
    [Tags]    ${vlanTag['create']}
    into vlan manage UI
    click create vlan button
    input vlan name    ${defaultNameTD}6
    : FOR    ${value}    IN    @{vlanTD['valueE2']}
    \    input vlan value    ${value}
    \    click save button
    \    Run Keyword And Continue On Failure    verify vlan value error msg    ${vlanUI['msg3']}

新建vlan_vlan值不在范围内
    [Tags]    ${vlanTag['create']}
    into vlan manage UI
    click create vlan button
    input vlan name    ${defaultNameTD}7
    : FOR    ${value}    IN    @{vlanTD['valueE1']}
    \    input vlan value    ${value}
    \    click save button
    \    Run Keyword And Continue On Failure    verify vlan value error msg    ${vlanUI['msg4']}

新建vlan_vlan值正确
    [Tags]    ${vlanTag['create']}    smokeCase
    : FOR    ${i}    IN    @{vlanTD['valueR']}
    \    ${value}    Convert To String    ${i}
    \    into vlan manage UI
    \    click create vlan button
    \    input vlan name    ${value}
    \    input vlan value    ${value}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify vlan value by UI    ${value}    ${value}
    [Teardown]    delete all vlan by UI

新建vlan_取消按钮
    [Tags]    ${vlanTag['create']}
    into vlan manage UI
    click create vlan button
    click cancle button
    verify create vlan UI not exist

新建vlan_取消“x”
    [Tags]    ${vlanTag['create']}
    into vlan manage UI
    click create vlan button
    click "x" button
    verify create vlan UI not exist
