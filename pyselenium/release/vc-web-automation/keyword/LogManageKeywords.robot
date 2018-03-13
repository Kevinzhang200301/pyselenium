*** Settings ***
Resource    ../ElementLocators/LogElementID.robot
Resource    PublicKeywords.robot
Variables    ../TestData/LogManage.py

*** Keywords ***
into vTop log manage UI
    [Documentation]    进入到vTop日志管理界面
    refresh page
    Wait Until Element Is Visible    ${log_manage_menu_ID}
    Click Element    ${log_manage_menu_ID}
    Wait Until Element Is Visible    ${vtoplog_menu_ID}
    Click Element    ${vtoplog_menu_ID}
    Wait Until Element Is Visible    ${vtoplog_UI_ID}
    Select Frame    ${vtoplog_manage_iframe_ID}
    Wait Until Element Is Visible    ${vtoplog_delete_button}
    
click vtoplog delete button
    [Documentation]    点击vTop日志删除按钮
    Click Element    ${vtoplog_delete_button}
    
input search vm name
    [Arguments]    ${vmName}
    [Documentation]    在vTop日志管理界面搜索栏输入虚拟机名称
    ...    参数：搜索虚拟机名称
    Clear Element Text    ${vtoplog_search_vmName_input}
    Input Text    ${vtoplog_search_vmName_input}    ${vmName}
    Sleep    ${inputSleep}    
        
verify vtoplog manage UI info
    [Documentation]    vTop日志管理界面信息验证
    verify same element text by UI    ${log_table_head}    ${EMPTY}    @{vtoplogUI['tableH']}
    verify element value attribute value    ${vtoplog_delete_button}    ${vtoplogUI['button1']}   
    verify element title attribute value    ${vtoplog_delete_button}    ${vtoplogUI['title2']}    
    open the search UI
    verify same element text by UI    ${public_search_label_ID}    @{vtoplogUI['labelL1']}    ${EMPTY}
    Click Element    ${vtoplog_search_time_input}
    Wait Until Element Is Visible    ${vtoplog_search_time_label}
    verify same element text by UI    ${vtoplog_search_time_label}    @{vtoplogUI['labelL2']}    
    verify same element text by UI    ${vtoplog_search_time_button}    ${vtoplogUI['button2']}    ${vtoplogUI['button3']}
    verify element text    ${public_manage_title_ID}    ${vtoplogUI['title1']}    
    Unselect Frame
    verify element text    ${vtoplog_tab_ID}    ${vtoplogUI['title1']}    
    
into system log manage UI
    [Documentation]    进入到系统日志管理界面
    refresh page
    Wait Until Element Is Enabled    ${log_manage_menu_ID}    
    Click Element    ${log_manage_menu_ID}
    Wait Until Element Is Visible    ${syslog_menu_ID}
    Click Element    ${syslog_menu_ID}
    Wait Until Element Is Visible    ${syslog_UI_ID}    
    Select Frame    ${syslog_iframe_ID}    
    
click systemlog delete button
    [Documentation]    点击系统日志删除按钮
    Click Element    ${vtoplog_delete_button}      
    
verify system log manage UI info
    [Documentation]    系统日志管理界面其他信息验证
    verify same element text by UI    ${log_table_head}    ${EMPTY}    @{syslogUI['tableH']}
    verify element value attribute value    ${syslog_delete_button}    ${syslogUI['button1']}   
    verify element title attribute value    ${syslog_delete_button}    ${syslogUI['title2']}    
    open the search UI
    verify same element text by UI    ${public_search_label_ID}    @{syslogUI['labelL1']}    
    ${list1}    Get List Items    ${syslog_search_mode_select}
    Log List    ${list1}    
    ${list2}    Get List Items    ${syslog_search_opeartype_select}
    Lists Should Be Equal    ${list1}    ${syslogUI['selectL1']} 
    Lists Should Be Equal    ${list2}    ${syslogUI['selectL2']}
    Click Element    ${syslog_search_time_select}
    Wait Until Element Is Visible    ${syslog_search_time_label}
    verify same element text by UI    ${syslog_search_time_label}    @{syslogUI['labelL2']}    
    verify same element text by UI    ${syslog_search_time_button}    ${syslogUI['button2']}    ${syslogUI['button3']}
    verify element text    ${public_manage_title_ID}    ${syslogUI['title1']}    
    Unselect Frame
    verify element text    ${syslog_tab_ID}    ${syslogUI['title1']}
    
select system first log
    [Documentation]    选择系统日志中第一条日志,并返回该日志的id
    Select Checkbox    //tbody/tr[1]/td/input
    Sleep    ${selectSleep}    
    ${logId}    Get Value    //tbody/tr[1]/td/input
    [Return]    ${logId}
    
verify system first log delete success
    [Arguments]    ${logId}
    [Documentation]    验证第一条日志删除成功
    ...    参数：日志数据库中的ID
    open hsdb database
    Row Count Is 0    SELECT * FROM log_vclog WHERE id='${logId}';
    Disconnect From Database
    
click end time on vtop log for sort
    [Documentation]    在vTop日志管理界面结束时间排序
    Wait Until Element Is Visible    ${log_vtopsort_end}
    Click Element    ${log_vtopsort_end}    
    Wait Until Element Is Visible    ${log_vtopsort_end}
    
click vm name on vtop log for sort
    [Documentation]    在vTop日志管理界面虚拟机名称排序
    Wait Until Element Is Visible    ${log_vtopsort_vmname}
    Click Element    ${log_vtopsort_vmname}    
    Wait Until Element Is Visible    ${log_vtopsort_vmname}    
    
click uuid on vtop log for sort
    [Documentation]    在vTop日志管理界面虚拟机UUID排序
    Wait Until Element Is Visible    ${log_vtopsort_uuid}
    Click Element    ${log_vtopsort_uuid}    
    Wait Until Element Is Visible    ${log_vtopsort_uuid}

click type on vtop log for sort
    [Documentation]    在vTop日志管理界面类型排序
    Wait Until Element Is Visible    ${log_vtopsort_type}
    Click Element    ${log_vtopsort_type}    
    Wait Until Element Is Visible    ${log_vtopsort_type}

click status on vtop log for sort
    [Documentation]    在vTop日志管理界面开始时间排序
    Wait Until Element Is Visible    ${log_vtopsort_status}
    Click Element    ${log_vtopsort_status}    
    Wait Until Element Is Visible    ${log_vtopsort_status}

click start time on vtop log for sort
    [Documentation]    在vTop日志管理界面开始时间排序
    Wait Until Element Is Visible    ${log_vtopsort_start}
    Click Element    ${log_vtopsort_start}    
    Wait Until Element Is Visible    ${log_vtopsort_start}
    
click creator on system log for sort
    [Documentation]    在系统日志管理界面点击操作人员排序
    Wait Until Element Is Visible    ${log_syssort_creator}
    Click Element    ${log_syssort_creator}    
    Wait Until Element Is Visible    ${log_syssort_creator}
    
click date on system log for sort
    [Documentation]    在系统日志管理界面点击操作时间排序
    Wait Until Element Is Visible    ${log_syssort_date}
    Click Element    ${log_syssort_date}    
    Wait Until Element Is Visible    ${log_syssort_date}    
    
click type on system log for sort
    [Documentation]    在系统日志管理界面点击操作类型排序
    Wait Until Element Is Visible    ${log_syssort_type}
    Click Element    ${log_syssort_type}    
    Wait Until Element Is Visible    ${log_syssort_type}    