*** Settings ***
Suite Setup       login by admin
Suite Teardown    close browser and kill chrome process
Test Teardown     Reload Page
Force Tags        logoutCase
Variables         ../../TestData/LoginLogoutData.py
Resource          ../../Keyword/LoginLogoutKeywords.robot

*** Test Cases ***
登出用户弹框信息验证
    click logout button
    verify confirm box info    ${loginBox['msg1']}    ${loginBox['title1']}

取消登出用户
    click logout button
    click confirm box cancel button
    verify confirm not exist

登出用户
    [Tags]    smokeCase
    click logout button
    click confirm box confirm button
    Wait Until Element Is Visible    ${login_bth_ID}    error=退出登录失败，登录按钮不可见
