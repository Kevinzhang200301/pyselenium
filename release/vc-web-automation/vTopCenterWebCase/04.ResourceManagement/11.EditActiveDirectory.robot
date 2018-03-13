*** Settings ***
Suite Setup       prepare env for edit ad
Suite Teardown    clear env for edit ad
Force Tags    ${adTag['default']}
Resource          ../../Keyword/ResourceManage/ActiveDirectoryKeywords.robot

*** Test Cases ***
编辑AD域界面信息验证
    [Tags]    ${adTag['info']}
    into ad manage UI
    click edit ad button    ${ADTD['nameD']}
    verify lay UI title info    ${ADUI['title6']}

编辑AD域_名称为空
    [Tags]    ${adTag['edit']}
    into ad manage UI
    click edit ad button    ${ADTD['nameD']}
    input ad name    ${EMPTY}
    click save button
    verify ad name error info    ${ADUI['msg1']}

编辑AD域_错误格式的名称
    [Tags]    ${adTag['edit']}
    into ad manage UI
    click edit ad button    ${ADTD['nameD']}
    : FOR    ${name}    IN    @{ADTD['nameE']}
    \    input ad name    ${name}
    \    click save button
    \    Run Keyword And Continue On Failure    verify ad name error info    ${ADUI['msg9']}

编辑AD域_名称正确
    [Tags]    ${adTag['edit']}    smokeCase
    ${nameNew}    Set Variable    ${editNameTD}
    into ad manage UI
    : FOR    ${name}    IN    @{ADTD['nameR']}
    \    click edit ad button    ${nameNew}
    \    input ad name    ${name}
    \    ${nameNew}    Set Variable    ${name}
    \    input ad IP    ${ADTD['ipD']}
    \    input ad user    ${defaultNameTD}
    \    input ad password    ${defaultNameTD}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify ad name exist by UI    ${name}


编辑AD域_名称重复
    [Tags]    ${adTag['edit']}
    into ad manage UI
    click edit ad button    ${ADTD['nameD']}
    input ad name    ${searchNameList[0]}
    click save button
    verify ad name error info    ${ADUI['msg4']}

新建AD域_名称忽略大小写
    [Tags]    ${adTag['edit']}
    into ad manage UI
    click edit ad button    ${ADTD['nameD']}
    ${upper}    Convert To Uppercase    ${searchNameList[1]}
    input ad name    ${upper}
    click save button
    verify ad name error info    ${ADUI['msg4']}

编辑AD域_服务器地址为空
    [Tags]    ${adTag['edit']}
    into ad manage UI
    click edit ad button    ${ADTD['nameD']}
    input ad IP    ${EMPTY}
    click save button
    verify ad ip error info    ${ADUI['msg5']}

编辑AD域_服务器地址正确
    [Tags]    ${adTag['edit']}    smokeCase
    into ad manage UI
    click edit ad button    ${ADTD['nameD']}
    input ad IP    ${ADTD['ipR']}
    click save button    True
    verify lobibox info
    verify ad IP by UI    ${ADTD['nameD']}    ${ADTD['ipR']}

编辑AD域_服务器地址格式异常
    [Tags]    ${adTag['edit']}
    into ad manage UI
    click edit ad button    ${ADTD['nameD']}
    : FOR    ${ip}    IN    ${ADTD['ipE']}
    \    input ad IP    ${ip}
    \    click save button
    \    Run Keyword And Continue On Failure    verify ad ip error info    ${ADUI['msg7']}

编辑AD域_用户名为空
    [Tags]    ${adTag['edit']}
    into ad manage UI
    click edit ad button    ${ADTD['nameD']}
    input ad user    ${EMPTY}
    click save button
    verify ad user error info    ${ADUI['msg6']}

编辑AD域_密码为空
    [Tags]    ${adTag['edit']}
    into ad manage UI
    click edit ad button    ${ADTD['nameD']}
    input ad password    ${EMPTY}
    click save button
    verify ad password error info    ${ADUI['msg8']}

编辑AD域_修改说明
    [Tags]    ${adTag['edit']}
    into ad manage UI
    click edit ad button    ${ADTD['nameD']}
    input ad description    ${allSymbolTD}${numberTD}${lettersTD}
    click save button    True
    verify lobibox info

搜索AD域_不输入任何值点击搜索
    [Tags]    ${adTag['search']}
    into ad manage UI
    ${adNum1}    get current table record number    ${public_table_ID}
    input search ad name    ${EMPTY}
    click search button
    verify table records current page    ${adNum1}

搜索AD域_不存在的ad域
    [Tags]    ${adTag['search']}
    into ad manage UI
    : FOR    ${name}    IN    @{searchNoName}
    \    input search ad name    ${name}
    \    click search button
    \    Run Keyword And Continue On Failure    verify table records current page    0

搜索AD域_已存在的ad域
    [Tags]    ${adTag['search']}
    into ad manage UI
    input search ad name    ${searchNameList[1]}
    click search button
    verify table records current page    1

搜索AD域_已存在AD域的部分字段
    [Tags]    ${adTag['search']}
    into ad manage UI
    ${len}    Get Length    ${searchNameList}
    input search ad name    ${searchNameList[0]}
    click search button
    verify table records current page    ${len}

删除AD域_弹窗信息验证
    [Tags]    ${adTag['info']}
    into ad manage UI
    click delete ad button    ${deleteNameTD}
    verify confirm box info    ${ADUI['msg10']}

删除AD域_取消
    [Tags]    ${adTag['del']}
    into ad manage UI
    click delete ad button    ${deleteNameTD}
    click confirm box cancel button
    verify confirm not exist

删除AD域_确定
    [Tags]    ${adTag['del']}
    into ad manage UI
    click delete ad button    ${deleteNameTD}
    click confirm box confirm button
    ${status}    Run Keyword And Return Status    verify ad name exist by UI    ${deleteNameTD}
    Should Be Equal As Strings    ${status}    False

删除AD域_已分配模板
    [Tags]    ${adTag['del']}
    into ad manage UI
    click delete ad button    ${ADTD['nameD']}
    click confirm box confirm button
    verify lobibox info    ${resBox['msg2']}
