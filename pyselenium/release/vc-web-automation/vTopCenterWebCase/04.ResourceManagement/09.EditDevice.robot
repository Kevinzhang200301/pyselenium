*** Settings ***
Suite Setup       prepare env for edit device
Suite Teardown    clear env for edit device
Force Tags    ${deviceTag['default']}
Resource          ../../Keyword/ResourceManage/DeviceKeywords.robot

*** Test Cases ***
编辑设备界面信息验证
    [Tags]    ${deviceTag['info']}
    into device manage UI
    click edit device button    ${defaultNameTD}
    verify lay UI title info    ${deviceUI['title3']}

编辑设备_名称为空
    [Tags]    ${deviceTag['edit']}
    into device manage UI
    click edit device button    ${defaultNameTD}
    input device name    ${EMPTY}
    click save button
    verify device name error info    ${deviceUI['msg1']}

编辑设备_名称为单引号
    [Tags]    ${deviceTag['edit']}
    into device manage UI
    click edit device button    ${defaultNameTD}
    input device name    ${deviceTD['nameE']}
    click save button
    verify device name error info    ${deviceUI['msg6']}

编辑设备_名称正常
    [Tags]    ${deviceTag['edit']}    smokeCase
    ${nameNew}    Set Variable    ${editNameTD}
    into device manage UI
    : FOR    ${name}    IN    @{deviceTD['nameR']}
    \    click edit device button    ${nameNew}
    \    input device name    ${name}
    \    ${nameNew}    Set Variable    ${name}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify device exist on the UI    ${name}

编辑设备_修改标签
    [Tags]    ${deviceTag['edit']}    smokeCase
    into device manage UI
    click edit device button    ${defaultNameTD}
    input device tag    ${allSymbolTD}
    click save button    True
    verify lobibox info

编辑设备_设备类型
    [Tags]    ${deviceTag['edit']}    smokeCase
    into device manage UI
    : FOR    ${type}    IN    @{deviceUI['typeList']}
    \    click edit device button    ${defaultNameTD}
    \    select device type    ${type}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify device type on the UI    ${defaultNameTD}    ${type}

编辑设备_产商ID为空
    [Tags]    ${deviceTag['edit']}
    into device manage UI
    click edit device button    ${defaultNameTD}
    input device vid    ${EMPTY}
    click save button
    verify device vid error info    ${deviceUI['msg3']}

编辑设备_正确产商ID
    [Tags]    ${deviceTag['edit']}    smokeCase
    into device manage UI
    click edit device button    ${defaultNameTD}
    input device vid    ${allSymbolTD}
    click save button    True
    verify lobibox info
    verify device vid on the UI    ${defaultNameTD}    ${allSymbolTD}

编辑设备_产品ID为空
    [Tags]    ${deviceTag['edit']}
    into device manage UI
    click edit device button    ${defaultNameTD}
    input device pid    ${EMPTY}
    click save button
    verify device pid error info    ${deviceUI['msg2']}

编辑设备_正确的产品ID
    [Tags]    ${deviceTag['edit']}    smokeCase
    into device manage UI
    click edit device button    ${defaultNameTD}
    input device pid    ${allSymbolTD}
    click save button    True
    verify lobibox info
    verify device pid on the UI    ${defaultNameTD}    ${allSymbolTD}

编辑设备_修改描述
    [Tags]    ${deviceTag['edit']}    smokeCase
    into device manage UI
    click edit device button    ${defaultNameTD}
    input device description    ${allSymbolTD}
    click save button    True
    verify lobibox info

搜索设备_不输入任何值
    [Tags]    ${deviceTag['search']}
    into device manage UI
    input search device name    ${EMPTY}
    click search button
    ${num}    get current table record number
    verify table records current page    ${num}

搜索设备_不存在的设备
    [Tags]    ${deviceTag['search']}
    into device manage UI
    : FOR    ${name}    IN    @{searchNoName}
    \    input search device name    ${name}
    \    click search button
    \    Run Keyword And Continue On Failure    verify table records current page    0

搜索设备_已存在的设备
    [Tags]    ${deviceTag['search']}
    into device manage UI
    input search device name    ${searchNameList[1]}
    click search button
    verify table records current page    1

搜索设备_已存在设备的部分字段
    [Tags]    ${deviceTag['search']}
    into device manage UI
    ${len}    Get Length    ${searchNameList}
    input search device name    ${searchNameList[0]}
    click search button
    verify table records current page    ${len}

删除设备_弹窗信息验证
    [Tags]    ${deviceTag['info']}
    into device manage UI
    click delete device button    ${deleteNameTD}
    verify confirm box info    ${deviceUI['msg5']}

删除设备_取消
    [Tags]    ${deviceTag['del']}
    into device manage UI
    click delete device button    ${deleteNameTD}
    click confirm box cancel button
    verify confirm not exist

删除设备_确定
    [Tags]    ${deviceTag['del']}    smokeCase
    into device manage UI
    click delete device button    ${deleteNameTD}
    click confirm box confirm button
    verify lobibox info    ${resBox['msg4']}
    ${status}    Run Keyword And Return Status    verify device exist on the UI    ${deleteNameTD}
    Should Be Equal As Strings    ${status}    False

删除设备_已分配设备策略
    [Tags]    ${deviceTag['del']}
    into device manage UI
    click delete device button    ${defaultNameTD}
    click confirm box confirm button
    verify lobibox info    ${resBox['msg3']}
