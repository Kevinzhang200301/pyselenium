*** Settings ***
Resource    NetworkKeyKeywords.robot
Resource    AuditKeywords.robot
Resource    EncryptGatewayKeywords.robot

*** Keywords ***
click name on network key UI for sort
    [Documentation]    在网络密钥界面点击名称排序
    Wait Until Element Is Visible    ${netKey_sort_name}
    Click Element    ${netKey_sort_name}
    Wait Until Element Is Visible    ${netKey_sort_name}
    
click name on encrypt gateway UI for sort
    [Documentation]    在加密网关界面点击名称排序
    Wait Until Element Is Visible    ${erygw_sort_name}
    Click Element    ${erygw_sort_name}
    Wait Until Element Is Visible    ${erygw_sort_name}
    
click request time on audit UI for sort
    [Documentation]    在审计管理界面点击请求时间排序
    Wait Until Element Is Visible    ${audit_sort_time}
    Click Element    ${audit_sort_time}
    Wait Until Element Is Visible    ${audit_sort_time}
    
click user on audit UI for sort
    [Documentation]    在审计管理界面点击用户排序
    Wait Until Element Is Visible    ${audit_sort_username}
    Click Element    ${audit_sort_username}
    Wait Until Element Is Visible    ${audit_sort_username}
    
click host on audit UI for sort
    [Documentation]    在审计管理界面点击主机排序
    Wait Until Element Is Visible    ${audit_sort_host}
    Click Element    ${audit_sort_host}
    Wait Until Element Is Visible    ${audit_sort_host}
    
click source vm on audit UI for sort
    [Documentation]    在审计管理界面点击源虚拟机排序
    Wait Until Element Is Visible    ${audit_sort_srcvm}
    Click Element    ${audit_sort_srcvm}
    Wait Until Element Is Visible    ${audit_sort_srcvm}    
    
click purpose vm on audit UI for sort
    [Documentation]    在审计管理界面点击目的虚拟机排序
    Wait Until Element Is Visible    ${audit_sort_dstvm}
    Click Element    ${audit_sort_dstvm}
    Wait Until Element Is Visible    ${audit_sort_dstvm}
    
click request type on audit UI for sort
    [Documentation]    在审计管理界面点击请求类型排序
    Wait Until Element Is Visible    ${audit_sort_type}
    Click Element    ${audit_sort_type}
    Wait Until Element Is Visible    ${audit_sort_type}
    
click status on audit UI for sort
    [Documentation]    在审计管理界面点击审核状态排序
    Wait Until Element Is Visible    ${audit_sort_state}
    Click Element    ${audit_sort_state}
    Wait Until Element Is Visible    ${audit_sort_state}
    
click result on audit UI for sort
    [Documentation]    在审计管理界面点击传输结果排序
    Wait Until Element Is Visible    ${audit_sort_result}
    Click Element    ${audit_sort_result}
    Wait Until Element Is Visible    ${audit_sort_result}
    
prepare env for safety sort
    [Documentation]    为测试安全管理排序准备环境：1.admin用户登录；2.创建网络密钥
    login by admin
    :FOR    ${i}    IN    @{sortTD['name1']}
    \    create right network key by UI    ${i}

clear env for safety sort
    [Documentation]    清空安全管理排序环境：1.删除网络密钥；2.关闭浏览器
    delete all network key by UI
    close browser and kill chrome process