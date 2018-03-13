*** Settings ***
Suite Setup    prepare env for safety sort
Suite Teardown    clear env for safety sort
Resource    ../../Keyword/SafetyManage/SortKeywords.robot

*** Test Cases ***
网络密钥界面_名称排序
    [Tags]    ${networkKeyTag['sort']}
    into network key manage UI
    ${list1}    get table column text on UI    1
    click name on network key UI for sort
    ${list2}    get table column text on UI    1
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}
    
加密网关界面_网关名称排序
    [Tags]    ${encryptGWTag['sort']}
    into encrypt gateway manage UI
    click name on encrypt gateway UI for sort
    
审计管理界面_请求时间排序
    [Tags]    ${auditTag['sort']}
    into audit manage UI
    click request time on audit UI for sort
    
审计管理界面_用户排序
    [Tags]    ${auditTag['sort']}
    into audit manage UI
    click user on audit UI for sort
    
审计管理界面_主机排序
    [Tags]    ${auditTag['sort']}
    into audit manage UI
    click host on audit UI for sort
    
审计管理界面_源虚拟机排序
    [Tags]    ${auditTag['sort']}
    into audit manage UI
    click source vm on audit UI for sort
    
审计管理界面_目的虚拟机排序
    [Tags]    ${auditTag['sort']}
    into audit manage UI
    click purpose vm on audit UI for sort
    
审计管理界面_请求类型排序
    [Tags]    ${auditTag['sort']}
    into audit manage UI
    click request type on audit UI for sort
        
审计管理界面_审核状态排序
    [Tags]    ${auditTag['sort']}
    into audit manage UI
    click status on audit UI for sort    

审计管理界面_传输结果排序
    [Tags]    ${auditTag['sort']}
    into audit manage UI
    click result on audit UI for sort                 