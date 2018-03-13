*** Settings ***
Suite Setup       login by admin
Suite Teardown    close browser and kill chrome process
Force Tags    userManageCase
Resource          ../../Keyword/UserManage/UserKeywords.robot
Resource          ../../Keyword/AdministratorKeywords.robot

*** Test Cases ***
用户管理界面信息验证
    [Tags]    userInfoCase
    [Setup]    create right user by UI    ${userTD['nameD']}
    into user management UI
    verify user manage UI table info
    verify user manage UI other info
    [Teardown]    delete all user by UI

用户快捷键打开用户管理界面
    refresh page
    Click Element    //button[contains(@onclick,'quickClick1')]
    Wait Until Element Is Visible    ${tuser_UI_ID}    error=用户界面不可见
    Select Frame    ${tuser_iframetab_ID}
    Select Frame    ${tuser_iframmgr_ID}
    Wait Until Element Is Visible    ${tuser_addbth_ID}    error=添加用户按钮不可见
    
新建用户界面验证
    [Tags]    userInfoCase
    into user management UI
    click create user button
    verify create user UI info

新建用户_不输入用户名
    [Tags]    createUserCase
    into user management UI
    click create user button
    input user username    ${EMPTY}
    input user realname    ${userTD['realD']}
    click save button
    verify user username error msg    ${userUI['err1']}

新建用户_用户名包含空格
    [Tags]    createUserCase
    into user management UI
    click create user button
    input user username    ${SPACE*8}
    input user realname    ${userTD['realD']}
    click save button
    verify user username error msg    ${userUI['err2']}

新建用户_输入错误的用户名
    [Tags]    createUserCase
    into user management UI
    click create user button
    input user realname    ${userTD['realD']}
    : FOR    ${user}    IN    @{userTD['nameE1']}
    \    input user username    ${user}
    \    click save button
    \    Run Keyword And Continue On Failure    verify user username error msg    ${userUI['err2']}

新建用户_用户名为系统保留用户
    [Tags]    createUserCase
    into user management UI
    click create user button
    input user realname    ${userTD['realD']}
    : FOR    ${user}    IN    @{userTD['nameE2']}
    \    input user username    ${user}
    \    click save button
    \    Run Keyword And Continue On Failure    verify user username error msg    ${userUI['err3']}

新建用户_ 帐号已经被vtrans使用
    [Tags]    createUserCase
    into user management UI
    click create user button
    input user realname    ${userTD['realD']}
    input user username    ${userTD['nameE3']}
    click save button
    verify user username error msg    ${userUI['err9']}

新建用户_输入正确的用户名
    [Tags]    createUserCase    smokeCase
    : FOR    ${user}    IN    @{userTD['nameR']}
    \    into user management UI
    \    click create user button
    \    input user username    ${user}
    \    input user realname    ${userTD['realD']}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify user username on the UI    ${user}
    [Teardown]    delete all user by UI

新建用户_不输入真实姓名
    [Tags]    createUserCase
    into user management UI
    click create user button
    input user username    ${userTD['nameD']}
    input user realname    ${EMPTY}
    click save button
    verify user realname error msg    ${userUI['err5']}

新建用户_输入的真实姓名全是空格
    [Tags]    createUserCase
    into user management UI
    click create user button
    input user username    ${userTD['nameD']}
    input user realname    ${SPACE*8}
    click save button
    verify user realname error msg    ${userUI['err5']}

新建用户_输入正确的真实姓名
    [Tags]    createUserCase    smokeCase
    into user management UI
    click create user button
    input user username    ${userTD['nameD']}
    input user realname    ${userTD['realR']}
    click save button    True
    verify lobibox info
    verify user realname info on the UI    ${userTD['nameD']}    ${userTD['realR']}
    [Teardown]    delete all user by UI

新建用户_不输入密码
    [Tags]    createUserCase
    into user management UI
    click create user button
    input user username    ${userTD['nameD']}
    input user realname    ${userTD['realD']}
    input user password    ${EMPTY}
    click save button
    verify user password error msg    ${userUI['err6']}

新建用户_输入的密码包含空格
    [Tags]    createUserCase
    into user management UI
    click create user button
    input user username    ${userTD['nameD']}
    input user realname    ${userTD['nameD']}
    input user password    3${SPACE*8}3
    click save button
    verify user password error msg    ${userUI['err7']}

新建用户_输入的密码小于6位数
    [Tags]    createUserCase
    into user management UI
    click create user button
    input user username    ${userTD['nameD']}
    input user realname    ${userTD['realD']}
    input user password    ${userTD['pwdE1']}
    click save button
    verify user password error msg    ${userUI['err8']}

新建用户_输入超过6位错误密码
    [Tags]    createUserCase
    into user management UI
    click create user button
    input user username    ${userTD['nameD']}
    input user realname    ${userTD['realD']}
    : FOR    ${PWD}    IN    @{userTD['nameE1']}
    \    input user password    ${PWD*8}
    \    click save button
    \    Run Keyword And Continue On Failure    verify user password error msg    ${userUI['err7']}

新建用户_输入正确的密码
    [Tags]    createUserCase    smokeCase
    ${len}    Get Length    ${userTD['pwdR']}
    : FOR    ${i}    IN RANGE    ${len}
    \    into user management UI
    \    click create user button
    \    input user username    ${i}
    \    input user realname    ${userTD['realD']}
    \    ${pwdlen}    Get Length    ${userTD['pwdR'][${i}]}
    \    ${pwd}    Set Variable If    ${pwdlen}<6    ${userTD['pwdR'][${i}]*6}    ${pwdlen}>=6    ${userTD['pwdR'][${i}]}
    \    input user password    ${pwd}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify user password in database    ${i}    ${pwd}
    [Teardown]    delete all user by UI

新建用户_输入错误格式的电子邮箱
    [Tags]    createUserCase
    into user management UI
    click create user button
    input user username    ${userTD['nameD']}
    input user realname    ${userTD['realD']}
    : FOR    ${email}    IN    @{userTD['emailE']}
    \    input user email    ${email}
    \    click save button
    \    verify user email error msg    ${userUI['err12']}

新建用户_输入正确电子邮箱
    [Tags]    createUserCase    smokeCase
    into user management UI
    click create user button
    input user username    ${userTD['nameD']}
    input user realname    ${userTD['realD']}
    input user email    ${userTD['emailR']}
    click save button    True
    verify lobibox info
    verify user email in database    ${userTD['nameD']}    ${userTD['emailR']}
    [Teardown]    delete all user by UI

新建用户_是否为发布者
    [Tags]    createUserCase    smokeCase
    ${len}    Get Length    ${userUI['pub']}
    : FOR    ${i}    IN RANGE    ${len}
    \    into user management UI
    \    click create user button
    \    input user username    ${i}
    \    input user realname    ${userTD['realD']}
    \    select user publisher or not    ${userUI['pub'][${i}]}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify user publisher info on the UI    ${i}    ${userUI['pub'][${i}]}
    [Teardown]    delete all user by UI

新建用户_输入正确的有效期时间
    [Tags]    createUserCase    smokeCase
    into user management UI
    click create user button
    input user username    ${userTD['nameD']}
    input user realname    ${userTD['realD']}
    input user expired_date    ${userTD['dateR']}
    click save button    True
    verify lobibox info
    verify user expired_date in database    ${userTD['nameD']}    ${userTD['dateR']} 00:00:00
    [Teardown]    delete all user by UI

新建用户_输入错误格式有效期时间
    [Tags]    createUserCase
    ${len}    Get Length    ${userTD['dateE']}
    : FOR    ${i}    IN RANGE    ${len}
    \    into user management UI
    \    click create user button
    \    input user username    ${i}
    \    input user realname    ${userTD['realD']}
    \    input user expired_date    ${userTD['dateE'][${i}]}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    ${y}    ${m}    ${d}    Get Time    year,month,day
    \    Run Keyword And Continue On Failure    verify user expired_date in database    ${i}    ${y}-${m}-${d} 00:00:00
    [Teardown]    delete all user by UI

新建用户_是否开通
    [Tags]    createUserCase    smokeCase
    ${len}    Get Length    ${userUI['userStatus']}
    : FOR    ${i}    IN RANGE    ${len}
    \    into user management UI
    \    click create user button
    \    input user username    ${i}
    \    input user realname    ${userTD['realD']}
    \    select user open or stop    ${userUI['userStatus'][${i}]}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify user status on the UI    ${i}    ${userUI['userStatus'][${i}]}
    [Teardown]    delete all user by UI

新建用户_用户已存在
    [Tags]    createUserCase
    [Setup]    create right user by UI    ${userTD['nameD']}
    into user management UI
    click create user button
    input user username    ${userTD['nameD']}
    input user realname    ${userTD['realD']}
    click save button
    verify user username error msg    ${userUI['err10']}
    [Teardown]    delete all user by UI

新建用户_与管理员账户相同
    [Tags]    createUserCase
    [Setup]    create admin user by UI    ${userTD['nameD']}
    into user management UI
    click create user button
    input user username    ${userTD['nameD']}
    input user realname    ${userTD['realD']}
    click save button
    verify user username error msg    ${userUI['err11']}
    [Teardown]    delete all admin by UI

新建用户_用户名忽略大小写
    [Tags]    createUserCase
    [Setup]    create right user by UI    ${userTD['nameD']}
    into user management UI
    click create user button
    input user username    ${IgnoreCase}
    input user realname    ${userTD['realD']}
    click save button
    verify user username error msg    ${userUI['err10']}
    [Teardown]    delete all user by UI

新建用户_选择用户组(非默认值)
    [Tags]    createUserCase    smokeCase
    [Setup]    create right usergroup by UI    ${userTD['groupD']}
    into user management UI
    select usergroup on the user manage UI    ${userTD['groupD']}
    click create user button
    input user username    ${userTD['nameD']}
    input user realname    ${userTD['realD']}
    click save button    True
    verify lobibox info
    verify user usergroup on the UI    ${userTD['nameD']}    ${userTD['groupD']}
    [Teardown]    Run Keywords    delete all user by UI    delete all usergroup by UI

新建用户_取消
    [Tags]    createUserCase
    into user management UI
    click create user button
    click cancle button
    Wait Until Element Is Not Visible    ${layui_title_ID}

新建用户_右上角“x”
    [Tags]    createUserCase
    into user management UI
    click create user button
    click "x" button
    Wait Until Element Is Not Visible    ${layui_title_ID}