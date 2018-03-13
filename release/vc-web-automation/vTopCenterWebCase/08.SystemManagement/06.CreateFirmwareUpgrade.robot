*** Settings ***
Suite Setup    login by admin
Suite Teardown    close browser and kill chrome process
Force Tags    ${vcupTag['default']}
Resource    ../../Keyword/SystemManage/FirmwareUpgradeKeywords.robot

*** Test Cases ***
固件升级管理界面信息验证
    [Tags]    ${vcupTag['info']}
    [Setup]    create right vc uploade iso by UI    ${vcupTD['nameD']}
    into firmware upgrade manage UI
    verify firmware upgrade manage table info
    verify firmware upgrade manage other info
    [Teardown]    delete all vc upgrade package by UI
    
上传升级包界面信息验证
    [Tags]    ${vcupTag['info']}
    into firmware upgrade manage UI
    click upload vc upgrade package button
    verify lay UI title info    ${vcupUI['title9']}
    verify upgrade vc iso UI form info
    
升级界面信息验证
    [Tags]    ${vcupTag['info']}
    [Setup]    create right vc uploade iso by UI    ${vcupTD['nameD']}1
    into firmware upgrade manage UI
    click upgrade vc button
    verify lay UI title info    ${vcupUI['title1']}
    verify same element text by UI    ${layui_label_ID}
    ...    ${vcupUI['labelL2']}    ${vcupTD['nameD']}1    
    [Teardown]    delete all vc upgrade package by UI
    
设置时间界面信息验证
    [Tags]    ${vcupTag['info']}
    into firmware upgrade manage UI
    click set vc date button
    verify set vc date UI form info
    
上传升级包_文件为空
    [Tags]    ${vcupTag['create']}
    into firmware upgrade manage UI
    click upload vc upgrade package button
    click save button
    verify upload vc iso error info    ${vcupUI['err3']}

上传升级包_升级包名称为空
    [Tags]    ${vcupTag['create']}
    into firmware upgrade manage UI
    click upload vc upgrade package button
    choose vTopCenter iso path    ${vcupTD['fileR']}
    click upload button of upgrade vc package UI
    wait until file upload down        
    input upgrade package name    ${EMPTY}
    click save button
    verify vc package name error info    ${vcupUI['err4']}
    
上传升级包_文件格式错误
    [Tags]    ${vcupTag['create']}
    into firmware upgrade manage UI
    click upload vc upgrade package button
    :FOR    ${file}    IN    @{vcupTD['fileE']}
    \    choose vTopCenter iso path    ${file}
    \    Run Keyword And Continue On Failure    verify upload vc iso error info    ${vcupUI['err5']}

上传升级包_文件名和名称正确
    [Tags]    ${vcupTag['create']}    smokeCase
    :FOR    ${name}    IN    @{vcupTD['nameR']}
    \    into firmware upgrade manage UI
    \    click upload vc upgrade package button
    \    choose vTopCenter iso path    ${vcupTD['fileR']}
    \    click upload button of upgrade vc package UI
    \    wait until file upload down        
    \    input upgrade package name    ${name}
    \    click save button    True
    \    verify lobibox info
    \    verify vc package name on the UI    ${name}
    [Teardown]    delete all vc upgrade package by UI
