*** Settings ***
Resource          ../../ElementLocators/ResourceElementID.robot
Resource          ../PublicKeywords.robot
Resource          ../UserManage/UserKeywords.robot
Resource          ../PolicyManage/DevicePolicyKeywords.robot
Resource          ActiveDirectoryKeywords.robot
Resource          VlanKeywords.robot
Resource          ../SafetyManage/NetworkKeyKeywords.robot
Resource          VhdKeywords.robot
Resource          NetworkKeywords.robot
Resource          ../PolicyManage/DevicePolicyKeywords.robot
Variables         ../../TestData/ResourceTestData.py

*** Keywords ***
clear env for create template
    [Documentation]    清空创建模板的测试环境:1.删除镜像；2.关闭浏览器
    delete all template by UI
    delete all vhd by UI
    close browser and kill chrome process

delete template assign users
    [Arguments]    ${tempNum}
    [Documentation]    删除某模板分配的用户
    ...    参数：模板名称
    into template manage UI
    select template    ${tempNum}
    click use situation button
    ${len}    get current table record number    ${public_table_ID}
    : FOR    ${i}    IN RANGE    1
    \    Exit For Loop If    '${len}'=='0'
    \    Select Checkbox    ${public_selectall_ID}
    \    click use situation delete button
    \    click confirm box confirm button

clear env for edit template
    [Documentation]    清空测试编辑模板环境：1.删除用户；2.删除模板；3.删除AD域；
    ...    4.删除镜像；5.删除网络；6.删除设备策略；7.删除网络密钥；8.删除VLAN；
    ...    9.关闭浏览器
    delete all user by UI
    delete all template by UI
    delete all ad by UI
    delete all vhd by UI
    delete all network by UI
    delete all device policy by UI
    delete all network key by UI
    delete all vlan by UI
    close browser and kill chrome process

click assign user search button
    [Documentation]    点击模板管理分配用户界面查询按钮
    Wait Until Element Is Visible    ${tmpl_assignUser_search_button}
    Click Element    ${tmpl_assignUser_search_button}
    Sleep    ${clickSleep}

click assign users button
    [Arguments]    ${status}=True
    [Documentation]    点击分配用户按钮
    ...    参数：是否有layer弹窗(默认有)
    Click Element    ${tmpl_assginUser_button_ID}
    : FOR    ${i}    IN RANGE    1
    \    Exit For Loop If    '${status}'!='True'
    \    Unselect Frame
    \    Wait Until Element Is Visible    ${layui_title_ID}
    \    Select Frame    ${layui_iframe_ID}
    \    Wait Until Element Is Visible    ${tmpl_assignUser_userinput_ID}

click assign users clear button
    [Documentation]    点击分配界面清空按钮
    Wait Until Element Is Visible    ${tmpl_assignUser_clear_button}
    Click Element    ${tmpl_assignUser_clear_button}
    Sleep    ${clickSleep}

click create template button
    [Documentation]    点击创建模板按钮
    Click Button    ${tmpl_add_button_ID}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${tmpl_add1_name_ID}

click delete template buton
    [Arguments]    ${tmpName}
    [Documentation]    点击删除模板按钮
    ...    参数：模板名称
    ${nameId}    get template ID by database    ${tmpName}
    Click Element    //a[contains(@onclick,'deleteTmpl(${nameId})')]

click edit template button
    [Arguments]    ${tmpName}
    [Documentation]    点击编辑模板按钮
    ...    参数：模板名称
    ${nameId}    get template ID by database    ${tmpName}
    Click Element    //a[contains(@onclick,'editTmpl(${nameId})')]
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${tmpl_add1_name_ID}

click next step
    [Arguments]    ${stepNum}    ${status}=True
    [Documentation]    在创建模板界面点击下一步
    ...    参数：1.目前在创建的第几步(1,2,3,4,5)；2.点击按钮后是否报错(默认不报错)
    ${stepNum}    Convert To Integer    ${stepNum}
    Wait Until Element Is Visible    id=step${stepNum}
    Wait Until Element Is Visible    ${tmpl_add_nextbtn_ID}
    Click Button    ${tmpl_add_nextbtn_ID}
    : FOR    ${i}    IN RANGE    1
    \    Exit For Loop If    '${status}'!='True'
    \    Run Keyword If    '${stepNum}'<'5'    Wait Until Element Is Visible    id=step${stepNum+1}

click previous step
    [Arguments]    ${stepNum}
    [Documentation]    在创建模板界面点击上一步
    ...    参数：目前在创建的第几步(1,2,3,4,5)
    ${stepNum}    Convert To Integer    ${stepNum}
    Wait Until Element Is Visible    id=step${stepNum}
    Wait Until Element Is Visible    ${tmpl_add_prevbtn_ID}
    Click Button    ${tmpl_add_prevbtn_ID}
    Run Keyword If    '${stepNum}'>'1'    Wait Until Element Is Visible    id=step${stepNum-1}

click template name on template manage UI
    [Arguments]    ${tempName}
    [Documentation]    在模板管理界面点击模板名称
    ...    参数：模板名称
    ${nameId}    get template ID by database    ${tempName}
    Click Element    //a[contains(@href,'seeDetail(${nameId})')]
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${layui_title2_ID}

click use situation button
    [Arguments]    ${status}=True
    [Documentation]    模板管理界面点击使用情况按钮
    ...    参数：是否有layer弹窗(默认有)
    Click Element    ${tmpl_use_button_ID}
    : FOR    ${i}    IN RANGE    1
    \    Exit For Loop If    '${status}'!='True'
    \    Unselect Frame
    \    Wait Until Element Is Visible    ${tmpl_use_UI_ID}
    \    Select Frame    ${tmpl_use_iframe_ID}
    \    Wait Until Element Is Visible    ${tmpl_use_delete_button}

click use situation cancelAuto button
    [Documentation]    点击模板管理使用情况界面取消开关机联动
    Click Element    ${tmpl_use_celAuto_button}

click use situation delete button
    [Documentation]    点击模板管理使用情况界面删除按钮
    Click Element    ${tmpl_use_delete_button}

click use situation setAuto button
    [Documentation]    点击模板管理使用情况界面设置开关机联动
    Click Element    ${tmpl_use_setAuto_button}

create right template by UI
    [Arguments]    ${tempName}    ${ad}=None    ${vhdName}=default    ${diskEncrypt}=None    ${vlan}=None    ${network}=None
    ...    ${devicePolicy}=default    ${netKey}=None    ${cpu}=default    ${diskS}=default    ${memory}=default
    [Documentation]    创建模板
    into template manage UI
    click create template button
    ${vhd}    Set Variable If    '${vhdName}'=='default'    ${tempTD['vhdD']}    '${vhdName}'!='default'    ${vhdName}
    select VHD for template    ${vhd}
    input template name    ${tempName}
    Run Keyword If    '${ad}'!='None'    select ad for template    ${ad}
    click next step    1
    Run Keyword If    '${cpu}'!='default'    select cpu number for template    ${cpu}
    Run Keyword If    '${diskS}'!='default'    input disk size    ${diskS}
    Run Keyword If    '${memory}'!='default'    input memory size    ${memory}
    Run Keyword If    '${diskEncrypt}'=='是'    select whether encrypt for disk    ${diskEncrypt}
    click next step    2
    Run Keyword If    '${network}'!='None'    select bridge network for template    ${network}
    Run Keyword If    '${vlan}'!='None'    select vlan for template    ${vlan}
    Run Keyword If    '${netKey}'!='None'    select network key for template    ${netKey}
    click next step    3
    Run Keyword If    '${devicePolicy}'!='default'    select device policy for template    ${devicePolicy}
    click next step    4
    click next step    5
    verify template name on the UI    ${tempName}

delete all template by UI
    [Documentation]    在模板管理界面删除所有的模板
    into template manage UI
    ${len}    get rows of database table    SELECT id FROM template_info;
    : FOR    ${i}    IN RANGE    ${len}
    \    ${element}    Get Webelement    //a[contains(@onclick,'deleteTmpl')]
    \    Wait Until Element Is Enabled    ${element}
    \    Click Element    ${element}
    \    click confirm box confirm button
    \    click confirm box cancel button
    \    Select Frame    ${tmpl_iframetab_ID}

disable network key for template
    [Arguments]    ${netCardNum}=1
    [Documentation]    为模板禁用网卡加密
    ...    参数：第几张网卡(默认为1)
    Unselect Checkbox    id=netkey_type_${netCardNum}
    Wait Until Element Is Not Visible    //p[@class='netkeylist_${netCardNum}']

disable the network for template
    [Arguments]    ${netCardNum}=1
    [Documentation]    为模板禁用网络
    ...    参数：第几张网卡(默认为1)
    Click Element    //a[@href='#netcard${netCardNum}']
    Wait Until Element Is Visible    //*[@id='status${netCardNum}']/..
    Unselect Checkbox    id=status${netCardNum}
    Wait Until Element Is Not Visible    //div[@class='networkconfig_${netCardNum}']

disable vlan for template
    [Arguments]    ${netCardNum}=1
    [Documentation]    为模板禁用VLAN
    ...    参数：第几张网卡(默认为1)
    Unselect Checkbox    id=vlan_type_${netCardNum}
    Wait Until Element Is Not Visible    //p[@class='vlanlist_${netCardNum}']

enable the network for template
    [Arguments]    ${netCardNum}=1    ${status}=False
    [Documentation]    为模板启用网络
    ...    参数：1.第几张网卡(默认为1)；2.是否同时启用参数1之前的网卡(默认不启用)
    : FOR    ${i}    IN RANGE    1
    \    Exit For Loop If    '${status}'!='False'
    \    Click Element    //a[@href='#netcard${netCardNum}']
    \    Wait Until Element Is Visible    //*[@id='status${netCardNum}']/..
    \    Run Keyword If    '${netCardNum}'!='1'    Select Checkbox    id=status${netCardNum}
    \    Wait Until Element Is Visible    //div[@class='networkconfig_${netCardNum}']
    : FOR    ${card}    IN RANGE    ${netCardNum}
    \    Exit For Loop If    '${status}'=='False'
    \    Click Element    //a[@href='#netcard${card+1}']
    \    Wait Until Element Is Visible    //*[@id='status${card+1}']/..
    \    Run Keyword If    '${card}'!='0'    Select Checkbox    id=status${card+1}
    \    Wait Until Element Is Visible    //div[@class='networkconfig_${card+1}']

get template ID by database
    [Arguments]    ${template_name}
    [Documentation]    通过数据库中获取template的ID
    ...    参数：模板名称
    ${tmpl_name_id}    get return value of the database query    SELECT id FROM template_info WHERE NAME='${template_name}';
    [Return]    ${tmpl_name_id}

get verify the network text list
    [Arguments]    ${netCardNum}    ${netKey}=False    ${vlan}=False
    [Documentation]    获取网卡验证信息列表(创建模板概览界面上)
    ...    参数：1.第几张网卡(默认为1)；2.是否网络加密(默认否)；3.是否有vlan(默认否)
    @{netList}    Create List    网卡${netCardNum}    @{tempUI['netlabel']}
    Run Keyword If    '${netKey}'=='True'    Set List Value    ${netList}    1    网络密钥
    Run Keyword If    '${vlan}'=='True'    Set List Value    ${netList}    1    VLAN
    [Return]    @{netList}

input assgin user name
    [Arguments]    ${userName}
    [Documentation]    模板管理分配用户界面输入用户名
    ...    参数：用户名
    Clear Element Text    ${tmpl_assignUser_userinput_ID}
    Input Text    ${tmpl_assignUser_userinput_ID}    ${userName}
    Sleep    ${inputSleep}

input custom praefixum
    [Arguments]    ${name}
    [Documentation]    输入自定义前缀
    ...    参数：自定义前缀名称
    Clear Element Text    ${tmpl_add1_custom_input_ID}
    Input Text    ${tmpl_add1_custom_input_ID}    ${name}
    Sleep    ${inputSleep}

input disk size
    [Arguments]    ${disk_size}
    [Documentation]    输入磁盘大小
    ...    参数：磁盘大小数值
    Clear Element Text    ${tmpl_add2_disk_input_ID}
    Input Text    ${tmpl_add2_disk_input_ID}    ${disk_size}
    Sleep    ${inputSleep}

input memory size
    [Arguments]    ${memory_size}
    [Documentation]    输入内存大小
    ...    参数：内存大小
    Clear Element Text    ${tmpl_add2_memory_input_ID}
    Input Text    ${tmpl_add2_memory_input_ID}    ${memory_size}
    Sleep    ${inputSleep}

input search template name
    [Arguments]    ${tempName}
    [Documentation]    输入搜索模板的名称
    ...    参数：模板名称
    open the search UI
    Clear Element Text    ${tmpl_search_input_ID}
    Input Text    ${tmpl_search_input_ID}    ${tempName}
    Sleep    ${inputSleep}

input template name
    [Arguments]    ${tmpl_name}
    [Documentation]    输入模板名称
    ...    参数：模板名称
    Clear Element Text    ${tmpl_add1_name_ID}
    Input Text    ${tmpl_add1_name_ID}    ${tmpl_name}

into template manage UI
    [Documentation]    进入到模板管理界面
    refresh page
    Wait Until Element Is Enabled    ${resource_manage_ID}
    Click Element    ${resource_manage_ID}
    Wait Until Element Is Visible    ${tmpl_menu_ID}
    Click Element    ${tmpl_menu_ID}
    Wait Until Element Is Visible    ${tmpl_UI_ID}
    Select Frame    ${tmpl_iframetab_ID}
    Wait Until Element Is Visible    ${tmpl_add_button_ID}

prepare env for create template
    [Documentation]    为测试创建模板准备环境：1.admin用户登录；2.创建镜像
    login by admin
    create right vhd by UI    ${tempTD['vhdD']}

prepare env for edit template
    [Documentation]    为测试编辑模板准备环境：1.admin用户登录；2.创建镜像；
    ...    3.创建AD域；4.创建网络；5.创建设备策略；6.创建模板；7.模板分配给用户
    login by admin
    create right usergroup by UI    ${defaultNameTD}58
    create right vhd by UI    ${tempTD['vhdD']}
    create right user by UI    ${tempTD['userPub']}    pub=True
    : FOR    ${name}    IN    @{tempTD['userR']}
    \    create right user by UI    ${name}    group=${defaultNameTD}58
    create right ad    ${tempTD['adD']}
    create right network by UI    ${tempTD['netNameR']}
    create right device policy    ${tempTD['policyR']}
    create right template by UI    ${tempTD['nameD']}
    create right template by UI    ${tempTD['nameD1']}
    create right template by UI    ${tempTD['editD']}
    create right template by UI    ${tempTD['del']}
    create right template by UI    ${defaultNameTD}6    diskEncrypt=${tempUI['diskEncry'][1]}
    : FOR    ${name}    IN    @{tempTD['srcName']}
    \    create right template by UI    ${name}
    assign users of template    ${tempTD['nameD1']}

assign users of template
    [Arguments]    ${tempName}    ${userName}=None
    [Documentation]    把模板分配给用户
    ...    参数：1.模板名称；2.用户名(默认所有用户)
    into template manage UI
    select template    ${tempName}
    click assign users button
    Run Keyword If    '${userName}'=='None'    select table checkbox on UI
    Run Keyword If    '${userName}'!='None'    select user for template    ${userName}
    click save button    True
    verify lobibox info

select VHD for template
    [Arguments]    ${vhd_name}
    [Documentation]    根据镜像名字选择相应的镜像
    ...    参数：镜像名称
    Select From List By Label    ${tmpl_add1_select_vhd_ID}    ${vhd_name}
    Sleep    ${selectSleep}
    Wait Until Element Is Visible    //button[@title='${vhd_name}']

select ad for template
    [Arguments]    ${adName}
    [Documentation]    创建模板界面选择AD域
    ...    参数：AD域名称
    ${adId}    get ad id by database    ${adName}
    ${nameIdStr}    Convert To String    ${adId}
    Select Radio Button    ${tmpl_add1_AD_name}    ${adId}
    Sleep    ${selectSleep}

select audit for template
    [Arguments]    ${auditName}
    [Documentation]    为模板选择审计类型
    ...    参数：审计类型名称
    Click Element    //input[@data-name='${auditName}']/..
    Sleep    ${clickSleep}

select bridge network for template
    [Arguments]    ${networkName}    ${netCardNum}=1
    [Documentation]    为模板选择桥接网络
    ...    参数：1.网络名称；2.第几张网卡(默认为1)
    ${nameId}    get network id by database    ${networkName}
    Execute Javascript    window.scrollTo(0,10000000)
    ${nameId}    Convert To String    ${nameId}
    Select Radio Button    tmpcard${netCardNum}.network_id    ${nameId}
    Sleep    ${selectSleep}
    Radio Button Should Be Set To    tmpcard${netCardNum}.network_id    ${nameId}

select connection method for template
    [Arguments]    ${method}    ${netCardNum}=1
    [Documentation]    为模板选择连接方式
    ...    参数：1.连接方式；2.第几张网卡(默认为1)
    Click Element    //*[@name='tmpcard${netCardNum}.netcard_type' and @value='${method}']
    Sleep    ${selectSleep}

select cpu number for template
    [Arguments]    ${cpu_number}
    [Documentation]    选择cpu数量
    ...    参数：cpu数量
    ${cpu_number}    Set Variable If    '${cpu_number}'=='自适应'    999    '${cpu_number}'!='自适应'    ${cpu_number}
    Select Radio Button    ${tmpl_add2_cpu_nameattribute}    ${cpu_number}
    Sleep    ${selectSleep}
    Radio Button Should Be Set To    ${tmpl_add2_cpu_nameattribute}    ${cpu_number}

select device policy for template
    [Arguments]    ${policyName}
    [Documentation]    在创建模板界面选择设备策略
    ...    参数：设备策略名称
    ${nameId}    get device policy ID by database    ${policyName}
    ${nameIdStr}    Convert To String    ${nameId}
    Select Radio Button    ${tmpl_add4_policy_name}    ${nameId}
    Sleep    ${selectSleep}
    Radio Button Should Be Set To    ${tmpl_add4_policy_name}    ${nameIdStr}

select name rule for template
    [Arguments]    ${name_rule}
    [Documentation]    在创建模板界面选择命名规则
    ...    参数：命名规则
    Select From List By Label    ${tmpl_add1_select_nameRule_ID}    ${name_rule}
    Sleep    ${selectSleep}
    ${labelName}    Get Selected List Label    ${tmpl_add1_select_nameRule_ID}
    ${labelName}    Strip String    ${labelName}
    Should Be Equal As Strings    ${labelName}    ${name_rule}

verify tempalte stubdom error info
    [Arguments]    ${errMsg}
    [Documentation]    验证串并口错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${tmpl_add2_stubdom_error}
    verify element text    ${tmpl_add2_stubdom_error}    ${errMsg}

click stubdom clear button
    [Documentation]    点击串并口中清空按钮
    Wait Until Element Is Visible    ${tmpl_add2_stubdom_clear}
    Click Element    ${tmpl_add2_stubdom_clear}
    Sleep    ${clickSleep}

select network key for template
    [Arguments]    ${netKey}    ${netCardNum}=1
    [Documentation]    为模板选择密钥
    ...    参数：1.密钥名称；2.第几张网卡(默认为1)
    Select Checkbox    id=netkey_type_${netCardNum}
    Wait Until Element Is Visible    //p[@class='netkeylist_${netCardNum}']
    ${status}    Run Keyword And Return Status    List Selection Should Be    //*[@name='tmpcard${netCardNum}.netkey_id']    ${netKey}
    : FOR    ${i}    IN RANGE    1
    \    Exit For Loop If    '${netKey}'=='None'
    \    Exit For Loop If    '${status}'=='True'
    \    ${nameId}    get network key id by database    ${netKey}
    \    ${nameId}    Convert To String    ${nameId}
    \    Select From List By Value    //*[@name='tmpcard${netCardNum}.netkey_id']    ${nameId}
    \    Sleep    ${selectSleep}
    \    Element Should Be Visible    //button[@title='${netKey}']

select physical card for template
    [Arguments]    ${phyName}    ${netCardNum}=1
    [Documentation]    为模板选择物理网卡
    ...    参数：1.物理网卡名称；2.第几张网卡(默认为1)
    Select From List By Label    name=tmpcard${netCardNum}.phy_eth    ${phyName}
    Sleep    ${selectSleep}
    List Selection Should Be    name=tmpcard${netCardNum}.phy_eth    ${phyName}

select stubdom for template
    [Arguments]    ${stubdomStatus}
    [Documentation]    为模板选择串并兼容模式
    ...    参数：串并兼容模式
    Click Element    //input[@data-name='${stubdomStatus}']/..
    Sleep    ${selectSleep}

select template
    [Arguments]    ${tempName}
    [Documentation]    模板管理分配用户界面勾选用户
    ...    参数：模板名称
    ${nameId}    get template ID by database    ${tempName}
    Select Checkbox    //input[@value='${nameId}' and @name='orderId']
    Sleep    ${selectSleep}
    Checkbox Should Be Selected    //input[@value='${nameId}' and @name='orderId']

select user for template
    [Arguments]    ${user}
    [Documentation]    选择分配模板的用户
    ...    参数：用户名称
    ${nameId}    get user ID in database    ${user}
    Select Checkbox    id=orderId_${nameId}
    Sleep    ${selectSleep}
    Checkbox Should Be Selected    id=orderId_${nameId}

select vlan for template
    [Arguments]    ${vlanName}    ${netcard}=1
    [Documentation]    为模板选择vlan
    ...    参数：1.vlan名称(None表示不选择网络)；2.第几张网卡(默认为1)
    Select Checkbox    id=vlan_type_${netcard}
    Wait Until Element Is Visible    //p[@class='vlanlist_${netcard}']
    ${txt1}    Get Element Attribute    //*[@name='tmpcard${netcard}.netcard_type' and @value='NAT']@disabled
    ${txt2}    Get Element Attribute    //*[@name='tmpcard${netcard}.netcard_type' and @value='hostonly']@disabled
    Should Be Equal As Strings    ${txt1}    true
    Should Be Equal As Strings    ${txt2}    true
    ${status}    Run Keyword And Return Status    List Selection Should Be    //*[@name='tmpcard${netcard}.vlan_id']    ${vlanName}
    : FOR    ${i}    IN RANGE    1
    \    Exit For Loop If    '${vlanName}'=='None'
    \    Exit For Loop If    '${status}'=='True'
    \    ${nameId}    get vlan name ID by database    ${vlanName}
    \    ${nameId}    Convert To String    ${nameId}
    \    Select From List By Value    //*[@name='tmpcard${netcard}.vlan_id']    ${nameId}
    \    Sleep    ${selectSleep}
    \    List Selection Should Be    //*[@name='tmpcard${netcard}.vlan_id']    ${nameId}

select whether encrypt for disk
    [Arguments]    ${encrypt_status}
    [Documentation]    选择磁盘是否加密
    ...    参数：磁盘是否加密
    ${var}    Set Variable If    '${encrypt_status}'=='是'    1    0
    Select Radio Button    usertmp.encrypt    ${var}
    Comment    Click Element    //input[@data-name='${encrypt_status}']/..
    Sleep    ${clickSleep}

verify assign user UI form info
    [Documentation]    模板管理分配用户界面form信息验证
    verify same element text by UI    ${public_table_head}    ${EMPTY}    @{tempUI['tableH5']}
    verify same element text by UI    ${layui_label_ID}    @{tempUI['labelL3']}
    verify element text    ${tmpl_assignUser_clear_button}    ${tempUI['button7']}
    verify element text    ${tmpl_assignUser_search_button}    ${tempUI['button8']}
    verify element text    ${tmpl_assignUser_warn_ID}    ${tempUI['msg1']}

verify number of template users
    [Arguments]    ${tempName}    ${userNum}
    [Documentation]    验证模板使用者的个数
    ...    参数：1.模板名称；2.用户个数
    into template manage UI
    select template    ${tempName}
    click use situation button
    verify table records current page    ${userNum}

verify create template other info
    [Documentation]    新建模板界面其他信息验证
    verify same element text by UI    ${tmpl_add_stepTitle_ID}    @{tempUI['stepT']}
    verify element text    ${tmpl_add_prevbtn_ID}    ${tempUI['button4']}
    ${status}    Run Keyword And Return Status    Element Should Be Visible    ${tmpl_add5_step5_ID}
    Run Keyword If    '${status}'=='False'    verify element text    ${tmpl_add_nextbtn_ID}    ${tempUI['button5']}
    Run Keyword If    '${status}'=='True'    verify element text    ${tmpl_add_nextbtn_ID}    ${tempUI['button6']}
    Unselect Frame
    verify element text    ${layui_title_ID}    ${tempUI['title2']}
    Select Frame    ${layui_iframe_ID}
    verify element text    ${public_manage_title_ID}    ${tempUI['title2']}

verify create template step1 UI
    [Documentation]    新建模板常规界面信息验证
    verify same element text by UI    ${tmpl_add1_label_ID}    @{tempUI['labelL1']}
    verify same element text by UI    ${tmpl_add1_step1_ID}${public_table_head}    @{tempUI['tableH2']}
    ${selectruleL}    Get List Items    ${tmpl_add1_select_nameRule_ID}
    ${selectruleNewL}    Create List    @{EMPTY}
    : FOR    ${j}    IN    @{selectruleL}
    \    ${j}    Strip String    ${j}
    \    Append To List    ${selectruleNewL}    ${j}
    List Selection Should Be    ${tmpl_add1_select_vhd_ID}    ${tempUI['selectD']}
    Lists Should Be Equal    ${selectruleNewL}    ${tempUI['selectL1']}
    verify input box character limit    ${tmpl_add1_name_ID}    ${tempUI['len1']}

verify create template step2 UI
    [Documentation]    新建模板系统界面信息验证
    verify same element text by UI    ${tmpl_add2_label_ID}    @{tempUI['labelL2']}
    ${radioList}    Combine Lists    ${tempUI['cpuNum']}     ${tempUI['createDisk']}    ${tempUI['diskEncry']}    ${tempUI['auditType']}    ${tempUI['stubdom']}
    verify same element text by UI    ${tmpl_add2_radio_select_ID}    @{radioList}
    verify input box character limit    ${tmpl_add2_memory_input_ID}    ${tempUI['len1']}
    verify element value attribute value    ${tmpl_add2_memory_input_ID}    ${tempUI['memoryD']}
    verify input box character limit    ${tmpl_add2_disk_input_ID}    ${tempUI['len1']}
    verify element value attribute value    ${tmpl_add2_disk_input_ID}    ${tempUI['diskD']}

verify create template step3 UI
    [Arguments]    ${netCardName}=1
    [Documentation]    新建模板网络界面信息验证
    ...    参数：第几张网卡(默认为1)
    verify same element text by UI    ${tmpl_add3_netCard_tab_ID}    @{tempUI['netCardNameL']}
    enable the network for template    ${netCardName}
    Select Checkbox    id=netkey_type_${netCardName}
    Select Checkbox    id=vlan_type_${netCardName}
    verify same element text by UI    //div[@id='netcard${netCardName}']//span[@class='lbl']    @{tempUI['enableL']}    @{tempUI['connectL']}
    Element Should Contain    //*[@name='tmpcard${netCardName}.netcard_type']/..    ${tempUI['connectT']}
    Element Should Contain    //p[@class='ethlist_${netCardName}']    ${tempUI['phyCardT']}
    Element Should Contain    //div[@class='iplist_${netCardName}']    ${tempUI['networkT']}
    Element Should Contain    //p[@class='netkeylist_${netCardName}']    ${tempUI['netKeyT']}
    Element Should Contain    //p[@class='vlanlist_${netCardName}']    ${tempUI['vlanT']}
    ${netCardName}    Convert To Integer    ${netCardName}
    verify same element text by UI    //table[@id='JColResizer${netCardName+1}']//th    ${EMPTY}    @{tempUI['tableH3']}
    : FOR    ${txt2}    IN    @{tempUI['networkD']}
    \    Run Keyword And Continue On Failure    Table Column Should Contain    css=#JColResizer${netCardName+1}    2    ${txt2}
    ${phyethL}    Get List Items    name=tmpcard${netCardName}.phy_eth
    Run Keyword And Continue On Failure    Lists Should Be Equal    ${phyethL}    ${tempUI['phyCardL']}
    List Selection Should Be    name=tmpcard${netCardName}.phy_eth    ${tempUI['phyCardL'][0]}
    [Teardown]    disable the network for template    ${netCardName}

verify create template step4 UI
    [Documentation]    新建模板策略信息验证
    : FOR    ${txt1}    IN    @{tempUI['tableH4']}
    \    Run Keyword And Continue On Failure    Table Header Should Contain    ${tmpl_add4_table_ID}    ${txt1}
    verify same element text by UI    ${tmpl_add4_deviceD_info}    ${EMPTY}    @{tempUI['deviceD']}
    verify element text    ${tmpl_add4_label_ID}    ${tempUI['deviceT']}

verify create template step5 UI
    [Arguments]    ${tempName}    ${vhdName}    ${netCardNum}=1
    [Documentation]    新建模板概览信息验证
    ...    参数：1.模板名称；2.镜像名称；3.第几张网卡(默认为1)
    ${cardInt}    Convert To Integer    ${netCardNum}
    ${cardList}    Create List    @{EMPTY}
    : FOR    ${i}    IN RANGE    ${cardInt}
    \    Append To List    ${cardList}    ${tempUI['netCardNameL'][${i}]}    @{tempUI['netlabel']}
    ${lableList}    Create List    @{tempUI['labelL5'][:-2]}    @{cardList}    @{tempUI['labelL5'][-2:]}
    ${valueList}    Create List    ${tempName}    ${vhdName}    @{tempUI['valueL']}
    verify same element text by UI    ${tmpl_add5_label_ID}    @{lableList}
    verify same element text by UI    ${tmpl_add5_value_ID}    @{valueList}
    verify lay UI title info    ${tempUI['title2']}    ${tempUI['title2']}    False

verify template detail UI info
    [Arguments]    ${tempName}    ${vhdName}    ${pub}=admin    ${netCardNum}=1
    [Documentation]    验证模板详细信息界面信息
    ...    参数：1.模板名称；2.镜像名称；3.镜像发布者(默认admin)；4.第几张网卡(默认为1)
    ${cardInt}    Convert To Integer    ${netCardNum}
    ${cardList}    Create List    @{EMPTY}
    : FOR    ${i}    IN RANGE    ${cardInt}
    \    Append To List    ${cardList}    ${tempUI['netCardNameL'][${i}]}    @{tempUI['netlabel']}
    ${lableList}    Create List    @{tempUI['labelL5'][:2]}    镜像发布者    @{tempUI['labelL5'][2:-2]}    @{cardList}    @{tempUI['labelL5'][-2:]}
    ${valueList}    Create List    ${tempName}    ${vhdName}    ${pub}    @{tempUI['valueL1']}
    verify same element text by UI    ${tmpl_add5_label_ID}    @{lableList}
    verify same element text by UI    ${tmpl_add5_value_ID}    @{valueList}
    verify lay UI title info    ${tempUI['title16']}    ${tempUI['title17']}    False

verify custom praefixum rule error info
    [Arguments]    ${errMsg}
    [Documentation]    创建模板常规界面自定义前缀命名规则错误提示信息验证
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${tmpl_add1_custom_error_ID}
    verify element text    ${tmpl_add1_custom_error_ID}    ${errMsg}

verify disk size error info
    [Arguments]    ${errMsg}
    [Documentation]    创建模板系统界面模板硬盘错误提示信息验证
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${tmpl_add2_disk_error_ID}
    verify element text    ${tmpl_add2_disk_error_ID}    ${errMsg}

verify momery size error info
    [Arguments]    ${errMsg}
    [Documentation]    创建模板系统界面模板内存错误提示信息验证
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${tmpl_add2_memory_error_ID}
    verify element text    ${tmpl_add2_memory_error_ID}    ${errMsg}

verify network card encrypt error info
    [Arguments]    ${errMsg}
    [Documentation]    创建模板网络界面模板网卡加密选择错误提示信息验证
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${tmpl_add3_netkey1_error_ID}
    verify element text    ${tmpl_add3_netkey1_error_ID}    ${errMsg}

verify template cpu number on the UI
    [Arguments]    ${tempName}    ${cpuNum}
    [Documentation]    在模板管理界面验证CPU的数量
    ...    参数：1.模板名称；2.CPU数量
    into template manage UI
    ${cpuNum}    Convert To String    ${cpuNum}
    ${nameId}    get template ID by database    ${tempName}
    verify element text    //a[contains(@onclick,'editTmpl(${nameId})')]/../../td[5]    ${cpuNum}

verify template disk encryption status on the UI
    [Arguments]    ${tempName}    ${status}
    [Documentation]    在模板管理界面验证磁盘加密状态
    ...    参数：1.模板名称；2.加密状态
    into template manage UI
    ${nameId}    get template ID by database    ${tempName}
    verify element text    //a[contains(@onclick,'editTmpl(${nameId})')]/../../td[4]    ${status}

verify template disk size on the UI
    [Arguments]    ${tempName}    ${diskSize}
    [Documentation]    在模板管理界面验证磁盘大小
    ...    参数：1.模板名称；2.磁盘大小
    into template manage UI
    ${diskSize}    Convert To String    ${diskSize}
    ${nameId}    get template ID by database    ${tempName}
    verify element text    //a[contains(@onclick,'editTmpl(${nameId})')]/../../td[6]    ${diskSize}

verify template manage UI other info
    [Documentation]    模板管理界面其他信息验证
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@value='${tempUI['button1']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@value='${tempUI['button2']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@value='${tempUI['button3']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@title='${tempUI['title4']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@title='${tempUI['title5']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@title='${tempUI['title6']}']
    open the search UI
    Run Keyword And Continue On Failure    verify element text    ${public_search_label_ID}    ${tempUI['srcLabel']}
    Run Keyword And Continue On Failure    verify element text    ${public_manage_title_ID}    ${tempUI['title1']}
    Unselect Frame
    verify element text    ${tmpl_tab_ID}    ${tempUI['title1']}

verify template manage UI table info
    [Documentation]    模板管理界面验证table信息
    : FOR    ${txt}    IN    @{tempUI['tableH1']}
    \    Run Keyword And Continue On Failure    Table Header Should Contain    ${public_table_ID}    ${txt}
    Run Keyword And Continue On Failure    Element Should Be Visible    //a[@title='${tempUI['title7']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //a[@title='${tempUI['title8']}']
    Element Should Be Visible    //*[@title='${tempUI['title9']}']

verify template memory size on the UI
    [Arguments]    ${tempName}    ${memorySize}
    [Documentation]    在模板管理界面验证内存大小
    ...    参数：1.模板名称；2.内存大小
    into template manage UI
    ${memorySize}    Convert To String    ${memorySize}
    ${nameId}    get template ID by database    ${tempName}
    verify element text    //a[contains(@onclick,'editTmpl(${nameId})')]/../../td[7]    ${memorySize}

verify template name error info
    [Arguments]    ${errMsg}
    [Documentation]    创建模板常规界面模板名称错误提示信息验证
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${tmpl_add1_name_error}
    verify element text    ${tmpl_add1_name_error}    ${errMsg}

verify template name on the UI
    [Arguments]    ${tempName}
    [Documentation]    在模板管理界面验证模板名称
    ...    参数：模板名称
    into template manage UI
    Table Column Should Contain    ${public_table_ID}    2    ${tempName}

verify template netCard number on the UI
    [Arguments]    ${tempName}    ${cardNum}
    [Documentation]    在模板管理界面网卡数量
    ...    参数：1.模板名称；2.网卡数量
    into template manage UI
    ${cardNum}    Convert To String    ${cardNum}
    ${nameId}    get template ID by database    ${tempName}
    verify element text    //a[contains(@onclick,'editTmpl(${nameId})')]/../../td[8]    ${cardNum}

verify template vhd name on the UI
    [Arguments]    ${tempName}    ${vhdName}
    [Documentation]    在模板管理界面验证镜像名称
    ...    参数：1.模板名称；2.镜像名称
    into template manage UI
    ${nameId}    get template ID by database    ${tempName}
    verify element text    //a[contains(@onclick,'editTmpl(${nameId})')]/../../td[3]    ${vhdName}
    verify element title attribute value    //a[contains(@onclick,'editTmpl(${nameId})')]/../../td[3]    ${vhdName}

verify use situation UI other info
    [Arguments]    ${tempName}
    [Documentation]    模板管理使用情况界面其他信息界面
    ...    参数：模板名称
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@value='${tempUI['button9']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@value='${tempUI['button10']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@value='${tempUI['button11']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@title='${tempUI['title11']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@title='${tempUI['title12']}']
    Run Keyword And Continue On Failure    Element Should Be Visible    //input[@title='${tempUI['title13']}']
    Run Keyword And Continue On Failure    verify element text    ${public_manage_title_ID}    ${tempName}的使用情况如下
    Unselect Frame
    verify element text    ${tmpl_use_tab_ID}    ${tempUI['title14']}

verify use situation UI table info
    [Documentation]    模板管理使用情况界面table信息验证
    verify same element text by UI    ${public_table_head}    ${EMPTY}    @{tempUI['tableH6']}

verify vhd select error info
    [Arguments]    ${errMsg}
    [Documentation]    创建模板时选择镜像错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${tmpl_add1_vhd_error_ID}
    verify element text    ${tmpl_add1_vhd_error_ID}    ${errMsg}

verify vlan error info
    [Arguments]    ${errMsg}
    [Documentation]    创建模板网络界面模板VLAN选择错误提示信息验证
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${tmpl_add3_vlan1_error_ID}
    verify element text    ${tmpl_add3_vlan1_error_ID}    ${errMsg}
