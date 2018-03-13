*** Settings ***
Suite Setup    prepare env for edit network key
Suite Teardown    clear env for edit network key
Force Tags    ${networkKeyTag['default']}
Resource    ../../Keyword/SafetyManage/NetworkKeyKeywords.robot

*** Test Cases ***
编辑网络密钥界面信息验证
    [Tags]    ${networkKeyTag['info']}
    into network key manage UI
    click edit network key button    ${netKeyTD['nameD']}
    verify lay UI title info    ${netKeyUI['title6']}
    
编辑网络密钥_名称为空
    [Tags]    ${networkKeyTag['edit']}
    into network key manage UI
    click edit network key button    ${netKeyTD['nameD']}
    input network key name    ${EMPTY}
    click save button
    verify network key name error info    ${netKeyUI['err1']}
    
编辑网络密钥_名称正确
    [Tags]    ${networkKeyTag['edit']}    smokeCase
    into network key manage UI
    click edit network key button    ${netKeyTD['editD']}
    input network key name    ${netKeyTD['editR']}
    click save button    True
    verify lobibox info
    verify network key name on the UI    ${netKeyTD['nameR']}

编辑网络密钥_名称重复
    [Tags]    ${networkKeyTag['edit']}
    into network key manage UI
    click edit network key button    ${netKeyTD['nameD']}
    input network key name    ${netKeyTD['srcName'][1]}
    click save button
    verify network key name error info    ${netKeyUI['err6']}

编辑网络密钥_名称忽略大小写
    [Tags]    ${networkKeyTag['edit']}
    into network key manage UI
    click edit network key button    ${netKeyTD['nameD']}
    ${upper}    Convert To Uppercase    ${netKeyTD['srcName'][2]}
    input network key name    ${upper}
    click save button
    verify network key name error info    ${netKeyUI['err6']}
  
编辑网络密钥_值为空
    [Tags]    ${networkKeyTag['edit']}
    into network key manage UI
    click edit network key button    ${netKeyTD['nameD']}
    input network key value    ${EMPTY}
    click save button
    verify network key value error info    ${netKeyUI['err2']}
    
编辑网络密钥_值小于16位
    [Tags]    ${networkKeyTag['edit']}
    into network key manage UI
    click edit network key button    ${netKeyTD['nameD']} 
    input network key value    ${netKeyTD['valueE1']}
    click save button
    verify network key value error info    ${netKeyUI['err3']}

编辑网络密钥_值大于16位小于32位(不包括24位)
    [Tags]    ${networkKeyTag['edit']}
    into network key manage UI
    click edit network key button    ${netKeyTD['nameD']}
    input network key value    ${netKeyTD['valueE2']}
    click save button
    verify network key value error info    ${netKeyUI['err4']}    
    
编辑网络密钥_值是非数字、字母、下划线
    [Tags]    ${networkKeyTag['edit']}
    into network key manage UI
    click edit network key button    ${netKeyTD['nameD']}
    input network key value    ${netKeyTD['valueE3']}
    click save button
    verify network key value error info    ${netKeyUI['err5']}
    
编辑网络密钥_值正确
    [Tags]    ${networkKeyTag['edit']}    smokeCase
    into network key manage UI
    :FOR    ${value}    IN    @{netKeyTD['valueR']}
    \    click edit network key button    ${netKeyTD['nameD']}
    \    input network key value    ${value}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify network key value on the UI    ${netKeyTD['nameD']}    ${value}

搜索网络密钥_不输入任何值
    [Tags]    ${networkKeyTag['search']}
    into network key manage UI
    ${len}    get current table record number    
    input search network key name    ${EMPTY}
    click search button
    verify table records current page    ${len}    
  
搜索网络密钥_不存在的名称
    [Tags]    ${networkKeyTag['search']}
    into network key manage UI
    :FOR    ${txt}    IN    @{netKeyTD['srcNoName']}
    \    input search network key name    ${txt}
    \    click search button
    \    Run Keyword And Continue On Failure    verify table records current page    0      
  
搜索网络密钥_已存在的名称
    [Tags]    ${networkKeyTag['search']}
    into network key manage UI
    input search network key name    ${netKeyTD['srcName'][1]}
    click search button
    verify table records current page    1
    
搜索网络密钥_已存在名称的部分字段
    [Tags]    ${networkKeyTag['search']}
    into network key manage UI
    ${len}    Get Length    ${netKeyTD['srcName']}
    input search network key name    ${netKeyTD['srcName'][0]}
    click search button
    verify table records current page    ${len}
    
删除网络密钥_弹窗信息验证
    [Tags]    ${networkKeyTag['info']}
    into network key manage UI
    click delete network key button    ${netKeyTD['del']}
    verify confirm box info    ${netKeyUI['msg2']}
    
删除网络密钥_取消
    [Tags]    ${networkKeyTag['del']}
    into network key manage UI
    click delete network key button    ${netKeyTD['del']}
    click confirm box cancel button
    verify confirm not exist
    
删除网络密钥_确定
    [Tags]    ${networkKeyTag['del']}    smokeCase
    into network key manage UI
    click delete network key button    ${netKeyTD['del']}
    click confirm box confirm button
    ${status}    Run Keyword And Return Status    verify network key name on the UI    ${netKeyTD['del']}
    Should Be Equal As Strings    ${status}    False  

删除网络密钥_模板已使用
    [Tags]    ${networkKeyTag['del']}
    [Setup]    create right template by UI    ${defaultNameTD}6
    ...     netKey=${netKeyTD['nameD']}   
    into network key manage UI
    click delete network key button    ${netKeyTD['nameD']}
    click confirm box confirm button
    verify confirm box info    ${netKeyUI['msg3']}    confirm=None    cancel=${confirmBtn3}