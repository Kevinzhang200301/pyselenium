*** Settings ***
Resource          ../../ElementLocators/UserElementID.robot
Resource          ../PublicKeywords.robot
Resource          UserGroupKeywords.robot
Resource          ../ResourceManage/TemplateKeywords.robot
Variables         ../../TestData/UserManage.py

*** Keywords ***
assign all template to user
    [Arguments]    ${userName}
    [Documentation]    把所有模板分配给用户
    ...    参数：用户名
    into user management UI
    select user on the user manage UI    ${userName}
    click assign template button
    select table checkbox on UI
    click save button    True
    verify lobibox info

clear env for assign template
    [Documentation]    清空分配模板测试环境：1.删除所有用户，2.删除所有模板，3.删除所有镜像，4.关闭浏览器
    delete all user by UI
    delete all template by UI
    delete all vhd by UI
    close browser and kill chrome process

clear env for edit user
    [Documentation]    清空编辑用户环境：1.删除所有用户，2.关闭浏览器
    delete all user by UI
    close browser and kill chrome process

click Basics button
    [Documentation]    点击用户管理界面基础操作按钮
    Click Element    ${tuser_basis_button_ID}
    Wait Until Element Is Visible    ${tuser_basis_openuser_ID}    error=点击基础操作后不能看到用户策略按钮

click assign template button
    [Arguments]    ${status}=True
    [Documentation]    点击分配模板
    ...    参数：是否勾选用户(默认为True即勾选用户),False表示没有勾选任何用户
    Click Element    ${tuser_assign_template_button}
    : FOR    ${i}    IN    1
    \    Exit For Loop If    '${status}'=='False'
    \    Unselect Frame
    \    Wait Until Element Is Visible    ${layui_title_ID}
    \    Select Frame    ${layui_iframe_ID}
    \    Wait Until Element Is Visible    ${tuser_assigntmpl_nameinput}

click assign template search button
    [Documentation]    在分配模板界面上点击查询按钮
    Click Element    ${tuser_assigntmpl_search_button}
    Sleep    ${clickSleep}

click cancel auto button on see template UI
    [Arguments]    ${tempName}
    [Documentation]    查看模板界面点击取消开关机联动按钮
    ...    参数：1.设置开关机联动的模板
    Wait Until Element Is Visible    //a[contains(@href,'"${tempName}",0')]
    Click Element    //a[contains(@href,'"${tempName}",0')]

click create user button
    [Documentation]    点击用户管理界面的新建用户按钮
    Wait Until Element Is Visible    ${tuser_addbth_ID}    error=新建用户按钮不可见
    Click Element    ${tuser_addbth_ID}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}    error=新建用户界面标题不可见
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${tuser_addname_ID}    error=添加界面用户名栏不可见

click delete button on the see VM UI
    [Documentation]    用户查看虚拟机界面点击删除按钮
    Click Element    ${tuser_seevm_delet_button_ID}

click delete more button on see template UI
    [Documentation]    查看模板界面点击多个模板删除按钮
    Click Element    ${tuser_seetmpl_deletes_button}
    Sleep    ${clickSleep}

click delete one button on see template UI
    [Arguments]    ${userName}    ${tempName}
    [Documentation]    查看模板界面点击一个模板删除按钮
    ...    参数：1.用户名；2.待删除模板名称
    ${userId}    get user ID in database    ${userName}
    ${userTempId}    get return value of the database query    SELECT id FROM account_user_templates WHERE name='${tempName}' AND user_id='${userId}';
    Click Element    //a[contains(@href,'del_virtual(${userId},${userTempId})')]

click delete user button
    [Arguments]    ${userName}
    [Documentation]    点击用户管理界面某用户删除按钮
    ...    参数：删除用户名
    ${nameId}    get user ID in database    ${userName}
    Click Element    //a[contains(@onclick,'del_user(${nameId})')]

click edit user button
    [Arguments]    ${userName}
    [Documentation]    点击用户管理界面某用户编辑按钮
    ...    参数：用户名
    ${nameId}    get user ID in database    ${userName}
    Click Element    //a[contains(@onclick,'edit_user(${nameId})')]
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}    error=编辑用户界面标题不可见
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${tuser_addname_ID}    error=编辑界面用户名栏不可见

click query button on the assign template UI
    [Documentation]    点击分配模板界面查询按钮
    Click Element    ${tuser_assigntmpl_search_button}
    Sleep    ${clicksleep}

click restart button on the see VM UI
    [Documentation]    用户查看虚拟机界面点击重启按钮
    Click Element    ${tuser_seevm_restart_button_ID}

click rollback button on the see VM UI
    [Documentation]    用户查看虚拟机界面点击还原按钮
    Click Element    ${tuser_seevm_rollback_button}

click see VM on user manage UI
    [Arguments]    ${userName}
    [Documentation]    用户管理界面上点击查看虚拟机按钮
    ...    参数：待查看虚拟机的用户名
    ${nameId}    get user ID in database    ${userName}
    Click Element    //a[contains(@onclick,'see_computer(${nameId})')]
    Unselect Frame
    Wait Until Element Is Visible    ${tuser_seevm_UI}
    Select Frame    ${tuser_seevm_iframe}
    Wait Until Element Is Visible    ${tuser_seevm_shutdown_button_ID}

click set auto button on see template UI
    [Arguments]    ${tempName}
    [Documentation]    查看模板界面点击设置开关机联动按钮
    ...    参数：1.设置开关机联动的模板
    Wait Until Element Is Visible    //a[contains(@href,'"${tempName}",1')]
    Click Element    //a[contains(@href,'"${tempName}",1')]

click shutdown button on the see VM UI
    [Documentation]    用户查看虚拟机界面点击关机按钮
    Click Element    ${tuser_seevm_shutdown_button_ID}

click start button on the see VM UI
    [Documentation]    用户查看虚拟机界面点击开机按钮
    Click Element    ${tuser_seevm_start_button_ID}

click template name on see template UI
    [Arguments]    ${userName}    ${tempName}
    [Documentation]    查看模板界面点击模板名称查看详情
    ${userId}    get user ID in database    ${userName}
    ${userTempId}    get return value of the database query    SELECT id FROM account_user_templates WHERE name='${tempName}' AND user_id='${userId}';
    Click Element    //a[contains(@href,'seeUserTmplateDetail(${userId},${userTempId})')]
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${layui_title2_ID}

click template number on user manage UI
    [Arguments]    ${userName}
    [Documentation]    在用户管理界面点击用户的模板数量(大于0)
    ...    参数：待查看的用户名
    ${nameId}    get user ID in database    ${userName}
    Click Element    //a[contains(@onclick,'see_virtual(${nameId})')]
    Unselect Frame
    Wait Until Element Is Visible    ${tuser_seetmpl_UI}
    Select Frame    ${tuser_seetmpl_iframe_ID}
    Wait Until Element Is Visible    ${tuser_seetmpl_deletes_button}

click update button on the see VM UI
    [Documentation]    用户查看虚拟机界面点击更新按钮
    Click Element    ${tuser_seevm_update_button_ID}

click username on user manage UI
    [Arguments]    ${userName}
    [Documentation]    用户管理界面上点击某用户名，查看用户详情界面
    ...    参数：用户名
    ${nameId}    get user ID in database    ${userName}
    Click Element    //a[@onclick='showUserDetail(${nameId})']
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}    error=用户详细信息界面标题不可见
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${tuser_userdetail_label}    error=用户详细信息信息栏不可见

create right user by UI
    [Arguments]    ${userName}    ${realName}=default    ${pwd}=default    ${email}=None    ${pub}=False    ${open}=True    ${group}=init
    [Documentation]    用户管理界面新建正确的用户
    ...    参数：1.用户名；2.真实姓名(有默认值)；3.用户密码(默认值:password)；4.电子邮件(默认没有电子邮件)；
    ...    5.是否为发布者(默认非发布者)；6.是否开通(默认开通)；7.用户组
    into user management UI
    Run Keyword If    '${group}'!='init'    select usergroup on the user manage UI    ${group}
    click create user button
    input user username    ${userName}
    ${real}    Set Variable If    '${realName}'=='default'    ${userTD['realD']}
    ...    '${realName}'!='default'    ${realName}
    input user realname    ${real}
    Run Keyword If    '${pwd}'!='default'    input user password    ${pwd}
    Run Keyword If    '${email}'!='None'    input user email    ${email}
    Run Keyword If    '${pub}'!='False'    select user publisher or not    ${userUI['pub'][0]}
    Run Keyword If    '${open}'!='True'    select user open or stop    ${userUI['userStatus'][1]}
    click save button    True
    verify lobibox info    
    verify user username on the UI    ${userName}

delete all user by UI
    [Documentation]    在界面上删除所有的vtop用户
    into user management UI
    ${len}    get rows of database table    SELECT id FROM account_users;
    : FOR    ${i}    IN RANGE    ${len}
    \    ${element}    Get Webelement    //a[contains(@onclick,'del_user')]
    \    Wait Until Element Is Enabled    ${element}    error=删除按钮不可用
    \    Click Element    ${element}
    \    click confirm box confirm button
    \    Select Frame    ${tuser_iframetab_ID}
    \    Select Frame    ${tuser_iframmgr_ID}
    ${len}    get rows of database table    SELECT id FROM account_users;
    Should Be Equal As Integers    ${len}    0    msg=用户没有全部删除

get user ID in database
    [Arguments]    ${userName}
    [Documentation]    获取数据库中vtop用户的ID
    ${queryresult}    get return value of the database query    select id from account_users where username='${userName}';
    ${mysql_name_id}    Set Variable    ${queryresult}
    [Return]    ${mysql_name_id}

input assign template search name
    [Arguments]    ${tempName}
    [Documentation]    在分配模板界面上输入搜索的名称
    ...    参数：待搜索模板名称
    Clear Element Text    ${tuser_assigntmpl_nameinput}
    Input Text    ${tuser_assigntmpl_nameinput}    ${tempName}
    Sleep    ${inputSleep}

input search user name
    [Arguments]    ${searchName}
    [Documentation]    输入待搜索的用户名
    ...    参数：搜索用户名
    Clear Element Text    ${tuser_search_input_ID}
    Input Text    ${tuser_search_input_ID}    ${searchName}
    Sleep    ${inputSleep}

input template name on the assign template UI
    [Arguments]    ${tempName}
    [Documentation]    在分配模板界面输入要查询的模板名称
    ...    参数：模板名称
    Clear Element Text    ${tuser_assigntmpl_nameinput}
    Input Text    ${tuser_assigntmpl_nameinput}    ${tempName}
    Sleep    ${inputsleep}

input user email
    [Arguments]    ${vtopuser_email}
    [Documentation]    在创建或者编辑用户时输入电子邮件
    ...    参数：电子邮件
    Clear Element Text    ${tuser_addemail_ID}
    Input Text    ${tuser_addemail_ID}    ${vtopuser_email}
    Sleep    ${inputSleep}

input user expired_date
    [Arguments]    ${expired_data}
    [Documentation]    在创建或者编辑用户时输入有效期时间
    ...    参数：有效期时间(正确格式为yyyy-mm-dd)
    Clear Element Text    ${tuser_addtime_ID}
    Input Text    ${tuser_addtime_ID}    ${expired_data}
    Click Element    ${layui_title2_ID}
    Sleep    ${inputSleep}

input user password
    [Arguments]    ${userPwd}
    [Documentation]    在创建或者编辑用户时输入密码
    ...    参数：密码
    Clear Element Text    ${tuser_addpwd_ID}
    Input Text    ${tuser_addpwd_ID}    ${userPwd}
    Sleep    ${inputSleep}

input user realname
    [Arguments]    ${realName}
    [Documentation]    在创建或者编辑用户时输入真实姓名
    ...    参数：真实姓名
    Clear Element Text    ${tuser_addrealname_ID}
    Input Text    ${tuser_addrealname_ID}    ${realName}
    Sleep    ${inputSleep}

input user username
    [Arguments]    ${userName}
    [Documentation]    在创建或者编辑用户时输入用户名
    ...    参数：用户名
    Clear Element Text    ${tuser_addname_ID}
    Input Text    ${tuser_addname_ID}    ${userName}
    Sleep    ${inputSleep}

into user management UI
    [Documentation]    进入到用户管理界面
    refresh page
    Wait Until Element Is Enabled    ${user_manage_menu_ID}    error=左侧用户管理选择栏不可见
    Click Element    ${user_manage_menu_ID}
    Wait Until Element Is Visible    ${tuser_menu_ID}    error=左侧用户选择栏不可见
    Click Element    ${tuser_menu_ID}
    Wait Until Element Is Visible    ${tuser_UI_ID}    error=用户界面不可见
    Select Frame    ${tuser_iframetab_ID}
    Select Frame    ${tuser_iframmgr_ID}
    Wait Until Element Is Visible    ${tuser_addbth_ID}    error=添加用户按钮不可见

prepare env for assign template
    [Documentation]    1.打开浏览器并用admin登录vTopCenter，2.为测试分配模板准备环境：创建磁盘加密模板，发布者，普通用户；
    ...    3.为测试查看模板准备环境：用户分配所有模板，某个用户设置为开关机联动
    login by admin
    create right user by UI    ${userTD['pubName']}    pub=${userUI['pub'][0]}
    create right user by UI    ${userTD['comName'][0]}
    create right user by UI    ${userTD['comName'][1]}
    create right user by UI    ${userTD['nameD']}
    create right user by UI    ${userTD['nameD']}11
    create right vhd by UI    ${vhdNameP}
    create right template by UI    ${userTD['tempName'][0]}    vhdName=${vhdNameP}    diskEncrypt=${tempUI['diskEncry'][1]}
    : FOR    ${temp}    IN    @{userTD['tempName'][1:]}
    \    create right template by UI    ${temp}    vhdName=${vhdNameP}
    assign all template to user    ${userTD['nameD']}
    assign all template to user    ${userTD['nameD']}11
    into user management UI
    click template number on user manage UI    ${userTD['nameD']}11
    click set auto button on see template UI    ${userTD['tempName'][1]}
    click confirm box confirm button
    verify lobibox info    ${userBox['msg6'][:3]}${userTD['tempName'][1]}${userBox['msg6'][3:]}

prepare env for edit user
    [Documentation]    为测试编辑用户准备环境：1.打开游览器并用admin用户登录vTopCenter,2.创建编辑用户，
    ...    3.创建搜索用户，4创建删除用户
    login by admin
    create right user by UI    ${userTD['nameD']}
    create right user by UI    ${userTD['editD']}    email=${userTD['emailR']}    open=False    pub=True
    : FOR    ${user}    IN    @{userTD['srcName']}
    \    create right user by UI    ${user}
    create right user by UI    ${userTD['del']}

select template on assign template UI
    [Arguments]    ${tempName}
    [Documentation]    在分配模板界面选择模板
    ...    参数：模板名称
    ${nameId}    get template ID by database    ${tempName}
    Select Checkbox    id=orderId_${nameId}
    Sleep    ${selectsleep}
    Checkbox Should Be Selected    id=orderId_${nameId}

select template on see template UI
    [Arguments]    ${userName}    ${tempName}
    [Documentation]    在查看模板界面勾选模板
    ...    参数：1.用户名；2.待勾选模板名称
    ${userId}    get user ID in database    ${userName}
    ${userTempId}    get return value of the database query    SELECT id FROM account_user_templates WHERE name='${tempName}' AND user_id='${userId}';
    Select Checkbox    id=orderId_${userTempId}
    Sleep    ${selectSleep}
    Checkbox Should Be Selected    id=orderId_${userTempId}

select user on the user manage UI
    [Arguments]    ${userName}
    [Documentation]    在管理用户界面勾选用户
    ...    参数：用户名
    ${nameId}    get user ID in database    ${userName}
    Select Checkbox    id=orderId_${nameId}
    Sleep    ${selectSleep}
    Checkbox Should Be Selected    id=orderId_${nameId}

select user open or stop
    [Arguments]    ${status}
    [Documentation]    在创建或者编辑用户时选择用户是否开通
    ...    参数：用户开通状态(是，否)
    ${num}    Set Variable If    '${status}'=='是'    1    '${status}'=='否'    0
    Select Radio Button    ${tuser_addable_nameattrbute}    ${num}
    Sleep    ${selectSleep}
    Radio Button Should Be Set To    ${tuser_addable_nameattrbute}    ${num}

select user publisher or not
    [Arguments]    ${status}
    [Documentation]    在创建或者编辑用户时选择用户是否为发布者
    ...    参数：用户发布者状态(是，否)
    ${num}    Set Variable If    '${status}'=='是'    1    '${status}'=='否'    0
    Select Radio Button    ${tuser_addpub_nameattrbute}    ${num}
    Sleep    ${selectSleep}
    Radio Button Should Be Set To    ${tuser_addpub_nameattrbute}    ${num}

select usergroup on the user manage UI
    [Arguments]    ${userGroupName}
    [Documentation]    在用户管理界面选择用户组
    ...    参数：用户组名称
    Unselect Frame
    Select Frame    ${tuser_iframetab_ID}
    select name in the tree structure    ${userGroupName}    account_groups    ${userGroupUI['initName']}
    Select Frame    ${tuser_iframmgr_ID}

verify assign template UI info
    [Documentation]    分配模板界面信息验证
    verify element text    ${tuser_assigntmpl_warn}    ${userUI['warn']}
    verify element text    ${tuser_assigntmpl_search_button}    ${userUI['button10']}
    verify element text    ${tuser_assigntmpl_label}    ${userUI['label3']}
    : FOR    ${txt}    IN    @{userUI['tableH2']}
    \    Run Keyword And Continue On Failure    Table Header Should Contain    ${public_table_ID}    ${txt}
    verify element text    ${tuser_assigntmpl_title}    ${userUI['title17']}
    Unselect Frame
    verify element text    ${layui_title_ID}    ${userUI['title17']}

verify create user UI info
    [Documentation]    新建用户界面信息验证
    verify same element text by UI    ${tuser_add_label}    @{userUI['labelL1']}
    verify input box character limit    ${tuser_addname_ID}    ${userUI['len2']}
    verify input box character limit    ${tuser_addrealname_ID}    ${userUI['len2']}
    verify input box character limit    ${tuser_addpwd_ID}    ${userUI['len3']}
    verify element value attribute value    ${tuser_addpwd_ID}    ${userUI['PwdD']}
    verify input box character limit    ${tuser_addemail_ID}    ${userUI['len3']}
    verify element text    ${tuser_addgrp_ID}    ${userUI['groupD']}
    verify element title attribute value    ${tuser_addtime_ID}    ${userUI['title16']}
    verify defualt expiry date
    verify same element text by UI    ${tuser_radio_lable}    @{userUI['pub']}    @{userUI['userStatus']}
    verify lay UI title info    ${userUI['title13']}

verify defualt expiry date
    [Documentation]    新建或者编辑界面上验证默认的有效期时间
    ...    参数：待验证的时间
    ${y}    ${m}    ${d}   Get Time    year month day    Now + 180 day   
    ${source}    Get Source
    Should Contain    ${source}    ${y}-${m}-${d}    

verify edit user UI info
    [Arguments]    ${userName}    ${email}
    [Documentation]    编辑用户界面信息验证，除了用户名和电子邮件其他为默认值
    ...    参数：1.用户名；2.电子邮件
    verify same element text by UI    ${tuser_add_label}    @{userUI['labelL2']}
    verify input box character limit    ${tuser_addname_ID}    ${userUI['len2']}
    verify element value attribute value    ${tuser_addname_ID}    ${userName}
    verify input box character limit    ${tuser_addrealname_ID}    ${userUI['len2']}
    verify element value attribute value    ${tuser_addrealname_ID}    ${userTD['realD']}
    verify input box character limit    ${tuser_addpwd_ID}    ${userUI['len3']}
    verify element value attribute value    ${tuser_addpwd_ID}    ${userUI['PwdD']}
    verify input box character limit    ${tuser_addemail_ID}    ${userUI['len3']}
    verify element value attribute value    ${tuser_addemail_ID}    ${email}
    verify element text    ${tuser_addgrp_ID}    ${userUI['groupD']}
    verify element text    ${tuser_userDir_input}    ${userUI['poolPath']}${userName}
    ${diskTxt}    Get Text    ${tuser_diskEcrypt_input}
    Should Not Be Empty    ${diskTxt}    msg=磁盘加密输入框为空
    verify element title attribute value    ${tuser_addtime_ID}    ${userUI['title16']}
    verify defualt expiry date
    verify same element text by UI    ${tuser_radio_lable}    ${userUI['pub'][0]}    @{userUI['userStatus']}
    verify lay UI title info    ${userUI['title14']}

verify see VM UI info
    [Arguments]    ${userName}
    [Documentation]    用户查看虚拟机界面信息验证
    ...    参数：待查看虚拟机的用户名
    : FOR    ${txt}    IN    @{seeVmUI['tableH']}
    \    Run Keyword And Continue On Failure    Table Header Should Contain    ${tuser_seevm_table_ID}    ${txt}
    verify element text    ${tuser_seevm_delet_button_ID}    ${seeVmUI['button1']}
    verify element value attribute value    ${tuser_seevm_rollback_button}    ${seeVmUI['button2']}
    verify element value attribute value    ${tuser_seevm_start_button_ID}    ${seeVmUI['button3']}
    verify element value attribute value    ${tuser_seevm_shutdown_button_ID}    ${seeVmUI['button4']}
    verify element value attribute value    ${tuser_seevm_restart_button_ID}    ${seeVmUI['button5']}
    verify element value attribute value    ${tuser_seevm_update_button_ID}    ${seeVmUI['button6']}
    verify element title attribute value    ${tuser_seevm_delet_button_ID}    ${seeVmUI['title2']}
    verify element title attribute value    ${tuser_seevm_rollback_button}    ${seeVmUI['title3']}
    verify element title attribute value    ${tuser_seevm_start_button_ID}    ${seeVmUI['title4']}
    verify element title attribute value    ${tuser_seevm_shutdown_button_ID}    ${seeVmUI['title5']}
    verify element title attribute value    ${tuser_seevm_restart_button_ID}    ${seeVmUI['title6']}
    verify element title attribute value    ${tuser_seevm_update_button_ID}    ${seeVmUI['title7']}
    open the search UI
    verify same element text by UI    ${public_search_label_ID}    @{seeVmUI['labelL']}
    verify element value attribute value    ${tuser_seevm_search_userinput_ID}    ${userName}
    verify element text    ${tuser_seevm_search_clear_button}    ${seeVmUI['button7']}
    verify element title attribute value    ${search_button_ID}    ${seeVmUI['title8']}
    ${vmStatus}    Get List Items    ${tuser_seevm_search_vmStatus}
    Lists Should Be Equal    ${vmStatus}    ${seeVmUI['selectL']}    msg=待测试虚拟机状态选择值与实际不相等
    verify element text    ${public_manage_title_ID}    ${seeVmUI['title1']}
    Unselect Frame
    verify element text    ${tuser_seevm_tab}    ${seeVmUI['title1']}

verify see template UI info
    [Arguments]    ${userName}    ${tempName}
    [Documentation]    查看模板界面信息验证
    ...    参数：用户名
    ${nameId}    get user ID in database    ${userName}
    verify element title attribute value    //a[contains(@onclick,'see_virtual(${nameId})')]/..    ${seeTempUI['title1']}
    click template number on user manage UI    ${userName}
    verify element title attribute value    ${tuser_seetmpl_deletes_button}    ${seeTempUI['title6']}
    verify element text    ${tuser_seetmpl_deletes_button}    ${seeTempUI['button1']}
    verify element title attribute value    //a[contains(@href,'seeUserTmplateDetail')]    ${seeTempUI['title10']}
    verify element title attribute value    //a[contains(@href,'del_virtual')]    ${seeTempUI['title7']}
    verify element title attribute value    //a[contains(@href,'set_auto')]    ${seeTempUI['title8']}
    click set auto button on see template UI    ${tempName}
    click confirm box confirm button
    Select Frame    ${tuser_seetmpl_iframe_ID}
    verify element title attribute value    //i[contains(@class,'fa-undo')]/..    ${seeTempUI['title9']}
    : FOR    ${txt}    IN    @{seeTempUI['tableH']}
    \    Run Keyword And Continue On Failure    Table Header Should Contain    ${public_table_ID}    ${txt}
    verify element text    ${public_manage_title_ID}    ${userTD['realD']}${seeTempUI['title2']}
    verify element text    ${tuser_seetmpl_user&group_info}    ${seeTempUI['title4']}${userName}; ${seeTempUI['title5']}${userUI['groupD']}
    ${tempNum}    Get Length    ${userTD['tempName']}
    verify table records current page    ${tempNum}
    Unselect Frame
    verify element text    ${tuser_seetmpl_tab_ID}    ${seeTempUI['title3']}

verify template detail UI info of see template
    [Arguments]    ${tempName}    ${cardNum}=1
    [Documentation]    查看模板界面模板详细信息验证
    ...    参数:1.模板的名称;2.网卡个数(默认为1)
    ${cardInt}    Convert To Integer    ${cardNum}
    ${cardList}    Create List    @{EMPTY}
    : FOR    ${i}    IN RANGE    ${cardInt}
    \    Append To List    ${cardList}    ${tempUI['netCardNameL'][${i}]}    @{tempUI['netlabel']}
    ${lableList}    Create List    @{tempUI['labelL5'][:-2]}    @{cardList}    @{tempUI['labelL5'][-2:]}
    ${valueList}    Create List    ${tempName}    ${vhdNameP}    @{seeTempUI['valueL']}
    verify same element text by UI    ${tuser_seetmpl_detail_label}    @{lableList}
    verify same element text by UI    ${tuser_seetmpl_detail_value}    @{valueList}
    verify lay UI title info    ${seeTempUI['title3']}    ${seeTempUI['title11']}    False

verify user detail UI info
    [Arguments]    ${userName}    ${group}=init
    [Documentation]    用户详细详情界面信息验证
    verify same element text by UI    ${tuser_userdetail_label}    @{userUI['labelL4']}
    ${key}    get return value of the database query    SELECT user_key FROM account_users WHERE username='${userName}';
    ${y}    ${m}    ${d}    Get Time    year,month,day    NOW + ${expiryTime} day
    ${groupNew}    Set Variable If    '${group}'=='init'    ${userUI['groupD']}    '${group}'!='init'    ${group}
    verify same element text by UI    ${tuser_userdetail_value}    ${userName}    ${userTD['realD']}    ${userUI['PwdD']}    ${userTD['emailR']}    ${groupNew}
    ...    ${key}    ${userUI['diskSizeD']}    ${userUI['poolPath']}${userName}    ${y}-${m}-${d}    ${userUI['pub'][0]}    ${userUI['userStatus'][1]}
    verify lay UI title info    ${userUI['title18']}    status=False

verify user email error msg
    [Arguments]    ${errMsg}
    [Documentation]    新建或者编辑用户界面输入邮件错误时提示信息验证
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${tuser_addemail_error_ID}    error=错误提示信息不可见
    verify element text    ${tuser_addemail_error_ID}    ${errMsg}

verify user email in database
    [Arguments]    ${userName}    ${userEmail}
    [Documentation]    在数据库里检查vtop用户email信息
    ...    参数：1.用户名，2.电子邮件信息
    ${emailData}    get return value of the database query    SELECT email FROM account_users WHERE username='${userName}';
    Should Be Equal As Strings    ${userEmail}    ${emailData}    msg=电子邮件${userEmail}与数据库中的值不一致

verify user expired_date in database
    [Arguments]    ${userName}    ${expired_data}
    [Documentation]    在数据库里检查vtop用户有效期时间
    ...    参数：1.用户名，2.有效时间
    ${time}    get return value of the database query    SELECT expired_date FROM account_users WHERE username='${userName}';
    Should Be Equal As Strings    ${expired_data}    ${time}    msg=有效期${expired_data}与数据库中的值不一致

verify user manage UI other info
    [Documentation]    用户管理界面除去表格的其他信息验证
    Run Keyword And Continue On Failure    verify element text    ${tuser_addbth_ID}    ${userUI['button1']}
    Run Keyword And Continue On Failure    verify element title attribute value    ${tuser_addbth_ID}    ${userUI['title2']}
    Run Keyword And Continue On Failure    verify element text    ${tuser_assign_template_button}    ${userUI['button2']}
    Run Keyword And Continue On Failure    verify element title attribute value    ${tuser_assign_template_button}    ${userUI['title3']}
    Run Keyword And Continue On Failure    verify element text    ${tuser_basis_button_ID}    ${userUI['button3']}
    click Basics button
    Run Keyword And Continue On Failure    verify element text    ${tuser_basis_policy_ID}    ${userUI['button4']}
    Run Keyword And Continue On Failure    verify element title attribute value    ${tuser_basis_policy_ID}    ${userUI['title7']}
    Run Keyword And Continue On Failure    verify element text    ${tuser_basis_resetpwd_ID}    ${userUI['button5']}
    Run Keyword And Continue On Failure    verify element title attribute value    ${tuser_basis_resetpwd_ID}    ${userUI['title8']}
    Run Keyword And Continue On Failure    verify element text    ${tuser_basis_openuser_ID}    ${userUI['button6']}
    Run Keyword And Continue On Failure    verify element title attribute value    ${tuser_basis_openuser_ID}    ${userUI['title9']}
    Run Keyword And Continue On Failure    verify element text    ${tuser_basis_stopuser_ID}    ${userUI['button7']}
    Run Keyword And Continue On Failure    verify element title attribute value    ${tuser_basis_stopuser_ID}    ${userUI['title10']}
    Run Keyword And Continue On Failure    verify element text    ${tuser_basis_changegroup_ID}    ${userUI['button8']}
    Run Keyword And Continue On Failure    verify element title attribute value    ${tuser_basis_changegroup_ID}    ${userUI['title11']}
    Run Keyword And Continue On Failure    verify element text    ${tuser_basis_import_ID}    ${userUI['button9']}
    Run Keyword And Continue On Failure    verify element title attribute value    ${tuser_basis_import_ID}    ${userUI['title12']}
    open the search UI
    Run Keyword And Continue On Failure    verify search label info on the UI    ${userUI['srcLabel']}
    Run Keyword And Continue On Failure    verify input box character limit    ${tuser_search_input_ID}    ${userUI['len1']}
    Run Keyword And Continue On Failure    verify element text    ${public_manage_title_ID}    ${userUI['title1']}
    Unselect Frame
    verify element text    ${tuser_tab_ID}    ${userUI['title15']}

verify user manage UI table info
    [Documentation]    用户管理界面上表格信息验证
    : FOR    ${tex}    IN    @{userUI['tableH']}
    \    Run Keyword And Continue On Failure    Table Header Should Contain    ${public_table_ID}    ${tex}
    Run Keyword And Continue On Failure    verify element title attribute value    //a[contains(@onclick,'edit_user')]    ${userUI['title4']}
    Run Keyword And Continue On Failure    verify element title attribute value    //a[contains(@onclick,'del_user')]    ${userUI['title5']}
    Run Keyword And Continue On Failure    verify element title attribute value    //a[contains(@onclick,'see_computer')]    ${userUI['title6']}

verify user password error msg
    [Arguments]    ${errMsg}
    [Documentation]    新建或者编辑用户界面密码输入异常时验证错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${tuser_addpwd_error_ID}    error=密码错误提示信息不可见
    verify element text    ${tuser_addpwd_error_ID}    ${errMsg}

verify user password in database
    [Arguments]    ${userName}    ${userPwd}
    [Documentation]    在数据库里检查vtop用户密码信息
    ...    参数：1.用户名，2.用户的密码
    ${password}    get return value of the database query    SELECT password FROM account_users WHERE username='${userName}';
    Should Be Equal As Strings    ${userPwd}    ${password}    msg=密码${userPwd}与数据库中的值不一致

verify user publisher info on the UI
    [Arguments]    ${userName}    ${status}
    [Documentation]    用户管理界面上验证某用户是否为发布者
    ...    参数：1.用户名，2.是否为发布者(不是发布者表现形式为"-")
    into user management UI
    ${info}    Set Variable If    '${status}'=='否'    ${noMessage}    '${status}'=='是'    ${status}
    ${nameId}    get user ID in database    ${userName}
    verify element text    //tr[@id='tr_${nameId}']/td[5]    ${info}

verify user realname error msg
    [Arguments]    ${errMsg}
    [Documentation]    新建或者编辑用户界面当真实姓名输入异常时验证错误提示信息
    ...    参数：需要验证的错误信息
    Wait Until Element Is Visible    ${tuser_realname_error_ID}    error=没有出现错误提示信息
    verify element text    ${tuser_realname_error_ID}    ${errMsg}

verify user realname in database
    [Arguments]    ${userName}    ${realName}
    [Documentation]    在数据库里检查vTop用户真实姓名信息
    ...    参数：1.用户名，2.用户的真实姓名
    ${Results}    get return value of the database query    SELECT real_name FROM account_users WHERE username='${userName}';
    Should Be Equal As Strings    ${realName}    ${Results}    msg=真实姓名${realName}与数据库中的值不一致

verify user realname info on the UI
    [Arguments]    ${userName}    ${realName}
    [Documentation]    用户管理界面上某用户的真实姓名信息验证
    ...    参数：1.用户名，2.用户的真实姓名
    into user management UI
    ${nameId}    get user ID in database    ${userName}
    verify element text    //tr[@id='tr_${nameId}']/td[3]    ${realName}

verify user status on the UI
    [Arguments]    ${userName}    ${status}=expired
    [Documentation]    在用户管理界面检查用户开通状态
    ...    参数：1.用户名；2.用户的状态(默认是已过期)
    into user management UI
    ${nameId}    get user ID in database    ${userName}
    ${verStr}    Set Variable If    '${status}'=='${userUI['userStatus'][0]}'    ${userName}    '${status}'=='${userUI['userStatus'][1]}'    ${userName} ${userUI['stop']}    '${status}'=='expired'
    ...    ${userName} ${userUI['expired']}
    verify element text    //a[@onclick='showUserDetail(${nameId})']/..    ${verStr}

verify user template number info on the UI
    [Arguments]    ${userName}    ${templateNumber}
    [Documentation]    用户管理界面上某用户的模板数量验证
    ...    1.用户名，2.用户的模板数量
    into user management UI
    ${nameId}    get user ID in database    ${userName}
    verify element text    //tr[@id='tr_${nameId}']/td[6]    ${templateNumber}

verify user userPolicy info on the UI
    [Arguments]    ${userName}    ${userPolicy}    ${policyDetail}
    [Documentation]    用户管理界面上某用户的用户策略信息验证
    ...    参数：1.用户名，2.用户策略名称(值为None表示没有策略)，
    ...    3.用户策略的具体信息(值为None表示没有策略)
    into user management UI
    ${nameId}    get user ID in database    ${userName}
    Run Keyword If    '${userPolicy}'=='None'    verify element text    //tr[@id='tr_${nameId}']/td[7]    ${EMPTY}
    Run Keyword If    '${userPolicy}'!='None'    verify element text    //tr[@id='tr_${nameId}']/td[7]    ${userPolicy}
    Run Keyword If    '${policyDetail}'!='None'    verify element title attribute value    //tr[@id='tr_${nameId}']/td[7]    ${policyDetail}

verify user usergroup on the UI
    [Arguments]    ${userName}    ${userGroup}=初始用户组
    [Documentation]    验证用户管理界面上所属用户组信息
    ...    参数：1.用户名称；2.用户组名称(默认值:初始用户组)
    into user management UI
    ${nameId}    get user ID in database    ${userName}
    verify element text    //tr[@id='tr_${nameId}']/td[4]    ${userGroup}

verify user username error msg
    [Arguments]    ${errMsg}
    [Documentation]    新建或者编辑用户界面用户名输入错误时提示信息验证
    ...    参数：具体的错误提示信息
    Wait Until Element Is Visible    ${tuser_username_error_ID}    error=用户名错误时未出现提示信息
    verify element text    ${tuser_username_error_ID}    ${errMsg}

verify user username on the UI
    [Arguments]    ${userName}
    [Documentation]    用户管理界面验证某用户的用户名
    ...    参数：用户名
    into user management UI
    ${nameId}    get user ID in database    ${userName}
    verify element text    //a[@onclick='showUserDetail(${nameId})']    ${userName}
