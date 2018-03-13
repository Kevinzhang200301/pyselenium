*** Settings ***
Test Setup        open vtopcenter
Test Teardown     close browser and kill chrome process
Force Tags        loginCase
Resource          ../../Keyword/LoginLogoutKeywords.robot

*** Test Cases ***
登录界面信息验证
    [Tags]    smokeCase
    Wait Until Element Is Visible    ${login_bth_ID}
    verify login UI info

密码不输入任何值
    input login user    ${vc_web_user}
    input login password    ${EMPTY}
    click login button
    verify login error message    ${loginUI['err1']}

密码错误
    input login user    ${vc_web_user}
    input login password    ${loginTD['pwdE']}
    click login button
    verify login error message    ${loginUI['err3']}

用户名不输入任何值
    input login user    ${EMPTY}
    input login password    ${vc_web_pwd}
    click login button
    verify login error message    ${loginUI['err2']}

用户名错误
    input login user    ${loginTD['userE']}
    input login password    ${vc_web_pwd}
    click login button
    verify login error message    ${loginUI['err3']}

用户名和密码都不输入任何值
    input login user    ${EMPTY}
    input login password    ${EMPTY}
    click login button
    verify login error message    ${loginUI['err2']}

回车登录-错误密码
    [Documentation]    密码错误时，回车键登录
    input login user    ${vc_web_user}
    input login password    ${loginTD['pwdE']}
    click login button
    verify login error message    ${loginUI['err3']}

回车登录-用户名错误
    input login user    ${loginTD['userE']}
    input login password    ${vc_web_pwd}
    press enter key login
    verify login error message    ${loginUI['err3']}

回车登录-用户名为空
    input login user    ${EMPTY}
    input login password    ${vc_web_pwd}
    press enter key login
    verify login error message    ${loginUI['err2']}

回车登录-密码为空
    [Documentation]    密码为空时，回车键登录
    input login user    ${vc_web_user}
    input login password    ${EMPTY}
    press enter key login
    verify login error message    ${loginUI['err1']}

回车登录-用户名和密码都为空
    [Documentation]    用户名和密码都为空时，回车键登录
    input login user    ${EMPTY}
    input login password    ${EMPTY}
    press enter key login
    verify login error message    ${loginUI['err2']}

点击按钮_正常登录
    [Tags]    smokeCase
    input login user    ${vc_web_user}
    input login password    ${vc_web_pwd}
    click login button
    verify login success

回车登录-正常登录
    [Tags]    smokeCase
    input login user    ${vc_web_user}
    input login password    ${vc_web_pwd}
    press enter key login
    verify login success

登录_用户已过期
    [Setup]    prepare env for admin expired
    open vtopcenter
    input login user    ${defaultNameTD}
    input login password    ${adminUI['pwdD']}
    click login button
    verify login error message    ${loginUI['err5']}
    [Teardown]    Run Keywords    login by admin    delete all admin by UI    close browser and kill chrome process

登录_用户已停用
    [Setup]    prepare env for admin stop
    open vtopcenter
    input login user    ${defaultNameTD}
    input login password    ${adminUI['pwdD']}
    click login button
    verify login error message    ${loginUI['err4']}
    [Teardown]    Run Keywords    login by admin    delete all admin by UI    close browser and kill chrome process

http打开vTopCenter
    [Setup]    close browser and kill chrome process
    Open Browser    http://${vc_ip}    ${test_browser}
    Maximize Browser Window
    Wait Until Element Is Visible    ${login_bth_ID}
    ${url}    Execute Javascript    var url=window.location.href;return url;
    Should Be Equal As Strings    ${url}    https://${vc_ip}/
