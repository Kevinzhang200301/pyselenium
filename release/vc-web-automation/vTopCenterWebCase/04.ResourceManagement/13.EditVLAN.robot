*** Settings ***
Suite Setup       prepare env for edit vlan
Suite Teardown    clear env for edit vlan
Force Tags    ${vlanTag['default']}
Resource          ../../Keyword/ResourceManage/VlanKeywords.robot

*** Test Cases ***
编辑vlan界面信息验证
    [Tags]    ${vlanTag['info']}
    into vlan manage UI
    click edit vlan button    ${defaultNameTD}
    verify lay UI title info    ${vlanUI['title3']}

编辑vlan_名称不输入任何值
    [Tags]    ${vlanTag['edit']}
    into vlan manage UI
    click edit vlan button    ${defaultNameTD}
    input vlan name    ${EMPTY}
    click save button
    verify vlan name error msg    ${vlanUI['msg1']}

编辑vlan_名称全为空格
    [Tags]    ${vlanTag['edit']}
    into vlan manage UI
    click edit vlan button    ${defaultNameTD}
    input vlan name    ${SPACE*8}
    click save button
    verify vlan name error msg    ${vlanUI['msg1']}

编辑vlan_名称重复
    [Tags]    ${vlanTag['edit']}
    into vlan manage UI
    click edit vlan button    ${defaultNameTD}
    input vlan name    ${deleteNameTD}
    click save button
    verify vlan name error msg    ${vlanUI['msg7']}

编辑vlan_名称忽略大小写
    [Tags]    ${vlanTag['edit']}
    into vlan manage UI
    click edit vlan button    ${defaultNameTD}
    ${upper}    Convert To Uppercase    ${deleteNameTD}
    input vlan name    ${upper}
    click save button
    verify vlan name error msg    ${vlanUI['msg7']}

编辑vlan_名称正确
    [Tags]    ${vlanTag['edit']}    smokeCase
    into vlan manage UI
    click edit vlan button    ${editNameTD}
    input vlan name    ${vlanTD['nameR']}
    click save button    True
    verify lobibox info
    verify vlan name exist by UI    ${vlanTD['nameR']}

编辑vlan_vlan值没有任何字串
    [Tags]    ${vlanTag['edit']}
    into vlan manage UI
    click edit vlan button    ${defaultNameTD}
    input vlan value    ${EMPTY}
    click save button
    verify vlan value error msg    ${vlanUI['msg2']}

编辑vlan_vlan值全为空格
    [Tags]    ${vlanTag['edit']}
    into vlan manage UI
    click edit vlan button    ${defaultNameTD}
    input vlan value    ${SPACE*8}
    click save button
    verify vlan value error msg    ${vlanUI['msg2']}

编辑vlan_vlan值格式错误
    [Tags]    ${vlanTag['edit']}
    into vlan manage UI
    click edit vlan button    ${defaultNameTD}
    : FOR    ${value}    IN    @{vlanTD['valueE2']}
    \    input vlan value    ${value}
    \    click save button
    \    Run Keyword And Continue On Failure    verify vlan value error msg    ${vlanUI['msg3']}

编辑vlan_vlan值不在范围内
    [Tags]    ${vlanTag['edit']}
    into vlan manage UI
    click edit vlan button    ${defaultNameTD}
    input vlan name    ${defaultNameTD}
    : FOR    ${value}    IN    @{vlanTD['valueE1']}
    \    input vlan value    ${value}
    \    click save button
    \    Run Keyword And Continue On Failure    verify vlan value error msg    ${vlanUI['msg4']}

编辑vlan_vlan值正确
    [Tags]    ${vlanTag['edit']}    smokeCase
    : FOR    ${i}    IN    @{vlanTD['valueR']}
    \    ${value}    Convert To String    ${i}
    \    into vlan manage UI
    \    click edit vlan button    ${defaultNameTD}
    \    input vlan value    ${value}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify vlan value by UI    ${defaultNameTD}    ${value}

搜索vlan_不输入任何值点击搜索
    [Tags]    ${vlanTag['search']}
    into vlan manage UI
    ${vlanNum}    get current table record number    ${public_table_ID}
    input search vlan name    ${EMPTY}
    click search button
    verify table records current page    ${vlanNum}

搜索vlan_不存在的vlan（特殊符号）
    [Tags]    ${vlanTag['search']}
    into vlan manage UI
    : FOR    ${name}    IN    @{searchNoName}
    \    input search vlan name    ${name}
    \    click search button
    \    Run Keyword And Continue On Failure    verify table records current page    0

搜索vlan_已存在的vlan
    [Tags]    ${vlanTag['search']}
    into vlan manage UI
    input search vlan name    ${searchNameList[2]}
    click search button
    verify table records current page    1

搜索vlan_vlan名称部分字段
    [Tags]    ${vlanTag['search']}
    into vlan manage UI
    input search vlan name    ${searchNameList[0]}
    click search button
    ${len}    Get Length    ${searchNameList}
    verify table records current page    ${len}

删除vlan_弹窗信息验证
    [Tags]    ${vlanTag['info']}
    into vlan manage UI
    click delete vlan button    ${defaultNameTD}
    verify confirm box info    ${vlanUI['msg5']}

删除vlan_取消
    [Tags]    ${vlanTag['del']}
    into vlan manage UI
    click delete vlan button    ${defaultNameTD}
    click confirm box cancel button
    verify confirm not exist

删除vlan_确定
    [Tags]    ${vlanTag['search']}
    into vlan manage UI
    click delete vlan button    ${deleteNameTD}
    click confirm box confirm button
    ${status}    Run Keyword And Return Status    verify vlan name exist by UI    ${vlanTD['name']['delete']}
    Should Be Equal As Strings    ${status}    False

删除vlan_已分配给模板
    [Tags]    ${vlanTag['search']}
    into vlan manage UI
    click delete vlan button    ${defaultNameTD}
    click confirm box confirm button
    verify confirm box info    ${vlanUI['msg6']}    confirm=None    cancel=${confirmBtn3}
    click confirm box cancel button
    verify confirm not exist
