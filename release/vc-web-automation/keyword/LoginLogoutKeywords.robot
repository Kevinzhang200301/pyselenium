*** Settings ***
Variables         ../TestData/LoginLogoutData.py
Resource          PublicKeywords.robot
Resource          ../ElementLocators/PublicElementID.robot
Resource          ../Keyword/AdministratorKeywords.robot

*** Keywords ***
verify login error message
    [Arguments]    ${errMsg}
    [Documentation]    用户名和密码输入异常时提示信息验证，
    ...    参数：错误的提示信息
    Wait Until Element Is Visible    ${login_errMSG_ID}    error=未有错误提示信息
    Element Text Should Be    ${login_errMSG_ID}    ${errMsg}

verify login success
    [Arguments]    ${adminName}=admin    ${realName}=管理员
    [Documentation]    检查vTopCenter用户登录成功
    ...    参数:1.登录用户名(默认为admin)；2.登录用户的真实姓名(默认为管理员,None表示不验证登录用户的真实姓名)
    Wait Until Element Is Not Visible    ${login_bth_ID}    error=登录按钮仍可见,登录失败
    Wait Until Element Is Visible    ${main_welcome_button}    error=页面右上角用户管理按钮，登录失败
    Run Keyword If    '${realName}'!='None'    verify element title attribute value    ${main_welcome_info}    ${realName}
    verify element text    ${main_welcome_info}    ${welcomelable}${adminName}
    wait Until Element Is Visible    ${homepage_tab_ID}    error=“我的主页”信息异常，登录失败

click login button
    [Documentation]    在vTopCenter登录界面模拟鼠标点击登录按钮
    Wait Until Element Is Visible    ${login_bth_ID}
    Click Button    ${login_bth_ID}
    Sleep    ${clickSleep}

click logout button
    [Documentation]    点击登出按钮
    click login user manage button
    Wait Until Element Is Visible    ${main_logout_button}    error=没有看到登出图标
    Click Element    ${main_logout_button}
    Sleep    ${clickSleep}

input login password
    [Arguments]    ${login_pwd}
    [Documentation]    输入vTopCenter登录的密码
    ...    参数：登录密码
    Clear Element Text    ${login_pwd_ID}
    Input Password    ${login_pwd_ID}    ${login_pwd}
    Sleep    ${inputSleep}

input login user
    [Arguments]    ${login_user}
    [Documentation]    输入vTopCenter登录的用户名
    ...    参数：登录用户名
    Clear Element Text    ${login_name_ID}
    Input Text    ${login_name_ID}    ${login_user}
    Sleep    ${inputSleep}

prepare env for admin expired
    [Documentation]    为测试过期管理员登录准备环境：1.admin用户登录；2.创建过期管理员
    login by admin
    create admin user by UI    ${defaultNameTD}    date=2017-08-03
    close browser and kill chrome process

prepare env for admin stop
    [Documentation]    为测试停用管理员登录准备环境：1.admin用户登录；2.创建过期管理员
    login by admin
    create admin user by UI    ${defaultNameTD}    status=stop
    close browser and kill chrome process

press enter key login
    [Documentation]    在vTopCenter登录界面模拟按回车键
    enter key    ${login_pwd_ID}
    Sleep    ${clickSleep}

verify login UI info
    [Documentation]    vTopCenter登录界面信息验证
    Page Should Contain Image    ${login_vtopimg_ID}    message=不包括vtopcenter图片
    ${att_str1}    Get Element Attribute    ${login_vtopimg_ID}@src
    Should Contain    ${att_str1}    https://${vc_ip}
    Should Contain    ${att_str1}    ${loginUI['imgName']}
    verify element placeholder attribute value    ${login_name_ID}    ${loginUI['title2']}
    verify element placeholder attribute value    ${login_pwd_ID}    ${loginUI['title3']}
    verify element text    ${login_bth_ID}    ${loginUI['button1']}
