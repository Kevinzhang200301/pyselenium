*** Settings ***
Force Tags    userManageCase
Suite Setup       prepare env for edit user
Suite Teardown    clear env for edit user
Resource          ../../Keyword/UserManage/UserKeywords.robot

*** Test Cases ***
编辑用户界面信息验证
    [Tags]    userInfoCase
    into user management UI
    click edit user button    ${userTD['editD']}
    verify edit user UI info    ${userTD['editD']}    ${userTD['emailR']}

用户详细信息验证
    [Tags]    userInfoCase
    into user management UI
    click username on user manage UI    ${userTD['editD']}
    verify user detail UI info    ${userTD['editD']}

编辑用户_输入正确真实姓名
    [Tags]    editUserCase    smokeCase
    into user management UI
    click edit user button    ${userTD['nameD']}
    input user realname    ${userTD['realR']}
    click save button    True
    verify lobibox info
    verify user realname info on the UI    ${userTD['nameD']}    ${userTD['realR']}

编辑用户_真实姓名没有任何值
    [Tags]    editUserCase
    into user management UI
    click edit user button    ${userTD['nameD']}
    input user realname    ${EMPTY}
    click save button
    verify user realname error msg    ${userUI['err5']}

编辑用户_输入的真实姓名全为空格
    [Tags]    editUserCase
    into user management UI
    click edit user button    ${userTD['nameD']}
    input user realname    ${SPACE*8}
    click save button
    verify user realname error msg    ${userUI['err5']}

编辑用户_密码没有值
    [Tags]    editUserCase
    into user management UI
    click edit user button    ${userTD['nameD']}
    input user password    ${EMPTY}
    click save button
    verify user password error msg    ${userUI['err6']}

编辑用户_输入的密码包含空格
    [Tags]    editUserCase
    into user management UI
    click edit user button    ${userTD['nameD']}
    input user password    3${SPACE*8}3
    click save button
    verify user password error msg    ${userUI['err7']}

编辑用户_输入的密码小于6位数
    [Tags]    editUserCase
    into user management UI
    click edit user button    ${userTD['nameD']}
    input user password    ${userTD['pwdE1']}
    click save button
    verify user password error msg    ${userUI['err8']}

编辑用户_输入超过6位错误密码
    [Tags]    editUserCase
    into user management UI
    click edit user button    ${userTD['nameD']}
    : FOR    ${PWD}    IN    @{userTD['nameE1']}
    \    input user password    ${PWD*8}
    \    click save button
    \    Run Keyword And Continue On Failure    verify user password error msg    ${userUI['err7']}

编辑用户_输入正确的密码
    [Tags]    editUserCase    smokeCase
    : FOR    ${password}    IN    @{userTD['pwdR']}
    \    into user management UI
    \    click edit user button    ${userTD['nameD']}
    \    ${pwdlen}    Get Length    ${password}
    \    ${pwd}    Set Variable If    ${pwdlen}<6    ${password*6}    ${pwdlen}>=6    ${password}
    \    input user password    ${pwd}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify user password in database    ${userTD['nameD']}    ${pwd}

编辑用户_输入错误格式的电子邮箱
    [Tags]    editUserCase
    into user management UI
    click edit user button    ${userTD['nameD']}
    : FOR    ${email}    IN    @{userTD['emailE']}
    \    input user email    ${email}
    \    click save button
    \    verify user email error msg    ${userUI['err12']}

编辑用户_输入正确电子邮件
    [Tags]    editUserCase    smokeCase
    into user management UI
    click edit user button    ${userTD['nameD']}
    input user email    ${userTD['emailR']}
    click save button    True
    verify lobibox info
    verify user email in database    ${userTD['nameD']}    ${userTD['emailR']}

编辑用户_输入正确的有效时间
    [Tags]    editUserCase    smokeCase
    into user management UI
    click edit user button    ${userTD['nameD']}
    input user expired_date    ${userTD['dateR']}
    click save button    True
    verify lobibox info
    verify user expired_date in database    ${userTD['nameD']}    ${userTD['dateR']} 00:00:00

编辑用户_输入错误格式有效时间
    [Tags]    editUserCase
    : FOR    ${date}    IN    @{userTD['dateE']}
    \    into user management UI
    \    click edit user button    ${userTD['nameD']}
    \    input user expired_date    ${date}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    ${y}    ${m}    ${d}    Get Time    year,month,day
    \    Run Keyword And Continue On Failure    verify user expired_date in database    ${userTD['nameD']}    ${y}-${m}-${d} 00:00:00

编辑用户_停用用户
    [Tags]    editUserCase    smokeCase
    into user management UI
    click edit user button    ${userTD['srcName'][0]}
    select user open or stop    ${userUI['userStatus'][1]}
    click save button    True
    verify lobibox info
    verify user status on the UI    ${userTD['srcName'][0]}    ${userUI['userStatus'][1]}   

编辑用户_开通用户
    [Tags]    editUserCase    smokeCase
    into user management UI
    click edit user button    ${userTD['editD']}
    select user open or stop    ${userUI['userStatus'][0]}
    click save button    True
    verify lobibox info
    verify user status on the UI    ${userTD['editD']}    ${userUI['userStatus'][0]}

编辑用户_已过期
    [Tags]    editUserCase
    into user management UI
    click edit user button    ${userTD['srcName'][1]}
    ${y}    ${m}    ${d}    Get Time    year,month,day    NOW - 1 day
    input user expired_date    ${y}-${m}-${d}
    click save button    True
    verify lobibox info
    verify user status on the UI    ${userTD['srcName'][1]}

搜索用户_不存在的用户
    [Tags]    searchUserCase
    into user management UI
    : FOR    ${user}    IN    @{userTD['srcNoName']}
    \    open the search UI
    \    input search user name    ${user}
    \    click search button
    \    Run Keyword And Continue On Failure    verify table records current page    0

搜索用户_已存在的完整用户名
    [Tags]    searchUserCase
    into user management UI
    open the search UI
    input search user name    ${userTD['srcName'][1]}
    click search button
    verify table records current page    1

搜索用户_已存在用户的部分字段
    [Tags]    searchUserCase
    into user management UI
    ${len}    Get Length    ${userTD['srcName']}
    open the search UI
    input search user name    ${userTD['srcName'][0]}
    click search button
    verify table records current page    ${len}

删除用户_弹窗界面信息验证
    [Tags]    userInfoCase
    into user management UI
    click delete user button    ${userTD['nameD']}
    verify confirm box info    ${userBox['msg3']}

删除用户_取消
    [Tags]    deleteUserCase
    into user management UI
    click delete user button    ${userTD['nameD']}
    click confirm box cancel button
    verify confirm not exist

删除用户_确定
    [Tags]    deleteUserCase
    into user management UI
    click delete user button    ${userTD['del']}
    click confirm box confirm button
    verify confirm not exist
    ${status}    Run Keyword And Return Status
    ...    verify user username on the UI    ${userTD['del']}
    Should Be Equal As Strings    ${status}    False    msg=用户没有删除成功

查看虚拟机_界面信息验证
    [Tags]    seeVmCase    userInfoCase
    into user management UI
    click see VM on user manage UI    ${userTD['nameD']}
    verify see VM UI info    ${userTD['nameD']}

查看虚拟机_未选择虚拟机点击删除
    [Tags]    seeVmCase
    into user management UI
    click see VM on user manage UI    ${userTD['nameD']}
    click delete button on the see VM UI
    verify lobibox info    ${userBox['msg4']}

查看虚拟机_未选择虚拟机点击还原
    [Tags]    seeVmCase
    into user management UI
    click see VM on user manage UI    ${userTD['nameD']}
    click rollback button on the see VM UI
    verify lobibox info    ${userBox['msg4']}

查看虚拟机_未选择虚拟机点击开机
    [Tags]    seeVmCase
    into user management UI
    click see VM on user manage UI    ${userTD['nameD']}
    click start button on the see VM UI
    verify lobibox info    ${userBox['msg4']}

查看虚拟机_未选择虚拟机点击关机
    [Tags]    seeVmCase
    into user management UI
    click see VM on user manage UI    ${userTD['nameD']}
    click shutdown button on the see VM UI
    verify lobibox info    ${userBox['msg4']}

查看虚拟机_未选择虚拟机点击重启
    [Tags]    seeVmCase
    into user management UI
    click see VM on user manage UI    ${userTD['nameD']}
    click restart button on the see VM UI
    verify lobibox info    ${userBox['msg4']}

查看虚拟机_未选择虚拟机点击更新
    [Tags]    seeVmCase
    into user management UI
    click see VM on user manage UI    ${userTD['nameD']}
    click update button on the see VM UI
    verify lobibox info    ${userBox['msg4']}

查看虚拟机_虚拟机名称排序
    [Tags]    seeVmCase
    into user management UI
    click see VM on user manage UI    ${userTD['nameD']}
    Click Element    ${tuser_seevm_table_vmName}
    Wait Until Element Is Visible    ${tuser_seevm_table_vmName}    error=点击虚拟机名称排序后该按钮不可见

查看虚拟机_镜像名称排序
    [Tags]    seeVmCase
    into user management UI
    click see VM on user manage UI    ${userTD['nameD']}
    Click Element    ${tuser_seevm_table_tempName}
    Wait Until Element Is Visible    ${tuser_seevm_table_tempName}    error=点击镜像名称排序后该按钮不可见

查看虚拟机_所属vTop排序
    [Tags]    seeVmCase
    into user management UI
    click see VM on user manage UI    ${userTD['nameD']}
    Click Element    ${tuser_seevm_table_vtop}
    Wait Until Element Is Visible    ${tuser_seevm_table_vtop}    error=点击所属vTop排序后该按钮不可见

查看虚拟机_所属用户排序
    [Tags]    seeVmCase
    into user management UI
    click see VM on user manage UI    ${userTD['nameD']}
    Click Element    ${tuser_seevm_table_user}
    Wait Until Element Is Visible    ${tuser_seevm_table_user}    error=点击所属用户排序后该按钮不可见

查看虚拟机_虚拟机状态排序
    [Tags]    seeVmCase
    into user management UI
    click see VM on user manage UI    ${userTD['nameD']}
    Click Element    ${tuser_seevm_table_status}
    Wait Until Element Is Visible    ${tuser_seevm_table_status}    error=点击虚拟机状态排序后该按钮不可见
