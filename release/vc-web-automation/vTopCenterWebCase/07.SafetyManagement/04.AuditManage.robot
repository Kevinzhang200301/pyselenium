*** Settings ***
Suite Setup    login by admin
Suite Teardown    close browser and kill chrome process
Force Tags    ${auditTag['default']}
Resource    ../../Keyword/SafetyManage/AuditKeywords.robot

*** Test Cases ***
审计管理界面信息验证
    [Tags]    ${auditTag['info']}
    into audit manage UI
    verify audit manage UI info
    
批量删除_未选择审计
    into audit manage UI
    Click Element    ${audit_batchDel_button_ID}
    verify lobibox info    ${safeBox['msg3']}
    
通过审计_未选择审计
    into audit manage UI
    Click Element    ${audit_pass_button_ID}
    verify lobibox info    ${safeBox['msg3']}
    
驳回审计_未选择审计
    into audit manage UI
    Click Element    ${audit_refuse_button_ID}
    verify lobibox info    ${safeBox['msg3']}