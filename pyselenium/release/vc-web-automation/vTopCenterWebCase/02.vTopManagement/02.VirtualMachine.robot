*** Settings ***
Suite Setup    login by admin
Suite Teardown    close browser and kill chrome process
Force Tags    ${vmTag['default']}
Resource    ../../keyword/vTopManage/VirtualMachineKeywords.robot

*** Test Cases ***
虚拟机管理界面信息验证
    [Tags]    ${vmTag['info']}
    into VM manage UI
    verify vm manage UI info

用快捷键打开虚拟机管理界面
    refresh page
    Click Element    //button[contains(@onclick,'quickClick3')]
    Wait Until Element Is Visible    ${vm_manage_UI_ID}
    Select Frame    ${vm_manage_iframe_ID}
    Wait Until Element Is Visible    ${vm_delete_button_ID}
    
删除虚拟机_未勾选vm
    into VM manage UI
    click delete vm button
    verify lobibox info    ${vtopBox['msg2']}
    
虚拟机开机_未勾选VM
    into VM manage UI
    click start vm button
    verify lobibox info    ${vtopBox['msg2']}
    
虚拟机关机_未勾选VM
    into VM manage UI
    click shutdown vm button
    verify lobibox info    ${vtopBox['msg2']}
    
虚拟机重启_未勾选VM
    into VM manage UI
    click restart vm button
    verify lobibox info    ${vtopBox['msg2']}
    
虚拟机更新_未勾选VM
    into VM manage UI
    click update vm button
    verify lobibox info    ${vtopBox['msg2']}
    
虚拟机还原_未勾选VM
    into VM manage UI
    click rollback button
    verify lobibox info    ${vtopBox['msg2']}
       