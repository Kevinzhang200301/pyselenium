*** Settings ***
Suite Setup    prepare env for edit vc package
Suite Teardown    clear env for edit vc package
Force Tags    ${vcupTag['default']}
Resource    ../../Keyword/SystemManage/FirmwareUpgradeKeywords.robot

*** Test Cases ***
编辑升级包界面信息验证
    [Tags]    ${vcupTag['info']}
    into firmware upgrade manage UI
    click edit vc package button    ${vcupTD['nameD']}
    verify lay UI title info    ${vcupUI['title11']}
    
编辑升级包_升级包名称为空
    [Tags]    ${vcupTag['edit']}
    into firmware upgrade manage UI
    click edit vc package button    ${vcupTD['nameD']}
    input upgrade package name    ${EMPTY}
    click save button
    verify vc package name error info    ${vcupUI['err4']}

编辑升级包_升级包名称正确
    [Tags]    ${vcupTag['edit']}    smokeCase
    into firmware upgrade manage UI
    click edit vc package button    ${vcupTD['editD']}
    input upgrade package name    ${vcupTD['editR']}
    click save button    True
    verify vc package name on the UI    ${vcupTD['editR']}

搜索升级包_不输入任何值
    [Tags]    ${vcupTag['search']}
    into firmware upgrade manage UI
    ${num}    get current table record number    
    input search vc package name    ${EMPTY}
    click search button
    verify table records current page    ${num}    
    
搜索升级包_不存在的名称
    [Tags]    ${vcupTag['search']}
    into firmware upgrade manage UI
    :FOR    ${name}    IN    @{vcupTD['srcNoName']}
    \    input search vc package name    ${name}
    \    click search button
    \    Run Keyword And Continue On Failure    verify table records current page    0

搜索升级包_已存在的完整名称
    [Tags]    ${vcupTag['search']}
    into firmware upgrade manage UI
    input search vc package name    ${vcupTD['srcName'][1]}
    click search button
    verify table records current page    1
    
搜索升级包_已存在名称的部分字段
    [Tags]    ${vcupTag['search']}
    into firmware upgrade manage UI
    ${len}    Get Length    ${vcupTD['srcName']}
    input search vc package name    ${vcupTD['srcName'][0]}    
    click search button
    verify table records current page    ${len}    

重启VC_弹窗信息验证
    [Tags]    ${vcupTag['info']}
    into firmware upgrade manage UI
    click restart vc button
    verify confirm box info    ${vcupUI['msg3']}
    
重启VC_取消
    [Tags]    ${vcupTag['restart']}
    into firmware upgrade manage UI
    click restart vc button
    click confirm box cancel button
    verify confirm not exist
    
关闭VC_弹窗信息验证
    [Tags]    ${vcupTag['info']}
    into firmware upgrade manage UI
    click shutdown vc button
    verify confirm box info    ${vcupUI['msg4']}
    
关闭VC_取消
    [Tags]    ${vcupTag['shutdown']}
    into firmware upgrade manage UI
    click shutdown vc button
    click confirm box cancel button
    verify confirm not exist    
    
删除升级包_弹窗信息验证
    [Tags]    ${vcupTag['info']}
    into firmware upgrade manage UI
    click delete vc package button    ${vcupTD['del']}
    verify confirm box info    ${vcupUI['msg2']}            

删除升级包_取消
    [Tags]    ${vcupTag['del']}
    into firmware upgrade manage UI
    click delete vc package button    ${vcupTD['del']}
    click confirm box cancel button
    verify confirm not exist

删除升级包_确定
    [Tags]    ${vcupTag['del']}
    into firmware upgrade manage UI
    click delete vc package button    ${vcupTD['del']}
    click confirm box confirm button
    ${status}    Run Keyword And Return Status    verify vc package name on the UI    ${vcupTD['del']}
    Should Be Equal As Strings    ${status}    False        