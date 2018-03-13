*** Settings ***
Suite Setup       prepare env for edit admin
Suite Teardown    clear env for edit admin
Force Tags      adminManageCase
Resource          ../../Keyword/AdministratorKeywords.robot
Resource          ../../Keyword/UserManage/UserKeywords.robot

*** Test Cases ***
编辑管理员_界面信息验证
    [Tags]    adminInfoCase
    into admin manage UI
    click edit admin button    ${defaultNameTD}
    verify edit admin UI info

编辑管理员_真实姓名没有任何值
    [Tags]    editAdminCase
    into admin manage UI
    click edit admin button    ${defaultNameTD}
    input admin realname    ${EMPTY}
    click save button
    verify admin realname error msg    ${adminUI['err6']}

编辑管理员_真实姓名全为空格
    [Tags]    editAdminCase
    into admin manage UI
    click edit admin button    ${defaultNameTD}
    input admin realname    ${SPACE*8}
    click save button
    verify admin realname error msg    ${adminUI['err6']}

编辑管理员_输入正确真实姓名
    [Tags]    editAdminCase    smokeCase
    into admin manage UI
    click edit admin button    ${defaultNameTD}
    input admin realname    ${adminTD['realR']}
    click save button    True
    verify lobibox info
    verify admin realname on admin manage UI    ${defaultNameTD}    ${adminTD['realR']}

编辑管理员_停用
    [Tags]    editAdminCase    smokeCase
    into admin manage UI
    click edit admin button    ${defaultNameTD}
    select admin status    ${adminUI['status'][1]}
    click save button    True
    verify lobibox info
    verify admin status on admin manage UI    ${defaultNameTD}    ${adminUI['statusT'][1]}

编辑管理员_开通
    [Tags]    editAdminCase    smokeCase
    into admin manage UI
    click edit admin button    ${editNameTD}
    select admin status    ${adminUI['status'][0]}
    click save button    True
    verify lobibox info
    verify admin status on admin manage UI    ${editNameTD}    ${adminUI['statusT'][0]}

编辑管理员_不输入有效期
    [Tags]    editAdminCase
    into admin manage UI
    click edit admin button    ${defaultNameTD}
    input admin expiry date    ${EMPTY}
    click save button    True
    verify lobibox info
    into admin manage UI
    verify admin expiry on admin manage UI    ${defaultNameTD}    ${adminUI['longTime']}

编辑管理员_输入错误格式有效期
    [Tags]    editAdminCase
    : FOR    ${name}    IN    @{adminTD['expiryE']}
    \    into admin manage UI
    \    click edit admin button    ${defaultNameTD}
    \    input admin expiry date    ${name}
    \    click save button    True
    \    verify lobibox info
    \    Run Keyword And Continue On Failure    verify admin expiry on admin manage UI    ${defaultNameTD}    ${adminTD['nowTime']}

编辑管理员_输入正确的有效期
    [Tags]    editAdminCase    smokeCase
    into admin manage UI
    click edit admin button    ${defaultNameTD}
    input admin expiry date    ${adminTD['expiryR']}
    click save button    True
    verify lobibox info
    verify admin expiry on admin manage UI    ${defaultNameTD}    ${adminTD['expiryR']}

编辑管理员_系统管理员
    [Tags]    editAdminCase    smokeCase
    [Setup]    create admin user by UI    ${editNameTD}11    role=${adminUI['role'][1]}
    into admin manage UI
    click edit admin button    ${editNameTD}11
    select admin role    ${adminUI['role'][0]}
    click save button    True
    verify lobibox info
    verify admin role on admin manage UI    ${editNameTD}11    ${adminUI['role'][0]}

编辑管理员_普通管理员
    [Tags]    editAdminCase    smokeCase
    into admin manage UI
    click edit admin button    ${deleteNameTD}
    select admin role    ${adminUI['role'][1]}
    click save button    True
    verify lobibox info
    verify admin role on admin manage UI    ${deleteNameTD}    ${adminUI['role'][1]}
    verify general manager modules    ${deleteNameTD}    ${adminTD['realD']}

编辑管理员_选择管理范围
    [Tags]    editAdminCase    smokeCase
    into admin manage UI
    click edit admin button    ${defaultNameTD}
    select location on layer UI    ${defaultNameTD}    open
    click save button    True
    verify lobibox info
    verify admin range on admin manage UI    ${defaultNameTD}    ${defaultNameTD}

编辑管理员_手机格式不对
    [Tags]    editAdminCase
    into admin manage UI
    click edit admin button    ${defaultNameTD}
    input admin cellphone    ${adminTD['cellphoneE1']}
    click save button
    verify admin cellphone error msg    ${adminUI['err8']}

编辑管理员_手机号码不是数字
    [Tags]    editAdminCase
    into admin manage UI
    click edit admin button    ${defaultNameTD}
    input admin cellphone    ${adminTD['cellphoneE2']}
    click save button
    verify admin cellphone error msg    ${adminUI['err9']}

编辑管理员_手机号码正确
    [Tags]    editAdminCase
    into admin manage UI
    click edit admin button    ${defaultNameTD}
    input admin cellphone    ${adminTD['cellphoneR']}
    click save button    True
    verify lobibox info

编辑管理员_格式不正确的办公室电话
    [Tags]    editAdminCase
    into admin manage UI
    click edit admin button    ${defaultNameTD}
    input admin officephone    ${adminTD['officeE']}
    click save button
    verify admin office phone error msg    ${adminUI['err10']}

编辑管理员_正确的办公室电话
    [Tags]    editAdminCase
    into admin manage UI
    click edit admin button    ${defaultNameTD}
    input admin officephone    ${adminTD['officeR']}
    click save button    True
    verify lobibox info

编辑管理员_输入异常的个人邮箱
    [Tags]    editAdminCase
    into admin manage UI
    click edit admin button    ${defaultNameTD}
    : FOR    ${mail}    IN    @{adminTD['mailE']}
    \    input admin mail    ${mail}
    \    click save button
    \    Run Keyword And Continue On Failure    verify admin mail error msg

编辑管理员_输入正确的个人邮箱
    [Tags]    editAdminCase
    into admin manage UI
    click edit admin button    ${defaultNameTD}
    input admin mail    ${adminTD['mailR']}
    click save button    True
    verify lobibox info

编辑管理员_输入任意值QQ号码
    [Tags]    editAdminCase
    into admin manage UI
    click edit admin button    ${defaultNameTD}
    input admin qq    ${adminTD['qq']}
    click save button    True
    verify lobibox info

编辑管理员_输入任意通讯地址
    [Tags]    editAdminCase
    into admin manage UI
    click edit admin button    ${defaultNameTD}
    input admin address    ${adminTD['address']}
    click save button    True
    verify lobibox info

编辑管理员_取消“x”
    [Tags]    editAdminCase
    into admin manage UI
    click edit admin button    ${defaultNameTD}
    click "x" button
    verify lay UI not exit

编辑管理员_取消按钮
    [Tags]    editAdminCase
    into admin manage UI
    click edit admin button    ${defaultNameTD}
    click cancle button
    verify lay UI not exit

恢复停用用户
    [Tags]    editAdminCase
    [Setup]    create admin user by UI    ${editNameTD}12    status=stop
    into admin manage UI
    click admin recover button    ${editNameTD}12
    verify lobibox info    ${lobiMsg1}!
    verify admin status on admin manage UI    ${editNameTD}12    ${adminUI['statusT'][0]}

设置管理范围_未勾选管理员账户
    [Tags]    setAdminRangeCase
    into admin manage UI
    click admin set manage range button    False
    verify lobibox info    ${adminBox['msg3']}

设置管理范围_界面信息验证
    [Tags]    adminInfoCase
    into admin manage UI
    select admin on admin manage UI    ${defaultNameTD}
    click admin set manage range button
    verify admin set manage range UI info    ${defaultNameTD}

设置管理范围_勾选一个用户
    [Tags]    setAdminRangeCase
    into admin manage UI
    select admin on admin manage UI    ${defaultNameTD}
    click admin set manage range button
    select location on layer UI    ${defaultNameTD}
    click save button    True
    verify admin range on admin manage UI    ${defaultNameTD}    ${defaultNameTD}

设置管理范围_勾选多个用户
    [Tags]    setAdminRangeCase
    into admin manage UI
    select table checkbox on UI
    click admin set manage range button
    select location on layer UI    ${defaultNameTD}
    click save button    True
    : FOR    ${user}    IN    ${defaultNameTD}    ${deleteNameTD}    ${editNameTD}    @{searchNameList}
    \    verify admin range on admin manage UI    ${user}    ${defaultNameTD}

设置管理范围_取消按钮
    [Tags]    setAdminRangeCase
    into admin manage UI
    select table checkbox on UI
    click admin set manage range button
    click cancle button
    verify lay UI not exit

设置管理范围_取消"x"
    [Tags]    setAdminRangeCase
    into admin manage UI
    select table checkbox on UI
    click admin set manage range button
    click "x" button
    verify lay UI not exit

重置密码_确认弹窗信息验证
    [Tags]    adminInfoCase
    into admin manage UI
    select admin on admin manage UI    ${defaultNameTD}
    click reset password button
    verify confirm box info    ${adminBox['msg6']}

重置密码_取消
    [Tags]    resetPasswordCase
    into admin manage UI
    select admin on admin manage UI    ${defaultNameTD}
    click reset password button
    click confirm box cancel button
    verify confirm not exist

重置密码_未勾选用户
    [Tags]    resetPasswordCase
    into admin manage UI
    click reset password button
    verify lobibox info    ${adminBox['msg2']}

重置密码_勾选一个用户
    [Tags]    resetPasswordCase
    into admin manage UI
    select admin on admin manage UI    ${deleteNameTD}
    click reset password button
    click confirm box confirm button
    verify lobibox info    ${adminBox['msg4']}
    ${win_handle_list}    login by new tab    ${deleteNameTD}    ${adminUI['pwdD']}
    Close Window
    [Teardown]    Select Window    ${win_handle_list[0]}

重置密码_勾选多个用户
    [Tags]    resetPasswordCase
    into admin manage UI
    select table checkbox on UI
    click reset password button
    click confirm box confirm button
    verify lobibox info    ${adminBox['msg4']}
    : FOR    ${admin}    IN    @{searchNameList}
    \    ${win_handle_list}    login by new tab    ${admin}    ${adminUI['pwdD']}
    \    Close Window
    \    Select Window    ${win_handle_list[0]}
    [Teardown]    Select Window    ${win_handle_list[0]}

搜索管理员_不输入任何值点击搜索按钮
    [Tags]    searchAdminCase
    into admin manage UI
    ${len1}    get current table record number
    input search admin    ${EMPTY}
    click search button
    verify table records current page    ${len1}

搜索管理员_不存在的管理员账户或者真实姓名搜索
    [Tags]    searchAdminCase
    into admin manage UI
    : FOR    ${txt}    IN    @{searchNoName}
    \    input search admin    ${txt}
    \    click search button
    \    verify table records current page    0

搜索管理员_已存在的管理员账户名搜索
    [Tags]    searchAdminCase
    into admin manage UI
    input search admin    ${searchNameList[1]}
    click search button
    verify table records current page    1

搜索管理员_已存在的管理员真实姓名搜索
    [Tags]    searchAdminCase
    [Setup]    create admin user by UI    ${defaultNameTD}11    realName=${editNameTD}test
    into admin manage UI
    input search admin    ${editNameTD}test
    click search button
    verify table records current page    1

搜索管理员_输入管理员账户名部分字段搜索
    [Tags]    searchAdminCase
    into admin manage UI
    input search admin    ${searchNameList[0]}
    click search button
    ${len}    Get Length    ${searchNameList}
    verify table records current page    ${len}

删除管理员_界面信息验证
    [Tags]    adminInfoCase
    into admin manage UI
    click delete admin button    ${deleteNameTD}
    verify confirm box info    ${adminBox['msg7']}

删除管理员_取消
    [Tags]    deleteAdminCase
    into admin manage UI
    click delete admin button    ${deleteNameTD}
    click confirm box cancel button
    verify confirm not exist

删除管理员_确认
    [Tags]    deleteAdminCase
    into admin manage UI
    click delete admin button    ${deleteNameTD}
    click confirm box confirm button
    verify confirm not exist
    ${status}    Run Keyword And Return Status    verify admin name on admin manage UI    ${deleteNameTD}
    Should Be Equal As Strings    ${status}    False
