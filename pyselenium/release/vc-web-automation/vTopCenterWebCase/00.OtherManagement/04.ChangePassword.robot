*** Settings ***
Suite Setup       login by admin
Suite Teardown    Run Keywords    close browser and kill chrome process    reset vTopCenter login password
Resource          ../../Keyword/ChangePasswordKeywords.robot

*** Test Cases ***
修改密码页面信息验证
    click change password button
    verify change password UI info    ${vc_web_user}

取消修改密码界面
    click change password button
    click cancle button
    verify lay UI not exit

修改密码_旧密码不输入
    click change password button
    input old password    ${EMPTY}
    click save button
    verify old password error message    ${chgpwdUI['err3']}

修改密码_旧密码全为空格
    click change password button
    input old password    ${SPACE*8}
    click save button
    verify old password error message    ${chgpwdUI['err3']}

修改密码_旧密码错误
    click change password button
    input old password    ${vc_web_pwd}11
    click save button
    verify old password error message    ${chgpwdUI['err2']}

修改密码_新密码不输入
    click change password button
    input old password    ${vc_web_pwd}
    input new password    ${EMPTY}
    click save button
    verify new password error message    ${chgpwdUI['err4']}

修改密码_新密全为空格
    click change password button
    input old password    ${vc_web_pwd}
    input new password    ${SPACE*8}
    click save button
    verify new password error message    ${chgpwdUI['err4']}

修改密码_确认密码不输入
    click change password button
    input old password    ${vc_web_pwd}
    input new password    ${chgpwdTD['pwdD']}
    input confirm password    ${EMPTY}
    click save button
    verify confirm password error message    ${chgpwdUI['err5']}

修改密码_确认密码全为空格
    click change password button
    input old password    ${vc_web_pwd}
    input new password    ${chgpwdTD['pwdD']}
    input confirm password    ${SPACE*8}
    click save button
    verify confirm password error message    ${chgpwdUI['err5']}

修改密码_新密码少于6位
    click change password button
    input old password    ${vc_web_pwd}
    input new password    ${chgpwdTD['pwdE1']}
    click save button
    verify new password error message    ${chgpwdUI['err1']}

修改密码_确认密码少于6位
    click change password button
    input old password    ${vc_web_pwd}
    input new password    ${chgpwdTD['pwdD']}
    input confirm password    ${chgpwdTD['pwdE1']}
    click save button
    verify confirm password error message    ${chgpwdUI['err1']}

修改密码_新密码和确认密码不相同
    click change password button
    input old password    ${vc_web_pwd}
    input new password    ${chgpwdTD['pwdD']}
    input confirm password    ${chgpwdTD['pwdD']}11
    click save button
    verify new password error message    ${chgpwdUI['err6']}

修改密码_正确
    [Documentation]    修改正确的vTopCenter用户密码
    ${oldPwd}    Set Variable    ${vc_web_pwd}
    : FOR    ${pwd}    IN    @{chgpwdTD['pwdR']}
    \    click change password button
    \    input old password    ${oldPwd}
    \    input new password    ${pwd}
    \    input confirm password    ${pwd}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify element text    ${login_errMSG_ID}    ${chgpwdUI['msg1']}
    \    login by new tab    ${vc_web_user}    ${pwd}
    \    ${oldPwd}    Set Variable    ${pwd}
    [Teardown]    reset vTopCenter login password
