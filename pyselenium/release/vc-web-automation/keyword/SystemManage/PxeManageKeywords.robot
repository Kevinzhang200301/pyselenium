*** Settings ***
Resource          ../../ElementLocators/SystemManageElementID.robot
Resource          ../PublicKeywords.robot
Variables         ../../TestData/SystemManage.py

*** Keywords ***
choose install patch
    [Arguments]    ${filePath}
    [Documentation]    在添加安装包界面从本地选择安装包
    ...    参数：安装路径
    Choose File    ${pxe_patch_choose_ID}    ${filePath}

clear env for edit PXE
    [Documentation]    清空编辑安装包的测试环境：1.删除安装包；2.还原DHCP按钮；3.关闭浏览器
    delete all install patch by UI
    into pxe manage UI
    ${status }    Run Keyword And Return Status    Element Should Be Visible    ${pxe_shutdown_button_ID}
    Run Keyword If    '${status }'=='True'    click shutdown DHCP button
    Run Keyword If    '${status }'=='True'    click confirm box confirm button
    close browser and kill chrome process

click add patch button
    [Documentation]    点击添加安装包按钮
    Click Element    ${pxe_addPatch_button_ID}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${pxe_patch_name_input_ID}

click config DHCP button
    [Documentation]    点击配置DHCP按钮
    Click Element    ${pxe_dhcp_button_ID}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${pxe_dhcp_startIp_input_ID}

click delete install patch button
    [Arguments]    ${patchName}
    [Documentation]    点击删除安装包按钮
    ...    参数：安装包名称
    ${nameId}    get install patch id by database    ${patchName}
    Click Element    //a[contains(@onclick,'delPxe(${nameId})')]

click download install patch button
    [Arguments]    ${patchName}
    [Documentation]    点击下载安装包按钮
    ...    参数：安装包名称
    ${nameId}    get install patch id by database    ${patchName}
    Click Element    //a[contains(@onclick,'downloadPxe(${nameId})')]

click edit install patch button
    [Arguments]    ${patchName}
    [Documentation]    点击编辑安装包按钮
    ...    参数：安装包名称
    ${nameId}    get install patch id by database    ${patchName}
    Click Element    //a[contains(@onclick,'editPxe(${nameId})')]
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${pxe_patch_name_input_ID}

click install patch upload button
    [Documentation]    点击添加安装包界面上传按钮
    Click Element    ${pxe_patch_upload_button_ID}

click mount install package UI cancel button
    [Documentation]    点击挂载界面上取消按钮
    Wait Until Element Is Visible    ${pxe_mount_cancelbtn_ID}
    Click Element    ${pxe_mount_cancelbtn_ID}

click mount install package UI mount button
    [Documentation]    点击挂载界面上挂载按钮
    Wait Until Element Is Visible    ${pxe_mount_mountbtn_ID}
    Click Element    ${pxe_mount_mountbtn_ID}

click mount install patch button
    [Arguments]    ${patchName}
    [Documentation]    点击挂载安装包按钮
    ...    参数：安装包名称
    ${nameId}    get install patch id by database    ${patchName}
    Click Element    //a[contains(@onclick,'toMountPxe(${nameId})')]
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${pxe_mount_pwd_input_ID}

click restart DHCP button
    [Documentation]    点击重启DHCP服务按钮
    Wait Until Element Is Visible    ${pxe_restart_button_ID}
    Click Element    ${pxe_restart_button_ID}

click shutdown DHCP button
    [Documentation]    点击关闭DHCP服务按钮
    Wait Until Element Is Visible    ${pxe_shutdown_button_ID}
    Click Element    ${pxe_shutdown_button_ID}

click start DHCP button
    [Documentation]    点击启用DHCP服务按钮
    Wait Until Element Is Visible    ${pxe_start_button_ID}
    Click Element    ${pxe_start_button_ID}

create right dhcp config by UI
    [Documentation]    在集中部署界面上创建正确的DHCP配置
    into pxe manage UI
    click config DHCP button
    input dhcp start ip    ${pxeTD['startIpR']}
    input dhcp end ip    ${pxeTD['endIpR']}
    input dhcp subnet ip    ${pxeTD['subnetR']}
    input dhcp netmask    ${pxeTD['maskD']}
    input dhcp gateway    ${pxeTD['gwR']}
    input dhcp dns    ${pxeTD['dnsR']}
    input dhcp tftp    ${pxeTD['tftpR']}
    click save button    True
    verify lobibox info

create right install patch by UI
    [Arguments]    ${patchName}    ${filePath}=default
    [Documentation]    在集中部署界面上创建正确的安装包
    ...    参数：1.安装包名称；2.安装包路径(有默认路径)
    ${filePathD}    Set Variable If    '${filePath}'=='default'    ${pxeTD['fileR']}    '${filePath}'!='None'    ${filePath}
    into pxe manage UI
    click add patch button
    choose install patch    ${filePathD}
    click install patch upload button
    wait until file upload down
    input install patch name    ${patchName}
    click save button    True
    verify install patch on the UI    ${patchName}

delete all install patch by UI
    [Documentation]    在集中部署界面上删除所有的安装包
    into pxe manage UI
    ${len}    get rows of database table    SELECT id FROM system_pxe;
    : FOR    ${i}    IN RANGE    ${len}
    \    ${element}    Get Webelement    //a[contains(@onclick,'delPxe')]
    \    Wait Until Element Is Enabled    ${element}
    \    Click Element    ${element}
    \    click confirm box confirm button
    \    Select Frame    ${pxe_manage_iframe_ID}

get install patch id by database
    [Arguments]    ${patchName}
    [Documentation]    在数据库中获取安装包的ID
    ...    参数：安装包名称
    open hsdb database
    ${result}    Query    SELECT id FROM system_pxe WHERE name='${patchName}';
    ${nameId}    Set Variable    ${result[0][0]}
    Disconnect From Database
    [Return]    ${nameId}

input dhcp dns
    [Arguments]    ${dns}
    [Documentation]    在配置DHCP界面输入域名服务器
    ...    参数：域名服务器
    Clear Element Text    ${pxe_dhcp_dnsIp_input_ID}
    Input Text    ${pxe_dhcp_dnsIp_input_ID}    ${dns}
    Sleep    ${inputSleep}

input dhcp end ip
    [Arguments]    ${endIp}
    [Documentation]    在配置DHCP服务界面输入结束地址
    ...    参数：结束地址
    Clear Element Text    ${pxe_dhcp_endIp_input_ID}
    Input Text    ${pxe_dhcp_endIp_input_ID}    ${endIp}
    Sleep    ${inputSleep}

input dhcp gateway
    [Arguments]    ${gw}
    [Documentation]    在配置DHCP服务界面输入网关
    ...    参数：网关
    Clear Element Text    ${pxe_dhcp_gwIp_input_ID}
    Input Text    ${pxe_dhcp_gwIp_input_ID}    ${gw}
    Sleep    ${inputSleep}

input dhcp netmask
    [Arguments]    ${subIp}
    [Documentation]    在配置DHCP服务界面输入子网掩码
    ...    参数：子网掩码
    Clear Element Text    ${pxe_dhcp_maskIp_input_ID}
    Input Text    ${pxe_dhcp_maskIp_input_ID}    ${subIp}
    Sleep    ${inputSleep}

input dhcp start ip
    [Arguments]    ${startIp}
    [Documentation]    在配置DHCP服务界面输入开始地址
    ...    参数：开始地址
    Clear Element Text    ${pxe_dhcp_startIp_input_ID}
    Input Text    ${pxe_dhcp_startIp_input_ID}    ${startIp}
    Sleep    ${inputSleep}

input dhcp subnet ip
    [Arguments]    ${subIp}
    [Documentation]    在配置DHCP服务界面输入子网地址
    ...    参数：子网地址
    Clear Element Text    ${pxe_dhcp_subnet_input_ID}
    Input Text    ${pxe_dhcp_subnet_input_ID}    ${subIp}
    Sleep    ${inputSleep}

input dhcp tftp
    [Arguments]    ${tftp}
    [Documentation]    在配置DHCP界面输入TFTP服务器
    ...    参数：TFTP服务器
    Clear Element Text    ${pxe_dhcp_tftpIp_input_ID}
    Input Text    ${pxe_dhcp_tftpIp_input_ID}    ${tftp}
    Sleep    ${inputSleep}

input install patch name
    [Arguments]    ${patchName}
    [Documentation]    在添加安装包界面输入名称
    ...    参数：安装包名称
    Clear Element Text    ${pxe_patch_name_input_ID}
    Input Text    ${pxe_patch_name_input_ID}    ${patchName}
    Sleep    ${inputSleep}

input mount install package vtop password
    [Arguments]    ${password}
    [Documentation]    在挂载安装包界面输入vTop密码
    ...    参数：密码
    Clear Element Text    ${pxe_mount_pwd_input_ID}
    Input Text    ${pxe_mount_pwd_input_ID}    ${password}
    Sleep    ${inputSleep}

input search install patch name
    [Arguments]    ${name}
    [Documentation]    在集中部署界面输入搜索安装包名称
    ...    参数：名称
    open the search UI
    Clear Element Text    ${pxe_search_name_input_ID}
    Input Text    ${pxe_search_name_input_ID}    ${name}
    Sleep    ${inputSleep}

into pxe manage UI
    [Documentation]    进入到集中部署界面
    refresh page
    Wait Until Element Is Enabled    ${system_manage_menu_ID}
    Click Element    ${system_manage_menu_ID}
    Wait Until Element Is Visible    ${pxe_menu_ID}
    Click Element    ${pxe_menu_ID}
    Wait Until Element Is Visible    ${pxe_manage_UI_ID}
    Select Frame    ${pxe_manage_iframe_ID}
    Wait Until Element Is Visible    ${pxe_addPatch_button_ID}

prepar env for shutdown dhcp
    [Arguments]    ${startIp}
    [Documentation]    为测试DHCP服务器启动准备环境
    ...    参数：开始地址
    into pxe manage UI
    click config DHCP button
    input dhcp start ip    ${startIp}
    click save button    True
    verify lobibox info
    into pxe manage UI
    ${status }    Run Keyword And Return Status    Element Should Be Visible    ${pxe_start_button_ID}
    Run Keyword If    '${status }'=='True'    click start DHCP button
    Run Keyword If    '${status }'=='True'    click confirm box confirm button

prepar env for start dhcp
    [Arguments]    ${startIp}
    [Documentation]    为测试DHCP服务器启动准备环境
    ...    参数：开始地址
    into pxe manage UI
    click config DHCP button
    input dhcp start ip    ${startIp}
    click save button    True
    verify lobibox info

prepare env for edit PXE
    [Documentation]    为测试编辑安装包准备环境：1.admin用户登录；2.创建安装包
    ...    3.配置正确的DHCP
    login by admin
    create right install patch by UI    ${pxeTD['vtopIsoName']}    ${pxeTD['vtopISO']}
    create right install patch by UI    ${pxeTD['nameD']}
    create right install patch by UI    ${pxeTD['editD']}
    create right install patch by UI    ${pxeTD['del']}
    : FOR    ${name}    IN    @{pxeTD['srcName']}
    \    create right install patch by UI    ${name}
    create right dhcp config by UI

select install package mode
    [Arguments]    ${mode}
    [Documentation]    在挂载vTop安装包界面选择vTop安装的方式
    Select Radio Button    ${pxe_mount_mode_name}    ${mode}
    Sleep    ${selectSleep}
    Radio Button Should Be Set To    ${pxe_mount_mode_name}    ${mode}

verify DHCP UI form info
    [Documentation]    验证配置DHCP服务界面form信息
    verify same element text by UI    ${layui_label_ID}    @{pxeUI['labelL1']}
    verify input box character limit    ${pxe_dhcp_startIp_input_ID}    ${pxeUI['len1']}
    verify input box character limit    ${pxe_dhcp_endIp_input_ID}    ${pxeUI['len1']}
    verify input box character limit    ${pxe_dhcp_subnet_input_ID}    ${pxeUI['len1']}
    verify input box character limit    ${pxe_dhcp_maskIp_input_ID}    ${pxeUI['len1']}
    verify input box character limit    ${pxe_dhcp_gwIp_input_ID}    ${pxeUI['len1']}
    verify input box character limit    ${pxe_dhcp_dnsIp_input_ID}    ${pxeUI['len1']}
    verify input box character limit    ${pxe_dhcp_tftpIp_input_ID}    ${pxeUI['len1']}

verify dhcp DNS error info
    [Arguments]    ${errMsg}
    [Documentation]    在配置DHCP界面域名服务器错误提示信息验证
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${pxe_dhcp_dnsIp_error_ID}
    verify element text    ${pxe_dhcp_dnsIp_error_ID}    ${errMsg}

verify dhcp TFTP error info
    [Arguments]    ${errMsg}
    [Documentation]    在配置DHCP界面TFTP服务器错误提示信息验证
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${pxe_dhcp_tftpIp_error_ID}
    verify element text    ${pxe_dhcp_tftpIp_error_ID}    ${errMsg}

verify dhcp endIp error info
    [Arguments]    ${errMsg}
    [Documentation]    在配置DHCP界面结束地址错误提示信息验证
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${pxe_dhcp_endIp_error_ID}
    verify element text    ${pxe_dhcp_endIp_error_ID}    ${errMsg}

verify dhcp gateway error info
    [Arguments]    ${errMsg}
    [Documentation]    在配置DHCP界面网关错误提示信息验证
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${pxe_dhcp_gwIp_error_ID}
    verify element text    ${pxe_dhcp_gwIp_error_ID}    ${errMsg}

verify dhcp netmask error info
    [Arguments]    ${errMsg}
    [Documentation]    在配置DHCP界面子网掩码错误提示信息验证
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${pxe_dhcp_maskIp_error_ID}
    verify element text    ${pxe_dhcp_maskIp_error_ID}    ${errMsg}

verify dhcp startIp error info
    [Arguments]    ${errMsg}
    [Documentation]    在配置DHCP界面开始地址错误提示信息验证
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${pxe_dhcp_startIp_error_ID}
    verify element text    ${pxe_dhcp_startIp_error_ID}    ${errMsg}

verify dhcp status by UI
    [Arguments]    ${dhcpStatus}
    [Documentation]    验证DHCP服务的状态
    ...    参数：错误提示信息
    into pxe manage UI
    Element Should Contain    ${pxe_dhcpStatus_ID}    ${dhcpStatus}

verify dhcp subnetIp error info
    [Arguments]    ${errMsg}
    [Documentation]    在配置DHCP界面子网地址错误提示信息验证
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${pxe_dhcp_subnet_error_ID}
    verify element text    ${pxe_dhcp_subnet_error_ID}    ${errMsg}

verify install package mount lobibox
    [Documentation]    安装包挂在成功lobibox信息验证
    verify lobibox info    ${sysBox['msg12']}
    Wait Until Element Is Visible    ${lobibox_success}
    verify element text    ${lobibox_info}${lobibox_msg_ID}
    ...    ${sysBox['msg31']}

verify install package mount success
    [Arguments]    ${packageName}    ${status}
    [Documentation]    验证安装包挂载成功
    ...    参数：1.安装包名称；2.挂载状态
    into pxe manage UI
    ${nameId}    get install patch id by database    ${packageName}
    verify element text    //a[contains(@onclick,'editPxe(${nameId})')]/../../td[2]    ${status}

verify install patch UI form info
    [Documentation]    验证添加安装包界面form信息
    verify same element text by UI    //div[@class='form-group']${layui_label_ID}    @{pxeUI['labelL2']}
    verify input box character limit    ${pxe_patch_name_input_ID}    ${pxeUI['len1']}

verify install patch file error info
    [Arguments]    ${errMsg}
    [Documentation]    在添加安装包界面验证文件错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${pxe_patch_file_error_ID}
    Element Should Contain    ${pxe_patch_file_error_ID}    ${errMsg}

verify install patch name error info
    [Arguments]    ${errMsg}
    [Documentation]    在添加安装包界面验证名称错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${pxe_patch_name_error_ID}
    verify element text    ${pxe_patch_name_error_ID}    ${errMsg}

verify install patch on the UI
    [Arguments]    ${patchName}
    [Documentation]    在集中部署界面上验证某安装包名称
    ...    参数：安装包名称
    into pxe manage UI
    Table Column Should Contain    ${public_table_ID}    1    ${patchName}

verify mount install package UI form info
    [Documentation]    验证挂载安装包界面form信息
    verify element text    ${layui_label_ID}    ${pxeUI['labelL3']}
    verify same element text by UI    ${pxe_mount_modeLabel_ID}    @{pxeUI['modeL']}
    verify element value attribute value    ${pxe_mount_pwd_input_ID}    ${pxeUI['vTopPwdD']}
    Element Should Contain    ${pxe_mount_mountbtn_ID}    ${pxeUI['button7']}
    Element Should Contain    ${pxe_mount_cancelbtn_ID}    ${pxeUI['button8']}

verify mount install package UI title
    [Documentation]    验证挂载安装包界面title信息
    Unselect Frame
    Run Keyword And Continue On Failure    Element Should Contain    ${layui_title_ID}    ${pxeUI['title16']}
    Select Frame    ${layui_iframe_ID}
    Run Keyword And Continue On Failure    Element Should Contain    //h1    ${pxeUI['title15']}

verify mount install package vtop password error info
    [Arguments]    ${errMsg}
    [Documentation]    在挂载安装包界面验证vTop密码错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${pxe_mount_pwd_error_ID}
    verify element text    ${pxe_mount_pwd_error_ID}    ${errMsg}

verify pxe manage UI other info
    [Documentation]    验证集中部署界面其他信息
    verify element text    //h1/strong    ${pxeUI['title1']}
    verify element text    //p/strong    ${pxeUI['title13']}
    Element Should Be Visible    //input[@value='${pxeUI['button1']}']
    Element Should Be Visible    //input[@title='${pxeUI['title2']}']
    Element Should Be Visible    //a[@title='${pxeUI['title3']}']
    Element Should Be Visible    //a[@title='${pxeUI['title4']}']
    Element Should Contain    ${pxe_dhcp_button_ID}    ${pxeUI['button2']}
    Element Should Contain    ${pxe_start_button_ID}    ${pxeUI['button3']}
    open the search UI
    verify element text    ${public_search_label_ID}    ${pxeUI['srcLabel']}
    Unselect Frame
    verify element text    ${pxe_tab_ID}    ${pxeUI['title1']}

verify pxe manage UI table info
    [Documentation]    验证集中部署界面安装包table信息
    verify same element text by UI    ${public_table_head}    @{pxeUI['tableH']}
    Element Should Be Visible    //a[@title='${pxeUI['title9']}']
    Element Should Be Visible    //a[@title='${pxeUI['title10']}']
    Element Should Be Visible    //a[@title='${pxeUI['title11']}']
    Element Should Be Visible    //a[@title='${pxeUI['title12']}']

verify dhcp service on backstage
    [Arguments]    ${status}
    [Documentation]    在VC后台验证DHCP服务的状态
    ...    参数：待验证的状态(running,dead)
    Open Connection    ${vc_ip}    port=${vc_ssh_port}
    Login    ${vc_ssh_user}    ${vc_ssh_pwd}
    Write    systemctl status dhcpd
    Set Client Configuration     prompt=$
    ${output}    Read Until Prompt
    Should Contain    ${output}    ${status}    
    Close Connection