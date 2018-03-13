*** Settings ***
Suite Setup    login by admin
Suite Teardown    close browser and kill chrome process
Force Tags    ${vTopTag['default']}
Resource    ../../keyword/vTopManage/vTopKeywords.robot

*** Test Cases ***
vTop管理界面信息验证
    [Tags]    ${vTopTag['info']}
    into vtop manage UI
    verify vtop manage UI info

用快捷键打开vtop管理界面
    refresh page
    Click Element    //button[contains(@onclick,'quickClick2')]
    Wait Until Element Is Visible    ${vtop_manage_UI_ID}
    Select Frame    ${vtop_manage_iframe_ID}
    Select Frame    ${vtop_manage_iframe1_ID}
    Wait Until Element Is Visible    ${vtop_start_button_ID}
    
vTop开机_未勾选vTop
    into vtop manage UI
    click start vtop button
    verify lobibox info    ${vtopBox['msg3']}
    
vTop关机_未勾选vtop
    into vtop manage UI
    click shutdown vtop button
    verify lobibox info    ${vtopBox['msg3']}
    
vTop重启_未勾选vTop
    into vtop manage UI
    click restart vtop button
    verify lobibox info    ${vtopBox['msg3']}
    
推送镜像_未勾选vtop
    into vtop manage UI
    click vtop push vhd button
    verify lobibox info    ${vtopBox['msg3']}
    
更换位置_未勾选vTop
    into vtop manage UI
    click vtop change location button
    verify lobibox info    ${vtopBox['msg3']}
    
启用自动登录_未勾选vtop
    into vtop manage UI
    click vtop start auto sign-in button
    verify lobibox info    ${vtopBox['msg3']}
    
禁用自动登录_未勾选vTop
    into vtop manage UI
    click vtop stop auto sign-in button
    verify lobibox info    ${vtopBox['msg4']}
    
vTop升级未勾选vTop
    into vtop manage UI
    click vtop upgrade button
    verify lobibox info    ${vtopBox['msg3']}
    
绑定用户_未勾选vTop
    into vtop manage UI
    click vtop bind user button
    verify lobibox info    ${vtopBox['msg3']}
    
取消绑定_未勾选vTop
    into vtop manage UI
    click vtop unbind button
    verify lobibox info    ${vtopBox['msg4']}
    
设置成网关_未勾选vTop
    into vtop manage UI
    click vtop set gateway button
    verify lobibox info    ${vtopBox['msg5']}      