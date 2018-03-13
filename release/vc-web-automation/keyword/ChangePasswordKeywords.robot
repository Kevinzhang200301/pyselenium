*** Settings ***
Resource          PublicKeywords.robot
Variables         ../TestData/ChangePasswordData.py

*** Keywords ***
click change password button
    [Documentation]    在页面通过“欢迎，xxx”点击修改密码按钮
    click login user manage button
    Wait Until Element Is Visible    ${main_chgpwd_button}    error=修改密码按钮不可见
    Click element    ${main_chgpwd_button}
    Wait Until Element Is Visible    ${layui_title_ID}    error=修改界面第一个title不可见
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${layui_title2_ID}    error=修改界面第二个title不可见

input confirm password
    [Arguments]    ${comfire_pwd}
    [Documentation]    在修改密码界面输入确认密码
    ...    参数：确认密码
    Clear Element Text    ${chgpwd_confirmpwd_input}
    Input Password    ${chgpwd_confirmpwd_input}    ${comfire_pwd}
    Sleep    ${inputSleep}

input new password
    [Arguments]    ${new_pwd}
    [Documentation]    在修改密码界面输入新密码
    ...    参数：新密码
    Clear Element Text    ${chgpwd_newpwd_input}
    Input Password    ${chgpwd_newpwd_input}    ${new_pwd}
    Sleep    ${inputSleep}

input old password
    [Arguments]    ${old_pwd}
    [Documentation]    在修改密码界面，输入原密码
    ...    参数：旧密码
    Clear Element Text    ${chgpwd_oldpwd_input}
    Input Password    ${chgpwd_oldpwd_input}    ${old_pwd}
    Sleep    ${inputSleep}

reset vTopCenter login password
    [Documentation]    通过数据库重置vTopCenter登录密码(admin)
    open hsdb database
    Execute Sql String    update ulms_user set password= '${chgpwdTD['md5D']}' where NAME='${vc_web_user}';
    Disconnect From Database

verify new password error message
    [Arguments]    ${error_msg}
    [Documentation]    在修改密码界面，验证输入异常新密码时提示信息
    ...    参数：新密码错误提示信息
    Wait Until Element Is Visible    ${chgpwd_newpwd_error}    error=新密码错误时没有提示信息
    verify element text    ${chgpwd_newpwd_error}    ${error_msg}

verify confirm password error message
    [Arguments]    ${error_msg}
    [Documentation]    在修改密码界面，验证输入异常确认密码时提示信息
    ...    参数：确认密码错误提示信息
    Wait Until Element Is Visible    ${chgpwd_confirmpwd_error}    error=确认密码错误时没有提示信息
    verify element text    ${chgpwd_confirmpwd_error}    ${error_msg}

verify old password error message
    [Arguments]    ${error_msg}
    [Documentation]    在修改密码界面，验证输入异常原密码时提示信息
    ...    参数：旧密码错误提示信息
    Wait Until Element Is Visible    ${chgpwd_oldpwd_error}    error=旧密码错误时没有提示信息
    Element Text Should Be    ${chgpwd_oldpwd_error}    ${error_msg}    message=原密码错误提示信息异常

verify change password UI info
    [Arguments]    ${vcUserName}
    [Documentation]    修改密码界面信息验证
    ...    参数：vTopCenter登录用户名
    verify same element text by UI    ${layui_label_ID}    @{chgpwdUI['labelL']}
    verify element text    ${chgpwd_name_input}    ${vcUserName}
    verify lay UI title info    ${chgpwdUI['title1']}
