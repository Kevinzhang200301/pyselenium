*** Settings ***
Resource          PublicKeywords.robot
Resource          LogManageKeywords.robot

*** Keywords ***
click first page button
    [Documentation]    点击翻页中“首页”按钮
    Wait Until Element Is Visible    ${pagesize_first_button_ID}
    Click Element    ${pagesize_first_button_ID}
    Wait Until Element Is Visible    ${pagesize_jump_button_ID}

click last page button
    [Documentation]    点击翻页中“尾页”按钮
    Wait Until Element Is Visible    ${pagesize_last_button_ID}
    Click Element    ${pagesize_last_button_ID}
    Wait Until Element Is Visible    ${pagesize_jump_button_ID}

click next page button
    [Documentation]    点击翻页中“下一页”按钮
    Wait Until Element Is Visible    ${pagesize_next_button_ID}
    Click Element    ${pagesize_next_button_ID}
    Wait Until Element Is Visible    ${pagesize_jump_button_ID}

click prev page button
    [Documentation]    点击翻页中“上一页”按钮
    Wait Until Element Is Visible    ${pagesize_prev_button_ID}
    Click Element    ${pagesize_prev_button_ID}
    Wait Until Element Is Visible    ${pagesize_jump_button_ID}

get all page number of vclog
    [Arguments]    ${eachpage_number}
    [Documentation]    获取系统日志中总的页数
    ...    参数：每页显示的条数
    ${all_record_string}    get return value of the database query    SELECT COUNT(*) FROM log_vclog;
    ${all_record}    Convert To Integer    ${all_record_string}
    ${page_number_int}    Evaluate    ${all_record} / ${eachpage_number}
    ${all_number_int}    Evaluate    ${page_number_int} * ${eachpage_number}
    ${allpage_number}    Set Variable If    ${all_number_int} == ${all_record}    ${page_number_int}    ${all_number_int} < ${all_record}    ${page_number_int + 1}
    [Return]    ${allpage_number}

get xpath of current page exist element
    [Arguments]    ${pageNumber}    ${eachPageNumber}
    [Documentation]    获取当前页面上必须存在的元素xpath
    ${pageNumberInt}    Convert To Integer    ${pageNumber}
    ${startNumber}    Evaluate    ${eachPageNumber}*${pageNumberInt-1}
    ${id}    get return value of the database query
    ...    SELECT id FROM log_vclog ORDER BY CREATED_DATE DESC LIMIT ${startNumber},${eachPageNumber};
    ${elementXpath}    Set Variable    //input[@value='${id}']
    [Return]    ${elementXpath}

jump to page by jump button
    [Arguments]    ${page_number}
    [Documentation]    通过跳转按钮跳转到某一页
    ...    参数：具体需跳转的页数
    Input Text    ${pagesize_inputorder_ID}    ${page_number}
    Click Element    ${pagesize_jump_button_ID}
    Sleep    ${inputSleep}    

jump to page by page number
    [Arguments]    ${page_number}    ${eachpage_number}
    [Documentation]    通过页码跳转到某一页，
    ...    参数：1.需要跳转页数；2.每页显示条数
    ${current_page_num}    Get Text    ${pagesize_select_number_ID}
    ${all_page_num}    get all page number of vclog    ${eachpage_number}
    Run Keyword If    1 < ${page_number} < 6    Click Element    link=${page_number}
    ...    ELSE IF    ${page_number} == ${current_page_num}    Fail    msg=已在当前页面,输入页数有误
    ...    ELSE IF    5 < ${page_number} <= ${all_page_num}    number greater than 5 jumpto page number    ${page_number}
    ...    ELSE    Fail    msg=输入的页数异常（或者过大）

number greater than 5 jumpto page number
    [Arguments]    ${page_number}
    [Documentation]    当页数大于5时，通过页码来跳转
    ...    参数：需跳转的页码
    : FOR    ${i}    IN RANGE    5    ${page_number}    2
    \    scroll to the bottom
    \    Select Frame    ${syslog_iframe_ID}
    \    Click Element    link=${i}
    \    Run Keyword If    ${page_number} < ${i+3}    Click Element    link=${page_number}

select number of each page record
    [Arguments]    ${number}
    [Documentation]    选择每页显示的条数
    ...    参数：每页显示条数(10,50,100,500,1000)
    Select From List By Label    ${pagesize_select_ID}    ${number}
    Sleep    ${selectSleep}    
    List Selection Should Be    ${pagesize_select_ID}    ${number}
    Wait Until Element Is Visible    ${pagesize_label_ID}

verify current page number
    [Arguments]    ${page_number}
    [Documentation]    验证当前所在页的页码数
    ...    参数：每页显示条数(10,50,100,500,1000)
    ${current_page_num}    Get Text    ${pagesize_select_number_ID}
    Should Be Equal As Integers    ${page_number}    ${current_page_num}

verify current page record number in vclog UI
    [Arguments]    ${each_number}
    [Documentation]    验证当前页面显示的记录条数
    ...    参数：每页显示条数(10,50,100,500,1000)
    ${current_page_number}    get current table record number
    ${allNum}    get return value of the database query    SELECT COUNT(*) FROM log_vclog;
    ${verifyNum}    Set Variable If    '${current_page_number}'=='${allNum}'    ${allNum}
    ...    '${current_page_number}'!='${allNum}'    ${each_number}
    Should Be Equal As Integers    ${current_page_number}    ${verifyNum}

verify jumpto last page info by UI
    [Arguments]    ${eachpage_number}
    [Documentation]    验证已跳转尾页
    ...    参数：每页显示条数(10,50,100,500,1000)
    ${allpage_number}    get all page number of vclog    ${eachpage_number}
    ${xpath}    get xpath of current page exist element    ${allpage_number}    ${eachpage_number}
    Element Should Be Visible    ${xpath}
    verify current page number    ${allpage_number}

verify jumpto one page info by UI
    [Arguments]    ${page_number}    ${eachpage_number}
    [Documentation]    验证跳转到某一页上
    ...    参数：1.具体的页码；2.每页显示条数(10,50,100,500,1000)
    ${xpath}    get xpath of current page exist element    ${page_number}    ${eachpage_number}
    Element Should Be Visible    ${xpath}
    verify current page number    ${page_number}

verify page turning label info
    [Arguments]    ${eachpage_number}
    [Documentation]    验证翻页栏信息
    ...    参数：每页显示条数(10,50,100,500,1000)
    Element Should Contain    ${pagesize_select_ID}/..    每页
    Element Should Contain    ${pagesize_select_ID}/..    条
    List Selection Should Be    ${pagesize_select_ID}    ${eachpage_number}
    ${all_record_number}    get return value of the database query    SELECT COUNT(*) FROM log_vclog;
    Element Should Contain    ${pagesize_label_ID}    共${all_record_number}条
    Element Should Contain    ${pagesize_label_ID}    首页
    Element Should Contain    ${pagesize_label_ID}    <<
    Element Should Contain    ${pagesize_label_ID}    尾页
    Element Should Contain    ${pagesize_label_ID}    >>
    ${all_page_number}    get all page number of vclog    ${eachpage_number}
    Element Should Contain    ${pagesize_label_ID}    共${all_page_number}页
    Element Should Contain    ${pagesize_jump_button_ID}/..    到
    Element Should Contain    ${pagesize_jump_button_ID}/..    页
    Element Should Contain    ${pagesize_jump_button_ID}    跳转
