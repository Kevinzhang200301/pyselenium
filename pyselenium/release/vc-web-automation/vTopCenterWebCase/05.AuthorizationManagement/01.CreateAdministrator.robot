*** Settings ***
Suite Setup       login by admin
Suite Teardown    close browser and kill chrome process
Force Tags    adminManageCase
Resource          ../../Keyword/AdministratorKeywords.robot
Resource          ../../Keyword/UserManage/UserKeywords.robot

*** Test Cases ***
管理员管理界面信息验证
    [Tags]    adminInfoCase
    [Setup]    create admin user by UI    ${deleteNameTD}    status=stop
    into admin manage UI
    verify admin manage UI info
    [Teardown]    delete all admin by UI

新建管理员_界面信息验证
    [Tags]    adminInfoCase
    into admin manage UI
    click create admin button
    verify create admin UI info

新建管理员_账户不输入任何值
    [Tags]    createAdminCase
    into admin manage UI
    click create admin button
    input admin name    ${EMPTY}
    click save button
    verify admin name error msg    ${adminUI['err5']}

新建管理员_账户包含空格
    [Tags]    createAdminCase
    into admin manage UI
    click create admin button
    input admin name    1${SPACE*8}1
    click save button
    verify admin name error msg    ${adminUI['err1']}

新建管理员_账户名包含特殊符号
    [Tags]    createAdminCase
    into admin manage UI
    click create admin button
    : FOR    ${name}    IN    @{adminTD['nameE1']}
    \    input admin name    ${name}
    \    click save button
    \    Run Keyword And Continue On Failure    verify admin name error msg    ${adminUI['err1']}

新建管理员_账户名与vtop用户名相同
    [Tags]    createAdminCase
    [Setup]    create right user by UI    ${defaultNameTD}
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${adminTD['realD']}
    select admin role    ${adminUI['role'][0]}
    click save button
    verify admin name error msg    ${adminUI['err2']}
    [Teardown]    delete all user by UI

新建管理员_该账户已创建
    [Tags]    createAdminCase
    [Setup]    create admin user by UI    ${defaultNameTD}
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${adminTD['realD']}
    select admin role    ${adminUI['role'][0]}
    click save button
    verify admin name error msg    ${adminUI['err3']}
    [Teardown]    delete all admin by UI

新建管理员_名称忽略大小写
    [Tags]    createAdminCase
    [Setup]    create admin user by UI    ${defaultNameTD}
    into admin manage UI
    click create admin button
    ${upper}    Convert To Uppercase    ${defaultNameTD}
    input admin name    ${upper}
    input admin realname    ${adminTD['realD']}
    select admin role    ${adminUI['role'][0]}
    click save button
    verify admin name error msg    ${adminUI['err3']}
    [Teardown]    delete all admin by UI

新建管理员_系统关键字
    [Tags]    createAdminCase
    into admin manage UI
    click create admin button
    : FOR    ${name}    IN    @{adminTD['nameE2']}
    \    input admin name    ${name}
    \    input admin realname    ${adminTD['realD']}
    \    select admin role    ${adminUI['role'][0]}
    \    click save button
    \    Run Keyword And Continue On Failure    verify admin name error msg    ${adminUI['err4']}

新建管理员_系统保留账户
    [Tags]    createAdminCase
    into admin manage UI
    click create admin button
    : FOR    ${name}    IN    @{adminTD['nameE3']}
    \    input admin name    ${name}
    \    input admin realname    ${adminTD['realD']}
    \    select admin role    ${adminUI['role'][0]}
    \    click save button
    \    Run Keyword And Continue On Failure    verify admin name error msg    ${adminUI['err12']}

新建管理员_vtran使用
    [Tags]    createAdminCase
    into admin manage UI
    click create admin button
    input admin name    ${adminTD['nameE4']}
    input admin realname    ${adminTD['realD']}
    select admin role    ${adminUI['role'][0]}
    click save button
    verify admin name error msg    ${adminUI['err13']}

新建管理员_输入正确账户名
    [Tags]    createAdminCase    smokeCase
    : FOR    ${name}    IN    @{adminTD['nameR']}
    \    into admin manage UI
    \    click create admin button
    \    input admin name    ${name}
    \    input admin realname    ${adminTD['realD']}
    \    select admin role    ${adminUI['role'][0]}
    \    click save button    True
    \    verify lobibox info
    \    Run Keyword And Continue On Failure    verify admin name on admin manage UI    ${name}
    [Teardown]    delete all admin by UI

新建管理员_不输入真实姓名
    [Tags]    createAdminCase
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${EMPTY}
    click save button
    verify admin realname error msg    ${adminUI['err6']}

新建管理员_真实姓名全为空格
    [Tags]    createAdminCase
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${SPACE*8}
    click save button
    verify admin realname error msg    ${adminUI['err6']}

新建管理员_输入正确真实姓名
    [Tags]    createAdminCase    smokeCase
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${adminTD['realR']}
    select admin role    ${adminUI['role'][0]}
    click save button    True
    verify lobibox info
    verify admin realname on admin manage UI    ${defaultNameTD}    ${adminTD['realR']}
    [Teardown]    delete all admin by UI

新建管理员_开通
    [Tags]    createAdminCase    smokeCase
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${adminTD['realD']}
    select admin role    ${adminUI['role'][0]}
    click save button    True
    verify lobibox info
    verify admin status on admin manage UI    ${defaultNameTD}    ${adminUI['statusT'][0]}
    [Teardown]    delete all admin by UI

新建管理员_停用
    [Tags]    createAdminCase    smokeCase
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${adminTD['realD']}
    select admin status    ${adminUI['status'][1]}
    select admin role    ${adminUI['role'][0]}
    click save button    True
    verify lobibox info
    verify admin status on admin manage UI    ${defaultNameTD}    ${adminUI['statusT'][1]}
    [Teardown]    delete all admin by UI

新建管理员_不输入有效期
    [Tags]    createAdminCase
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${adminTD['realD']}
    select admin role    ${adminUI['role'][0]}
    click save button    True
    verify lobibox info
    verify admin expiry on admin manage UI    ${defaultNameTD}    ${adminUI['longTime']}
    [Teardown]    delete all admin by UI

新建管理员_输入错误格式有效期
    [Tags]    createAdminCase
    ${len}    Get Length    ${adminTD['expiryE']}
    : FOR    ${name}    IN RANGE    ${len}
    \    into admin manage UI
    \    click create admin button
    \    input admin name    ${name}
    \    input admin realname    ${adminTD['realD']}
    \    input admin expiry date    ${adminTD['expiryE'][${name}]}
    \    select admin role    ${adminUI['role'][0]}
    \    click save button    True
    \    verify lobibox info
    \    Run Keyword And Continue On Failure    verify admin expiry on admin manage UI    ${name}    ${adminTD['nowTime']}
    [Teardown]    delete all admin by UI

新建管理员_输入正确的有效期
    [Tags]    createAdminCase    smokeCase
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${adminTD['realD']}
    input admin expiry date    ${adminTD['expiryR']}
    select admin role    ${adminUI['role'][0]}
    click save button    True
    verify lobibox info
    into admin manage UI
    verify admin expiry on admin manage UI    ${defaultNameTD}    ${AdminTD['expiryR']}
    [Teardown]    delete all admin by UI

新建管理员_不选择角色权限
    [Tags]    createAdminCase
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${adminTD['realD']}
    click save button
    verify admin role error msg    ${adminUI['err7']}

新建管理员_系统管理员
    [Tags]    createAdminCase    smokeCase
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${adminTD['realD']}
    select admin role    ${adminUI['role'][0]}
    click save button    True
    verify lobibox info
    verify admin role on admin manage UI    ${defaultNameTD}    ${adminUI['role'][0]}
    [Teardown]    delete all admin by UI

新建管理员_普通管理员
    [Tags]    createAdminCase    smokeCase
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${adminTD['realD']}
    select admin role    ${adminUI['role'][1]}
    click save button    True
    verify lobibox info
    verify admin role on admin manage UI    ${defaultNameTD}    ${adminUI['role'][1]}
    verify general manager modules    ${defaultNameTD}    ${adminTD['realD']}
    [Teardown]    delete all admin by UI

新建管理员_不选择管理范围
    [Tags]    createAdminCase
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${adminTD['realD']}
    select admin role    ${adminUI['role'][0]}
    click save button    True
    verify lobibox info
    verify admin range on admin manage UI    ${defaultNameTD}    ${adminUI['init']}
    [Teardown]    delete all admin by UI

新建管理员_选择管理范围
    [Tags]    createAdminCase    smokeCase
    [Setup]    create right location by UI    ${defaultNameTD}
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${adminTD['realD']}
    select admin role    ${adminUI['role'][0]}
    select location on layer UI    ${defaultNameTD}
    click save button    True
    verify lobibox info
    verify admin range on admin manage UI    ${defaultNameTD}    ${defaultNameTD}
    [Teardown]    Run Keywords    delete all admin by UI    delete all location by UI

新建管理员_手机格式不对
    [Tags]    createAdminCase
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${adminTD['realD']}
    select admin role    ${adminUI['role'][0]}
    input admin cellphone    ${adminTD['cellphoneE1']}
    click save button
    verify admin cellphone error msg    ${adminUI['err8']}

新建管理员_手机号码不是数字
    [Tags]    createAdminCase
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${adminTD['realD']}
    select admin role    ${adminUI['role'][0]}
    input admin cellphone    ${adminTD['cellphoneE2']}
    click save button
    verify admin cellphone error msg    ${adminUI['err9']}

新建管理员_手机号码正确
    [Tags]    createAdminCase
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${adminTD['realD']}
    select admin role    ${adminUI['role'][0]}
    input admin cellphone    ${adminTD['cellphoneR']}
    click save button    True
    verify lobibox info
    [Teardown]    delete all admin by UI

新建管理员_格式不正确的办公室电话
    [Tags]    createAdminCase
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${adminTD['realD']}
    select admin role    ${adminUI['role'][0]}
    input admin officephone    ${adminTD['officeE']}
    click save button
    verify admin office phone error msg    ${adminUI['err10']}

新建管理员_正确的办公室电话
    [Tags]    createAdminCase
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${adminTD['realD']}
    select admin role    ${adminUI['role'][0]}
    input admin officephone    ${adminTD['officeR']}
    click save button    True
    verify lobibox info
    [Teardown]    delete all admin by UI

新建管理员_输入异常的个人邮箱
    [Tags]    createAdminCase
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${adminTD['realD']}
    select admin role    ${adminUI['role'][0]}
    : FOR    ${mail}    IN    @{adminTD['mailE']}
    \    input admin mail    ${mail}
    \    click save button
    \    Run Keyword And Continue On Failure    verify admin mail error msg

新建管理员_输入正确的个人邮箱
    [Tags]    createAdminCase
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${adminTD['realD']}
    select admin role    ${adminUI['role'][0]}
    input admin mail    ${adminTD['mailR']}
    click save button    True
    verify lobibox info
    [Teardown]    delete all admin by UI

新建管理员_输入任意值QQ号码
    [Tags]    createAdminCase
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${adminTD['realD']}
    select admin role    ${adminUI['role'][0]}
    input admin qq    ${adminTD['qq']}
    click save button    True
    verify lobibox info
    [Teardown]    delete all admin by UI

新建管理员_输入任意通讯地址
    [Tags]    createAdminCase
    into admin manage UI
    click create admin button
    input admin name    ${defaultNameTD}
    input admin realname    ${adminTD['realD']}
    select admin role    ${adminUI['role'][0]}
    input admin address    ${adminTD['address']}
    click save button    True
    verify lobibox info
    [Teardown]    delete all admin by UI

新建管理员_取消“x”
    [Tags]    createAdminCase
    into admin manage UI
    click create admin button
    click "x" button
    verify lay UI not exit

新建管理员_取消按钮
    [Tags]    createAdminCase
    into admin manage UI
    click create admin button
    click cancle button
    verify lay UI not exit
