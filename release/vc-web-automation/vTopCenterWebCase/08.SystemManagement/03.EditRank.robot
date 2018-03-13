*** Settings ***
Suite Setup       prepare env for edit rank
Suite Teardown    clear env for edit rank
Force Tags    ${rankTag['default']}
Resource          ../../Keyword/SystemManage/RankManageKeywords.robot

*** Test Cases ***
编辑下级vTopCenter界面信息验证
    [Tags]    ${rankTag['info']}
    into rank manage UI
    click edit rank button    ${rankTD['nameD']}
    verify lay UI title info    ${rankUI['title7']}    ${rankUI['title8']}
    
编辑下级vTopCenter_名称为空
    [Tags]    ${rankTag['edit']}
    into rank manage UI
    click edit rank button    ${rankTD['nameD']}
    input rank name    ${EMPTY}
    click save button
    verify rank name error info    ${rankUI['err1']}
    
编辑下级vTopCenter_名称正确
    [Tags]    ${rankTag['edit']}    smokeCase
    ${nameNew}    Set Variable    ${rankTD['editD']}
    :FOR    ${name}    IN    @{rankTD['nameR'][1:]}
    \    into rank manage UI
    \    click edit rank button    ${nameNew}
    \    input rank name    ${name}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify rank name on the UI    ${name}
    \    ${nameNew}    Set Variable    ${name}
    
编辑下级vTopCenter_下级管理中心为空
    [Tags]    ${rankTag['edit']}
    into rank manage UI
    click edit rank button    ${rankTD['nameD']}
    input rank ip    ${EMPTY}
    click save button
    verify rank ip error info    ${rankUI['err2']}    
    
编辑下级vTopCenter_下级管理中心正确
    [Tags]    ${rankTag['edit']}    smokeCase
    :FOR    ${i}    IN    @{rankTD['addrR']}
    \    into rank manage UI
    \    click edit rank button    ${rankTD['nameD']}
    \    input rank ip    ${i}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify rank IP on the UI    ${rankTD['nameD']}    ${i}
    
编辑下级vTopCenter_密钥为空
    [Tags]    ${rankTag['edit']}
    into rank manage UI
    click edit rank button    ${rankTD['nameD']}
    input rank key    ${EMPTY}
    click save button
    verify rank key error info    ${rankUI['err3']}
    
编辑下级vTopCenter_密钥正确
    [Tags]    ${rankTag['edit']}    smokeCase
    :FOR    ${i}    IN    @{rankTD['keyR']}
    \    into rank manage UI
    \    click edit rank button    ${rankTD['nameD']}
    \    input rank key    ${i}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    
编辑下级vTopCenter_联系人正确
    [Tags]    ${rankTag['edit']}    smokeCase
    :FOR    ${i}    IN    @{rankTD['person']}
    \    into rank manage UI
    \    click edit rank button    ${rankTD['nameD']}
    \    input contact person    ${i}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify rank contact person on the UI    ${rankTD['nameD']}    ${i}
    
编辑下级vTopCenter_联系电话正确
    [Tags]    ${rankTag['edit']}    smokeCase
    :FOR    ${i}    IN    @{rankTD['mobile']}
    \    into rank manage UI
    \    click edit rank button    ${rankTD['nameD']}
    \   input contact mobile    ${i}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify rank contact mobile on the UI     ${rankTD['nameD']}    ${i}
    
编辑下级vTopCenter_未选择镜像
    [Tags]    ${rankTag['edit']}
    into rank manage UI
    click edit rank button    ${rankTD['nameD']}
    unselect rank vhd    ${rankTD['vhdNameD']}
    click save button        
    verify rank vhd error info    ${rankUI['err4']}
    
编辑下级vTopCenter_选择几个镜像
    [Tags]    ${rankTag['edit']}    smokeCase
    into rank manage UI
    click edit rank button    ${rankTD['nameD']}
    select rank vhd    @{rankTD['vhdNameR']}
    click save button    True
    verify lobibox info
    verify rank vhd info on the UI    ${rankTD['nameD']}    ${rankTD['vhdNameD']}    @{rankTD['vhdNameR']}

删除下级vTopCenter_弹窗信息验证
    [Tags]    ${rankTag['info']}
    into rank manage UI
    click delete rank button    ${rankTD['del']}
    verify confirm box info    ${rankUI['msg1']}    

删除下级vTopCenter_取消
    [Tags]    ${rankTag['del']}
    into rank manage UI
    click delete rank button    ${rankTD['del']}
    click confirm box cancel button
    verify confirm not exist

删除下级vTopCenter_确定
    [Tags]    ${rankTag['del']}    smokeCase
    into rank manage UI
    click delete rank button    ${rankTD['del']}
    click confirm box confirm button
    verify lobibox info    ${sysBox['msg1']}
    ${status}    Run Keyword And Return Status    verify rank name on the UI    ${rankTD['del']}
    Should Be Equal As Strings    ${status}    False

搜索下级vTopCenter_输入任何值
    [Tags]    ${rankTag['search']}
    into rank manage UI
    ${num}    get current table record number    
    open the search UI
    input search rank name    ${EMPTY}
    input search rank ip    ${EMPTY}
    click search button
    verify table records current page    ${num}    
    
搜索下级vTopCenter_不存在的名称
    [Tags]    ${rankTag['search']}
    into rank manage UI
    :FOR    ${txt}    IN    @{rankTD['srcNoName']}
    \    open the search UI
    \    input search rank name    ${txt}
    \    click search button
    \    Run Keyword And Continue On Failure    verify table records current page    0
      
搜索下级vTopCenter_不存在的IP
    [Tags]    ${rankTag['search']}
    into rank manage UI
    :FOR    ${ip}    IN    @{rankTD['srcNoIp']}
    \    open the search UI
    \    input search rank ip    ${ip}
    \    click search button
    \    Run Keyword And Continue On Failure    verify table records current page    0

搜索下级vTopCenter_已存在的完整名称
    [Tags]    ${rankTag['search']}
    into rank manage UI
    open the search UI
    input search rank name    ${rankTD['srcName'][1]}
    input search rank ip    ${EMPTY}
    click search button
    verify table records current page    1    
    
搜索下级vTopCenter_已存在的完整IP
    [Tags]    ${rankTag['search']}
    into rank manage UI
    open the search UI
    input search rank name    ${EMPTY}
    input search rank ip    ${rankTD['srcIp'][1]}
    click search button
    verify table records current page    1        
    
搜索下级vTopCenter_名称存在IP不存在
    [Tags]    ${rankTag['search']}
    into rank manage UI
    open the search UI
    input search rank name    ${rankTD['srcName'][1]}
    input search rank ip    ${rankTD['srcNoIp'][0]}
    click search button
    verify table records current page    0
    
搜索下级vTopCenter_名称不存在IP存在
    [Tags]    ${rankTag['search']}
    into rank manage UI
    open the search UI
    input search rank name    ${rankTD['srcNoName'][0]}
    input search rank ip    ${rankTD['srcIp'][0]}
    click search button
    verify table records current page    0
    
搜索下级vTopCenter_已存在名称部分字段
    [Tags]    ${rankTag['search']}
    into rank manage UI
    ${len}    Get Length    ${rankTD['srcName']}
    open the search UI
    input search rank name    ${rankTD['srcName'][0]}
    input search rank ip    ${EMPTY}
    click search button
    verify table records current page    ${len}
    
搜索下级vTopCenter_已存在IP部分字段
    [Tags]    ${rankTag['search']}
    into rank manage UI
    ${len}    Get Length    ${rankTD['srcIp']}
    open the search UI
    input search rank name    ${EMPTY}
    input search rank ip    ${rankTD['srcIp'][0][:12]}
    click search button
    verify table records current page    ${len}