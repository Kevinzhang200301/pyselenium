*** Settings ***
Suite Setup    login by admin
Suite Teardown    close browser and kill chrome process
Force Tags    ${encryptGWTag['default']}
Resource    ../../Keyword/SafetyManage/EncryptGatewayKeywords.robot

*** Test Cases ***
加密网关界面信息验证
    [Tags]    ${encryptGWTag['info']}
    into encrypt gateway manage UI
    verify encrypt gateway manage UI info
    
开启网关_未勾选网关
    into encrypt gateway manage UI
    Click Element    ${erygw_start_button_ID}
    verify lobibox info    ${safeBox['msg2']}
    
关闭网关_未勾选网关
    into encrypt gateway manage UI
    Click Element    ${erygw_shutdown_button_ID}
    verify lobibox info    ${safeBox['msg2']}
    
重启网关_未勾选网关
    into encrypt gateway manage UI
    Click Element    ${erygw_restart_button_ID}
    verify lobibox info    ${safeBox['msg2']}