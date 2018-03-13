*** Settings ***
Resource          ../ElementLocators/AdministratorElement.robot
Resource          PublicKeywords.robot
Resource          vTopManage/LocationKeywords.robot
Resource          ChangePasswordKeywords.robot
Variables         ../TestData/AdministratorManage.py

*** Keywords ***
change admin password on the UI
    [Arguments]    ${adminName}
    [Documentation]    为测试重置密码修改密码
    ${win_handle_list}    login by new tab    ${adminName}    ${adminUI['pwdD']}
    click change password button
    input old password    ${adminUI['pwdD']}
    input new password    ${adminTD['newPWD']}
    input confirm password    ${AdminTD['newPWD']}
    click save button    True
    verify element text    ${login_errMSG_ID}    ${chgpwdUI['msg1']}
    Close Window
    [Teardown]    Select Window    ${win_handle_list[0]}

delete all admin by UI
    [Documentation]    通过数据库删除所有的创建的管理员
    into admin manage UI
    ${len}    get rows of database table    SELECT * FROM ulms_user WHERE id>57;
    : FOR    ${i}    IN RANGE    ${len}
    \    ${element}    Get Webelement    //a[contains(@onclick,'user_Delete')]
    \    Wait Until Element Is Enabled    ${element}
    \    Click Element    ${element}
    \    click confirm box confirm button
    \    Select Frame    ${admin_manage_iframe_ID}

clear env for edit admin
    [Documentation]    清空编辑管理员环境：1.删除所有管理员(admin除外)；2.删除所有的位置
    ...    3.关闭浏览器
    delete all admin by UI
    delete all location by UI
    close browser and kill chrome process

click admin recover button
    [Arguments]    ${admin}
    [Documentation]    点击恢复已经停用的用户
    ...    参数：管理员名称
    ${name_id}    get admin ID by database    ${admin}
    Click Element    //a[contains(@onclick,"edit_user(713,'开通',${name_id})")]
    Sleep    ${clickSleep}

click admin set manage range button
    [Arguments]    ${status}=True
    [Documentation]    点击设置管理范围按钮
    ...    参数：点击按钮后是否报错(默认不报错)
    Wait Until Element Is Visible    ${admin_set_position_button_ID}
    Click Element    ${admin_set_position_button_ID}
    : FOR    ${i}    IN RANGE    1
    \    Exit For Loop If    '${status}'=='False'
    \    Unselect Frame
    \    Wait Until Element Is Visible    ${layui_title_ID}
    \    Select Frame    ${layui_iframe_ID}
    \    Wait Until Element Is Visible    ${layui_title2_ID}

click create admin button
    [Documentation]    点击新建管理员按钮
    Wait Until Element Is Visible    ${admin_create_button_ID}
    Click Element    ${admin_create_button_ID}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${layui_title2_ID}

click delete admin button
    [Arguments]    ${admin}
    [Documentation]    在管理员管理界面点击删除按钮
    ...    参数:管理员名称
    ${name_id}    get admin ID by database    ${admin}
    Click Element    //a[contains(@onclick,'user_Delete(${name_id})')]
    Sleep    ${clickSleep}

click edit admin button
    [Arguments]    ${admin}
    [Documentation]    在管理员管理界面点击编辑按钮
    ...    参数：管理员名称
    ${name_id}    get admin ID by database    ${admin}
    Click Element    //a[contains(@onclick,'user_edit(${name_id})')]
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${layui_title2_ID}

click reset password button
    [Documentation]    点击重置密码按钮
    Wait Until Element Is Visible    ${admin_reset_password_button_ID}
    Click Element    ${admin_reset_password_button_ID}
    Sleep    ${clickSleep}

create admin user by UI
    [Arguments]    ${admin}    ${realName}=default    ${status}=open    ${date}=None    ${role}=default    ${local}=None
    [Documentation]    创建管理员用户
    ...    参数：1.管理员名称；2.真实姓名(有默认值)；3.是否开通(默认开通)；
    ...    4.有效期(默认不过期)；5.角色(默认系统管理员)；6.管理范围(默认初始化位置)
    into admin manage UI
    click create admin button
    input admin name    ${admin}
    ${real}    Set Variable If    '${realName}'=='default'    ${adminTD['realD']}    '${realName}'!='default'    ${realName}
    input admin realname    ${real}
    Run Keyword If    '${date}'!='None'    input admin expiry date    ${date}
    Run Keyword If    '${status}'!='open'    select admin status    ${adminUI['status'][1]}
    ${roleNew}    Set Variable If    '${role}'=='default'    ${adminUI['role'][0]}    '${role}'!='default'    ${adminUI['role'][1]}
    select admin role    ${roleNew}
    Run Keyword If    '${local}'!='None'    select location on layer UI    ${local}
    click save button    True
    verify lobibox info

get admin ID by database
    [Arguments]    ${admin}
    [Documentation]    通过数据库获取管理员账户的ID
    ...    参数：管理员名称
    ${id}    get return value of the database query    select id from ulms_user where name='${admin}';
    [Return]    ${id}

select location on layer UI
    [Arguments]    ${localName}    ${firstTree}=stop
    [Documentation]    在layer界面上选择位置
    ...    参数：位置名称
    Run Keyword If    '${firstTree}'=='stop'    Click Element    ${public_firstTree_switch}
    select name in the tree structure    ${localName}    vtop_manage_group    ${adminUI['init']}

input admin address
    [Arguments]    ${addr}
    [Documentation]    输入通讯地址
    ...    参数：地址
    Clear Element Text    ${admin_create_address_input_ID}
    Input Text    ${admin_create_address_input_ID}    ${addr}
    Sleep    ${inputSleep}

input admin cellphone
    [Arguments]    ${number}
    [Documentation]    输入手机号码
    ...    参数：手机号码
    Clear Element Text    ${admin_craete_cellphone_input_ID}
    Input Text    ${admin_craete_cellphone_input_ID}    ${number}
    Sleep    ${inputSleep}

input admin expiry date
    [Arguments]    ${date}
    [Documentation]    输入有效期时间
    ...    参数：有效期时间(正确格式：YYYY-MM-DD)
    Clear Element Text    ${admin_create_date_input_ID}
    Input Text    ${admin_create_date_input_ID}    ${date}
    Sleep    ${inputSleep}
    Click Element    ${layui_title2_ID}
    Sleep    ${clickSleep}

input admin mail
    [Arguments]    ${mail}
    [Documentation]    输入个人邮箱
    ...    参数：邮箱地址
    Clear Element Text    ${admin_create_mail_input_ID}
    Input Text    ${admin_create_mail_input_ID}    ${mail}
    Sleep    ${inputSleep}

input admin name
    [Arguments]    ${name}
    [Documentation]    输入管理员账户
    ...    参数：新建管理员账户名
    Clear Element Text    ${admin_create_nameinput_ID}
    Input Text    ${admin_create_nameinput_ID}    ${name}
    Sleep    ${inputSleep}

input admin officephone
    [Arguments]    ${number}
    [Documentation]    输入办公电话
    ...    参数：电话号码
    Clear Element Text    ${admin_create_officePhone_input_ID}
    Input Text    ${admin_create_officePhone_input_ID}    ${number}
    Sleep    ${inputSleep}

input admin qq
    [Arguments]    ${qq}
    [Documentation]    输入QQ号码
    ...    参数：qq号码
    Clear Element Text    ${admin_create_qq_input_ID}
    Input Text    ${admin_create_qq_input_ID}    ${qq}
    Sleep    ${inputSleep}

input admin realname
    [Arguments]    ${realname}
    [Documentation]    输入管理员真实姓名
    ...    参数：管理员真实姓名
    Clear Element Text    ${admin_create_realname_input_ID}
    Input Text    ${admin_create_realname_input_ID}    ${realname}
    Sleep    ${inputSleep}

input search admin
    [Arguments]    ${text}
    [Documentation]    输入搜索管理员
    ...    参数：搜索内容
    open the search UI
    Clear Element Text    ${admin_search_input_ID}
    Input Text    ${admin_search_input_ID}    ${text}
    Sleep    ${inputSleep}

into admin manage UI
    [Documentation]    进入到管理员管理界面
    refresh page
    Wait Until Element Is Visible    ${authority_menu_ID}
    Click Element    ${authority_menu_ID}
    Wait Until Element Is Visible    ${admin_manage_menu_ID}
    Click Element    ${admin_manage_menu_ID}
    Wait Until Element Is Visible    ${admin_manage_UI}
    Select Frame    ${admin_manage_iframe_ID}
    Wait Until Element Is Visible    ${admin_create_button_ID}

prepare env for edit admin
    [Documentation]    为测试编辑管理员准备环境：1.新建位置；2.创建用户(删除，搜索等)
    ...    3.更改管理员的密码
    login by admin
    create right location by UI    ${defaultNameTD}
    create admin user by UI    ${defaultNameTD}
    create admin user by UI    ${deleteNameTD}
    create admin user by UI    ${editNameTD}    status=stop
    : FOR    ${name}    IN    @{searchNameList}
    \    create admin user by UI    ${name}
    : FOR    ${i}    IN    ${defaultNameTD}    @{searchNameList}
    \    change admin password on the UI    ${i}

prepare env for admin sort test
    [Documentation]    为测试管理员排序准备环境：1.admin用户登录；2.创建用户
    login by admin
    ${len}    Get Length    ${sortTD['name1']}
    : FOR    ${name}    IN    @{sortTD['name1']}
    \    create right location by UI    ${name*3}
    : FOR    ${i}    IN RANGE    ${len}
    \    ${a}    Evaluate    ${i}%2
    \    ${statusN}    Set Variable If    '${a}'=='0'    open    '${a}'!='0'    ${adminUI['status'][1]}
    \    ${roleN}    Set Variable If    '${a}'=='0'    default    '${a}'!='0'    ${adminUI['role'][1]}
    \    create admin user by UI    ${sortTD['name1'][${i}]}    realName=${sortTD['name2'][${i}]}
    ...    date=${sortTD['date1'][${i}]}    local=${sortTD['name1'][${i}]*3}    status=${statusN}
    ...    role=${roleN}

click name for admin sort
    [Documentation]    点击管理员管理界面排序用户名
    Wait Until Element Is Visible    ${admin_sort_username}
    Click Element    ${admin_sort_username}
    Sleep    ${clickSleep}

click realname for admin sort
    [Documentation]    点击管理员管理界面排序真实姓名
    Wait Until Element Is Visible    ${admin_sort_realname}
    Click Element    ${admin_sort_realname}
    Sleep    ${clickSleep}

click rolename for admin sort
    [Documentation]    点击管理员管理界面排序用户角色
    Wait Until Element Is Visible    ${admin_sort_rolename}
    Click Element    ${admin_sort_rolename}
    Sleep    ${clickSleep}

click range for admin sort
    [Documentation]    点击管理员管理界面排序管理范围
    Wait Until Element Is Visible    ${admin_sort_range}
    Click Element    ${admin_sort_range}
    Sleep    ${clickSleep}

click expiry for admin sort
    [Documentation]    点击管理员管理界面排序有效期
    Wait Until Element Is Visible    ${admin_sort_date}
    Click Element    ${admin_sort_date}
    Sleep    ${clickSleep}

click status for admin sort
    [Documentation]    点击管理员管理界面排序用户状态
    Wait Until Element Is Visible    ${admin_sort_status}
    Click Element    ${admin_sort_status}
    Sleep    ${clickSleep}

select admin role
    [Arguments]    ${role}
    [Documentation]    选择管理员角色
    ...    参数：角色(系统管理员，普通管理员)
    ${roleVaule}    Set Variable If    '${role}'=='${adminUI['role'][0]}'    2    '${role}'=='${adminUI['role'][1]}'    3
    Select Radio Button    ${admin_create_role_radio_name}    ${roleVaule}
    Sleep    ${selectSleep}
    Radio Button Should Be Set To    ${admin_create_role_radio_name}    ${roleVaule}

select admin status
    [Arguments]    ${status}
    [Documentation]    选择管理员的状态
    ...    参数:管理员状态
    ${statusVaule}    Set Variable If    '${status}'=='${adminUI['status'][0]}'    713    '${status}'=='${adminUI['status'][1]}'    716
    Select Radio Button    ${admin_create_status_radio_name}    ${statusVaule}
    Sleep    ${selectSleep}
    Radio Button Should Be Set To    ${admin_create_status_radio_name}    ${statusVaule}

select admin on admin manage UI
    [Arguments]    ${admin}
    [Documentation]    勾选一个管理员账户
    ...    参数：管理员账户名称
    ${admin_id}    get admin ID by database    ${admin}
    Select Checkbox    id=orderId_${admin_id}
    Sleep    ${selectSleep}
    Checkbox Should Be Selected    id=orderId_${admin_id}

verify admin cellphone error msg
    [Arguments]    ${msg}
    [Documentation]    手机号码错误信息验证
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${admin_create_cellphone_error_ID}
    verify element text    ${admin_create_cellphone_error_ID}    ${msg}

verify admin expiry on admin manage UI
    [Arguments]    ${name}    ${date}
    [Documentation]    在管理员管理界面验证管理员有效时间
    ...    参数：1.管理员名称；2.有效时间
    into admin manage UI
    ${name_id}    get admin ID by database    ${name}
    verify element text    //tr[@id="tr_${name_id}"]/td[6]    ${date}

verify admin mail error msg
    [Documentation]    验证创建管理员时个人邮箱错误提示信息
    Wait Until Element Is Visible    ${admin_create_mail_error_ID}
    verify element text    ${admin_create_mail_error_ID}    ${adminUI['err11']}

verify admin name on admin manage UI
    [Arguments]    ${admin}
    [Documentation]    在管理员管理界面上验证管理员用户名
    ...    参数：管理员名称
    into admin manage UI
    ${name_id}    get admin ID by database    ${admin}
    verify element text    //tr[@id="tr_${name_id}"]/td[2]    ${admin}

verify admin name error msg
    [Arguments]    ${msg}
    [Documentation]    验证新建管理员用户名错误信息
    ...    参数：错误信息
    Wait Until Element Is Visible    ${admin_create_name_error_ID}
    verify element text    ${admin_create_name_error_ID}    ${msg}

verify admin office phone error msg
    [Arguments]    ${errMsg}
    [Documentation]    验证创建管理员时办公室电话错误提示信息
    ...    参数：错误信息
    Wait Until Element Is Visible    ${admin_create_officePhone_error_ID}
    verify element text    ${admin_create_officePhone_error_ID}    ${errMsg}

verify admin range on admin manage UI
    [Arguments]    ${name}    ${range}
    [Documentation]    在管理员管理界面验证管理员管理范围
    ...    参数：1.管理员名；3.管理范围
    into admin manage UI
    ${name_id}    get admin ID by database    ${name}
    verify element text    //tr[@id="tr_${name_id}"]/td[5]    ${range}

verify admin realname on admin manage UI
    [Arguments]    ${name}    ${realname}
    [Documentation]    在管理员管理界面验证管理员真实姓名
    ...    参数：1.管理员名称；2.真实姓名
    into admin manage UI
    ${name_id}    get admin ID by database    ${name}
    verify element text    //tr[@id="tr_${name_id}"]/td[3]    ${realname}

verify admin realname error msg
    [Arguments]    ${msg}
    [Documentation]    验证新建管理真实姓名错误提示信息
    ...    参数：错误信息
    Wait Until Element Is Visible    ${admin_create_realname_error_ID}
    verify element text    ${admin_create_realname_error_ID}    ${msg}

verify admin role on admin manage UI
    [Arguments]    ${name}    ${role}
    [Documentation]    在管理员管理界面验证管理员用户角色
    ...    参数：1.管理员名称；2.管理员角色
    into admin manage UI
    ${name_id}    get admin ID by database    ${name}
    verify element text    //tr[@id="tr_${name_id}"]/td[4]    ${role}

verify admin role error msg
    [Arguments]    ${msg}
    [Documentation]    验证新建管理员角色错误提示信息，参数为错误信息
    Wait Until Element Is Visible    ${admin_create_role_error_ID}
    verify element text    ${admin_create_role_error_ID}    ${msg}

verify admin status on admin manage UI
    [Arguments]    ${name}    ${status}
    [Documentation]    在管理员管理界面验证管理员用户状态
    ...    参数：1.管理员名称；2.管理员状态
    into admin manage UI
    ${name_id}    get admin ID by database    ${name}
    Element Should Contain    //tr[@id="tr_${name_id}"]/td[7]    ${status}

verify admin manage UI info
    [Documentation]    管理员管理界面信息验证
    verify same element text by UI    ${public_table_head}    ${EMPTY}    @{adminUI['tableH']}
    verify same element text by UI    ${admin_table_admin_td}    ${EMPTY}    @{adminUI['tableAdmin']}    ${adminUI['statusT'][0]}    ${EMPTY}
    verify element title attribute value    ${admin_create_button_ID}    ${adminUI['title3']}
    verify element title attribute value    ${admin_reset_password_button_ID}    ${adminUI['title4']}
    verify element title attribute value    ${admin_set_position_button_ID}    ${adminUI['title5']}
    verify element title attribute value    //a[contains(@onclick,'user_edit')]    ${adminUI['title6']}
    verify element title attribute value    //a[contains(@onclick,'user_Delete')]    ${adminUI['title7']}
    verify element title attribute value    //a[contains(@onclick,'edit_user(713,')]    ${adminUI['title8']}
    open the search UI
    verify element placeholder attribute value    ${admin_search_input_ID}    ${adminUI['msg6']}
    verify input box character limit    ${admin_search_input_ID}    ${adminUI['len1']}
    verify element text    ${public_manage_title_ID}    ${adminUI['title2']}
    Unselect Frame
    verify element text    ${admin_manage_tab_ID}    ${adminUI['title1']}

verify create admin UI info
    [Documentation]    新建管理员界面信息验证
    verify same element text by UI    ${layui_label_ID}    @{adminUI['labelL'][:3]}    @{adminUI['status']}    @{adminUI['labelL'][3:5]}    ${EMPTY}    @{adminUI['labelL'][5:]}
    verify same element text by UI    ${admin_create_role_label}    @{adminUI['role']}
    verify same element text by UI    ${admin_create_widget_title}    @{adminUI['widget1']}
    verify element text    ${admin_create_date_warn}    ${adminUI['msg2']}
    verify element value attribute value    ${admin_create_range_value}    ${adminUI['all']}
    Element Should Contain    ${admin_create_range_value}/..    ${adminUI['Select']}
    verify element placeholder attribute value    ${admin_create_nameinput_ID}    ${adminUI['msg1']}
    verify input box character limit    ${admin_create_nameinput_ID}    ${adminUI['len1']}
    verify input box character limit    ${admin_create_realname_input_ID}    ${adminUI['len1']}
    verify element placeholder attribute value    ${admin_craete_cellphone_input_ID}    ${adminUI['msg3']}
    verify input box character limit    ${admin_craete_cellphone_input_ID}    ${adminUI['len2']}
    verify element placeholder attribute value    ${admin_create_officePhone_input_ID}    ${adminUI['msg4']}
    verify input box character limit    ${admin_create_officePhone_input_ID}    ${adminUI['len3']}
    verify element placeholder attribute value    ${admin_create_mail_input_ID}    ${adminUI['msg5']}
    verify input box character limit    ${admin_create_mail_input_ID}    ${adminUI['len4']}
    verify input box character limit    ${admin_create_qq_input_ID}    ${adminUI['len5']}
    verify input box character limit    ${admin_create_address_input_ID}    ${adminUI['len6']}
    verify lay UI title info    ${adminUI['title9']}

verify edit admin UI info
    [Documentation]    编辑管理员界面信息验证
    verify element value attribute value    ${admin_create_realname_input_ID}    ${adminTD['realD']}
    verify lay UI title info    ${adminUI['title10']}

verify admin set manage range UI info
    [Arguments]    ${localName}
    [Documentation]    设置范围界面信息验证
    ...    参数：管理范围的名称
    select location on layer UI    ${localName}
    verify element text    ${admin_create_widget_title}    ${adminUI['widget2']}
    verify element title attribute value    ${admin_create_range_value}    ${localName}
    verify lay UI title info    ${adminUI['title11']}

verify general manager modules
    [Arguments]    ${admin}    ${realName}
    [Documentation]    验证普通管理员的模块信息
    ...    参数：普通管理员名称
    ${win_handle_list}    login by new tab    ${admin}    ${adminUI['pwdD']}    ${realName}
    ${li_tag_num}    Execute Javascript    var len=document.getElementById('${menu_ul_ID[3:]}').getElementsByTagName('li').length;return len;
    Should Be Equal As Integers    ${li_tag_num}    10
    ${button_tag_num}    Execute Javascript    var len=document.getElementById('${short_button_ID[3:]}').getElementsByTagName('button').length;return len;
    Should Be Equal As Integers    ${button_tag_num}    3
    verify element text    ${menu_ul_ID}    ${adminUI['modules']}
    Close Window
    [Teardown]    Select Window    ${win_handle_list[0]}
