*** Settings ***
Suite Setup       prepare env for basic operation
Suite Teardown    clear env for basic operation
Force Tags    userManageCase
Resource          ../../Keyword/UserManage/BasicOperationKeywords.robot

*** Test Cases ***
重置密码_未勾选用户
    [Tags]    userBasicCase
    into user management UI
    click reset passwrod button
    verify lobibox info    ${userBox['msg13']}

重置密码_界面信息验证
    [Tags]    userBasicCase    userInfoCase
    into user management UI
    select user on the user manage UI    ${userTD['srcName'][0]}
    click reset passwrod button
    verify confirm box info    ${userBox['msg17']}

重置密码_取消
    [Tags]    userBasicCase
    into user management UI
    select user on the user manage UI    ${userTD['srcName'][0]}
    click reset passwrod button
    click confirm box cancel button
    verify confirm not exist

重置密码_勾选一个用户
    [Tags]    userBasicCase
    into user management UI
    select user on the user manage UI    ${userTD['srcName'][0]}
    click reset passwrod button
    click confirm box confirm button
    verify lobibox info    ${userBox['msg14']}
    verify user password in database    ${userTD['srcName'][0]}    ${userUI['PwdD']}

重置密码_勾选多个用户
    [Tags]    userBasicCase
    into user management UI
    select table checkbox on UI
    click reset passwrod button
    click confirm box confirm button
    verify lobibox info    ${userBox['msg14']}
    : FOR    ${user}    IN    @{userTD['srcName']}    ${userTD['nameD']}
    \    verify user password in database    ${user}    ${userUI['PwdD']}

开通用户_未勾选用户
    [Tags]    userBasicCase
    into user management UI
    click open user button
    verify lobibox info    ${userBox['msg13']}

开通用户_弹窗信息验证
    [Tags]    userBasicCase    userInfoCase
    into user management UI
    select user on the user manage UI    ${userTD['srcName'][0]}
    click open user button
    verify confirm box info    ${userBox['msg18']}

开通用户_取消
    [Tags]    userBasicCase
    into user management UI
    select user on the user manage UI    ${userTD['srcName'][0]}
    click open user button
    click confirm box cancel button
    verify confirm not exist

停用用户_勾选一个已停用的用户
    [Tags]    userBasicCase
    into user management UI
    select user on the user manage UI    ${userTD['nameD']}
    click stop user button
    click confirm box confirm button
    verify lobibox info    ${userBox['msg16']}
    verify user status on the UI    ${userTD['nameD']}    ${userUI['userStatus'][1]}

开通用户_勾选一个开通的用户
    [Tags]    userBasicCase
    into user management UI
    select user on the user manage UI    ${userTD['srcName'][0]}
    click open user button
    click confirm box confirm button
    verify lobibox info    ${userBox['msg15']}
    verify user status on the UI    ${userTD['srcName'][0]}    ${userUI['userStatus'][0]}

开通用户_勾选一个停用用户
    [Tags]    userBasicCase
    into user management UI
    select user on the user manage UI    ${userTD['nameD']}
    click open user button
    click confirm box confirm button
    verify lobibox info    ${userBox['msg15']}
    verify user status on the UI    ${userTD['nameD']}    ${userUI['userStatus'][0]}

开通用户_勾选多个用户
    [Tags]    userBasicCase
    [Setup]    Run Keywords    into user management UI    select table checkbox on UI    click stop user button    click confirm box confirm button
    into user management UI
    select table checkbox on UI
    click open user button
    click confirm box confirm button
    verify lobibox info    ${userBox['msg15']}
    : FOR    ${username}    IN    @{userTD['srcName']}    ${userTD['nameD']}
    \    verify user status on the UI    ${username}    ${userUI['userStatus'][0]}

停用用户_未勾选用户
    [Tags]    userBasicCase
    into user management UI
    click stop user button
    verify lobibox info    ${userBox['msg13']}

停用用户_界面信息验证
    [Tags]    userBasicCase    userInfoCase
    into user management UI
    select user on the user manage UI    ${userTD['srcName'][1]}
    click stop user button
    verify confirm box info    ${userBox['msg19']}

停用用户_取消
    [Tags]    userBasicCase
    into user management UI
    select user on the user manage UI    ${userTD['srcName'][1]}
    click stop user button
    click confirm box cancel button
    verify confirm not exist

停用用户_勾选一个已开通用户
    [Tags]    userBasicCase
    into user management UI
    select user on the user manage UI    ${userTD['srcName'][1]}
    click stop user button
    click confirm box confirm button
    verify lobibox info    ${userBox['msg16']}
    verify user status on the UI    ${userTD['srcName'][1]}    ${userUI['userStatus'][1]}

停用用户_勾选多个用户
    [Tags]    userBasicCase
    [Setup]    Run Keywords    into user management UI    select table checkbox on UI    click open user button    click confirm box confirm button
    into user management UI
    select table checkbox on UI
    click stop user button
    click confirm box confirm button
    verify lobibox info    ${userBox['msg16']}
    : FOR    ${username}    IN    @{userTD['srcName']}    ${userTD['nameD']}
    \    verify user status on the UI    ${username}    ${userUI['userStatus'][1]}

配置用户策略_未勾选任何用户
    [Tags]    userBasicCase
    into user management UI
    click userpolicy button    False
    verify lobibox info    ${userBox['msg12']}

配置用户策略_界面信息验证(一个用户)
    [Tags]    userBasicCase    userInfoCase
    into user management UI
    select user on the user manage UI    ${userTD['srcName'][1]}
    click userpolicy button
    verify config userpolicy UI info    userName=${userTD['srcName'][1]}

配置用户策略_界面信息验证(多个用户)
    [Tags]    userBasicCase    userInfoCase
    into user management UI
    ${len}    get current table record number
    select table checkbox on UI
    click userpolicy button
    verify config userpolicy UI info    ${len}

配置用户策略_勾选一个普通用户
    [Tags]    userBasicCase
    into user management UI
    select user on the user manage UI    ${userTD['srcName'][1]}
    click userpolicy button
    select userpolicy on config userpolicy UI    ${userTD['policyD']}
    click confirm button on confige userpolicy UI
    verify lobibox info
    ${title}    get userPolicy title from rules    @{policyUI['ruleL'][:1]}
    verify user userPolicy info on the UI    ${userTD['srcName'][1]}    ${userTD['policyD']}    ${title}

配置用户策略_勾选多个普通用户
    [Tags]    userBasicCase
    into user management UI
    select table checkbox on UI
    click userpolicy button
    select userpolicy on config userpolicy UI    ${userTD['policyD']}
    click confirm button on confige userpolicy UI
    verify lobibox info
    ${title}    get userPolicy title from rules    @{policyUI['ruleL'][:1]}
    : FOR    ${user}    IN    @{userTD['srcName']}    ${userTD['nameD']}
    \    verify user userPolicy info on the UI    ${user}    ${userTD['policyD']}    ${title}

配置用户策略_发布者
    [Tags]    userBasicCase
    [Setup]    create right user by UI    ${userTD['pubName']}    pub=True
    into user management UI
    select user on the user manage UI    ${userTD['pubName']}
    click userpolicy button    False
    verify confirm box info    ${userBox['msg20']}    confirm=None    cancel=${userUI['button11']}
    click confirm box cancel button
    verify confirm not exist

配置用户策略_取消按钮
    [Tags]    userBasicCase
    into user management UI
    select user on the user manage UI    ${userTD['srcName'][0]}
    click userpolicy button
    click cancel button on confige userPolicy UI
    Wait Until Element Is Not Visible    ${layui_title_ID}

配置用户策略_取消“x”
    [Tags]    userBasicCase
    into user management UI
    select user on the user manage UI    ${userTD['srcName'][0]}
    click userpolicy button
    click "x" button
    Wait Until Element Is Not Visible    ${layui_title_ID}

更换用户组_未勾选任何用户
    [Tags]    userBasicCase
    into user management UI
    click change usergroup button    False
    verify lobibox info    ${userBox['msg13']}

更换用户组界面信息验证
    [Tags]    userBasicCase    userInfoCase
    into user management UI
    select user on the user manage UI    ${userTD['srcName'][0]}
    click change usergroup button
    verify change usergroup UI info

更换用户组_用户组为空点击保存
    [Tags]    userBasicCase
    into user management UI
    select user on the user manage UI    ${userTD['srcName'][0]}
    click change usergroup button
    click save button
    verify userGroup error info on change userGroup UI    ${userUI['err15']}

更换用户组_取消按钮
    [Tags]    userBasicCase
    into user management UI
    select user on the user manage UI    ${userTD['srcName'][0]}
    click change usergroup button
    click cancle button
    Wait Until Element Is Not Visible    ${layui_title_ID}

更换用户组_取消“x”
    [Tags]    userBasicCase
    into user management UI
    select user on the user manage UI    ${userTD['srcName'][0]}
    click change usergroup button
    click "x" button
    Wait Until Element Is Not Visible    ${layui_title_ID}

更换用户组_清空
    [Tags]    userBasicCase
    into user management UI
    select user on the user manage UI    ${userTD['srcName'][0]}
    click change usergroup button
    select usergroup on layer UI    ${userTD['groupD']}
    click change usergroup clear button
    click save button
    verify userGroup error info on change userGroup UI    ${userUI['err15']}

更换用户组_勾选一个用户
    [Tags]    userBasicCase
    into user management UI
    select user on the user manage UI    ${userTD['srcName'][0]}
    click change usergroup button
    select usergroup on layer UI    ${userTD['groupD']}
    click save button    True
    verify lobibox info
    verify user usergroup on the UI    ${userTD['srcName'][0]}    ${userTD['groupD']}

更换用户组_勾选多个用户
    [Tags]    userBasicCase
    into user management UI
    select table checkbox on UI
    click change usergroup button
    select usergroup on layer UI    ${userTD['groupD']}
    click save button    True
    verify lobibox info
    Select Frame    ${tuser_iframetab_ID}
    Select Frame    ${tuser_iframmgr_ID}
    ${len}    get current table record number
    : FOR    ${i}    IN RANGE    ${len}
    \    Table Cell Should Contain    ${public_table_ID}    ${i+2}    4    ${userTD['groupD']}

导入用户_正确格式
    [Tags]    userBasicCase
    [Setup]    Run Keywords    delete all user by UI    delete all usergroup by UI
    into user management UI
    click import user button
    Choose File    ${tuser_import_upload_ID}    ${userTD['importR']}
    click save button    True
    verify lobibox info    msgStatus=False
    into user management UI
    ${len1}    get current table record number
    Should Be Equal As Integers    2    ${len1}    msg=导入用户的用户数量不正确，实际数量为${len1}
    into usergroup management UI
    ${len2}    get current table record number
    Should Be Equal As Integers    2    ${len1}    msg=导入用户的用户组数量不正确，实际数量为${len2}

导入用户_错误格式
    [Tags]    userBasicCase
    into user management UI
    click import user button
    : FOR    ${file}    IN    @{userTD['importE']}
    \    Choose File    ${tuser_import_upload_ID}    ${file}
    \    click save button
    \    Run Keyword And Continue On Failure    verify import user error msg    ${userUI['err13']}

导入用户_不选择文件
    [Tags]    userBasicCase
    into user management UI
    click import user button
    click save button
    verify import user error msg    ${userUI['err14']}

导入用户_界面信息验证
    [Tags]    userBasicCase    userInfoCase
    into user management UI
    click import user button
    verify import user UI info
