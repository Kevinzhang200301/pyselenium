*** Settings ***
Library           Selenium2Library    10
Library           OperatingSystem
Library           SSHLibrary
Library           Collections
Library           String
Library           DatabaseLibrary
Resource          ../ElementLocators/PublicElementID.robot
Variables         ../TestData/PublicData.py
Resource          LoginLogoutKeywords.robot

*** Keywords ***
click "x" button
    [Documentation]    点击界面上“x”按钮(比如：新建界面)
    Unselect Frame
    Wait Until Element Is Visible    ${layui_x_button_ID}    error=界面上"x"按钮不可见
    Click Element    ${layui_x_button_ID}
    Sleep    ${clickSleep}
    Wait Until Element Is Not Visible    ${layui_x_button_ID}    error=点击"x"后该按钮扔可见

click cancle button
    [Documentation]    点击界面取消按钮(比如：新建界面)
    Unselect Frame
    Wait Until Element Is Visible    ${layui_cancel_button_ID}    error=界面上取消按钮不可见
    Sleep    ${clickSleep}
    Click Element    ${layui_cancel_button_ID}
    Sleep    0.3
    Wait Until Element Is Not Visible    ${layui_cancel_button_ID}    error=点击取消后该按钮扔可见

click confirm box cancel button
    [Documentation]    点击页面确认弹窗中取消按钮
    Unselect Frame
    Wait Until Element Is Visible    ${popup_cancel_ID}    error=弹窗界面上取消按钮不可见
    Sleep    ${clickSleep}
    Click Element    ${popup_cancel_ID}
    Sleep    0.3
    Wait Until Element Is Not Visible    ${popup_cancel_ID}    error=点击取消后该按钮扔可见

click confirm box confirm button
    [Documentation]    点击页面确认弹窗中确定按钮
    Unselect Frame
    Wait Until Element Is Visible    ${popup_confirm_ID}    error=弹窗界面上确定按钮不可见
    Sleep    ${clickSleep}
    Click Button    ${popup_confirm_ID}
    Sleep    0.3
    Wait Until Element Is Not Visible    ${popup_confirm_ID}    error=点击确定后该按钮扔可见

click login user manage button
    [Documentation]    点击右上角“欢迎，xxx”按钮
    refresh page
    Wait Until Element Is Visible    ${main_welcome_button}    error=页面右上角vTopCenter登录用户管理按钮不可见
    Click Element    ${main_welcome_button}
    Sleep    ${clickSleep}
    Wait Until Element Is Visible    ${main_logout_button}    error=点击页面右上角vTopCenter登录用户管理按钮后未看到退出登录按钮

click save button
    [Arguments]    ${status}=False
    [Documentation]    点击界面保存按钮(比如：新建界面)
    ...    参数：点击保存按钮后是否报错(默认会报错)
    Unselect Frame
    Wait Until Element Is Visible    ${layui_save_button_ID}
    Click Element    ${layui_save_button_ID}
    : FOR    ${i}    IN    1
    \    Exit For Loop If    '${status}'=='True'
    \    Select Frame    ${layui_iframe_ID}

click search button
    [Documentation]    点击管理界面搜索栏中搜索按钮
    Wait Until Element Is Visible    ${search_button_ID}    error=搜索按钮不可见
    Click Element    ${search_button_ID}
    Sleep    ${clickSleep}
    Wait Until Element Is Not Visible    ${search_button_ID}    error=点击搜索后该按钮扔可见

close browser and kill chrome process
    [Documentation]    关闭所有的浏览器并杀掉chromedrive进程，如果进程没有杀死在RIDE上不能直接打开log查看测试结果
    Close All Browsers
    Comment    在windows系统上关闭谷歌浏览器驱动
    Run    taskkill /F /IM chromedriver.exe 2>&1

verify element text
    [Arguments]    ${locator}    ${text}
    [Documentation]    验证元素的文字(忽略前后空格),字符串形式验证
    ...    参数：1.元素的选择器，2.验证的文字
    Wait Until Element Is Visible    ${locator}    error="${locator}"元素不可见
    ${getTxt}    Get Text    ${locator}
    ${getTxt}    Strip String    ${getTxt}
    Should Be Equal As Strings    ${text}    ${getTxt}    msg=验证的值"${text}"与实际值"${getTxt}"不相等

enter key
    [Arguments]    ${locator}
    [Documentation]    在某位置按回车键
    ...    参数：使用回车键的元素位置
    Press Key    ${locator}    \\13

get current table record number
    [Arguments]    ${table_locator}=default
    [Documentation]    获取当前管理页面上记录数量，获取之前有截图(通过计算标签tr的个数来获得)
    ...    参数：table元素地址(默认值：css=#sample-table-2，格式需要与默认值相同)
    Capture Page Screenshot
    ${locatorNew}    Set Variable If    '${table_locator}'=='default'    ${public_table_ID[5:]}    '${table_locator}'!='default'    ${table_locator[5:]}
    ${table_rows_number}    Execute Javascript    var len=document.getElementById('${locatorNew}').getElementsByTagName('tr').length;return len;
    ${rows_number}    Evaluate    ${table_rows_number}-1
    [Return]    ${rows_number}

login by admin
    [Documentation]    使用admin用户登录vTopCenter
    open vtopcenter
    input login user    ${vc_web_user}
    input login password    ${vc_web_pwd}
    click login button
    verify login success

get table column text on UI
    [Arguments]    ${col}    ${table_locator}=default
    [Documentation]    获取table中某一列的值(返回值为列表)
    ...    参数：1.具体第几列；2.table的元素定位器
    ${locatorNew}    Set Variable If    '${table_locator}'=='default'    ${public_table_ID}    '${table_locator}'!='default'    ${table_locator}
    ${len}    get current table record number    ${locatorNew}
    @{txtList}    Create List    @{EMPTY}
    : FOR    ${i}    IN RANGE    ${len}
    \    ${group}    Get Table Cell    ${locatorNew}    ${i+2}    ${col}
    \    Append To List    ${txtList}    ${group}
    [Return]    @{txtList}

get return value of the database query
    [Arguments]    ${querySrings}
    [Documentation]    获取数据库查询结果返回值
    ...    参数：数据库查询语句
    open hsdb database
    ${result}    Query    ${querySrings}
    Should Not Be Empty    ${result}    msg=在数据库中运行${querySrings},结果为空
    Disconnect From Database
    [Return]    ${result[0][0]}

get rows of database table
    [Arguments]    ${queryString}
    [Documentation]    获取数据库某个表中的记录数
    ...    参数：查询语句
    open hsdb database
    ${number}    Row Count    ${queryString}
    Disconnect From Database
    [Return]    ${number}

select name in the tree structure
    [Arguments]    ${name}    ${tableName}    ${initParent}
    [Documentation]    选中树形结构中的某一名称
    ...    参数：1.需要点击的名称；2.树形中名称所在的数据表名称；3.初始可用的父节点
    ${rows}    get rows of database table    SELECT * FROM ${tableName};
    ${parentList}    Create List    @{EMPTY}
    ${parentName}    Set Variable    ${name}
    : FOR    ${i}    IN RANGE    ${rows}
    \    Exit For Loop If    '${parentName}'=='${initParent}'
    \    ${parentName}    get return value of the database query    SELECT PARENT_NAME FROM ${tableName} WHERE NAME='${parentName}';
    \    Exit For Loop If    '${parentName}'=='${initParent}'
    \    Insert Into List    ${parentList}    0    ${parentName}
    ${len}    Get Length    ${parentList}
    : FOR    ${i}    IN RANGE    ${len}
    \    Click Element    //a[@title='${parentList[${i}]}']/../span
    \    Sleep    ${clickSleep}
    \    Exit For Loop If    '${i}'=='${len-1}'
    \    Wait Until Element Is Visible    //a[@title='${parentList[${i+1}]}']
    Wait Until Element Is Visible    //a[@title='${name}']
    Click Element    //a[@title='${name}']

login by new tab
    [Arguments]    ${user}    ${password}    ${realName}=None    ${ip}=default
    [Documentation]    在新的标签页上登录用户(在当前使用的浏览器中)
    ...    参数：1.登录用户；2.登录密码(返回值为该浏览器所有窗口的handle)；
    ...    3.真实姓名(默认不验证)
    ${ipNew}    Set Variable If    '${ip}'=='default'    ${vc_ip}
    ...     '${ip}'!='default'    ${ip}   
    Execute Javascript    window.open("https://${ipNew}","_blank")
    ${win_handle_list}    List Windows
    Select Window    ${win_handle_list[-1]}    
    input login user    ${user}
    input login password    ${password}
    click login button
    ${status}    Run Keyword And Return Status    verify login success    ${user}    realName=${realName}
    Should Be Equal As Strings    ${status}    True
    [Teardown]    Run Keyword If    '${status}'=='False'    Select Window    ${win_handle_list[0]}
    [Return]    ${win_handle_list}

open hsdb database
    [Documentation]    该关键字是连接hsdb数据库，使用后注意关闭数据库（Disconnect From Database）
    Connect To Database Using Custom Params    pymysql    database='hsdb', host='${vc_ip}', user='root',password='${vc_mysql_pwd}',port=3306,charset='utf8'

open the search UI
    [Documentation]    打开搜索界面
    Mouse Over    ${search_icon_ID}
    Sleep    ${clickSleep}
    Wait Until Element Is Visible    ${search_button_ID}    error=鼠标放在搜索图标上后搜索按钮不可见

open vtopcenter
    [Documentation]    浏览器打开vTopCenter,然后窗口最大化
    Open Browser    https://${vc_ip}    ${test_browser}
    Maximize Browser Window
    Wait Until Element Is Visible    ${login_title_ID}    error=登录框title不可见
    Wait Until Element Is Visible    ${login_vtopimg_ID}    error=登录界面vtopcenter图片不可见

refresh page
    [Documentation]    刷新当前页面
    : FOR    ${i}    IN RANGE    3
    \    Reload Page
    \    ${status2}    Run Keyword And Return Status    Wait Until Element Is Not Visible    ${loading_img_ID}    5
    \    Continue For Loop If    '${status2}'=='False'
    \    ${status3}    Run Keyword And Return Status    Wait Until Element Is Not Visible    ${loading_img2_ID}    5        
    \    Continue For Loop If    '${status2}'=='False'
    \    ${status1}    Run Keyword And Return Status    Click Element    ${homepage_tab_ID}
    \    Exit For Loop If    '${status1}'=='True'

scroll to the bottom
    [Documentation]    滚动条滚到底部
    Unselect Frame
    Execute Javascript    window.scrollTo(0,10000000)
    Sleep    ${clickSleep}

select table checkbox on UI
    [Arguments]    ${number}=99999
    [Documentation]    在界面上选择所有的CheckBox
    ...    参数：选择CheckBox的个数，默认选择所有CheckBox
    : FOR    ${i}    IN RANGE    1
    \    Exit For Loop If    '${number}'!='99999'
    \    Select Checkbox    ${public_selectall_ID}
    \    Sleep    ${selectsleep}
    \    Checkbox Should Be Selected    ${public_selectall_ID}
    ${elementId}    Get Webelements    //tbody//input[@type='checkbox']
    : FOR    ${i}    IN RANGE    ${number}
    \    Exit For Loop If    '${number}'=='99999'
    \    Select Checkbox    ${elementId[${i}]}
    \    Sleep    ${selectsleep}
    \    Checkbox Should Be Selected    ${elementId[${i}]}

verify search label info on the UI
    [Arguments]    @{txt_list}
    [Documentation]    管理界面搜索栏信息验证
    ...    参数：搜索栏文字(可为一个也可为列表)
    verify same element text by UI    ${public_search_label_ID}    @{txt_list}
    verify element text    ${search_button_ID}    ${searchButton}

verify input box character limit
    [Arguments]    ${locator}    ${limit}
    [Documentation]    输入框字符数限制验证
    ...    参数：1.输入框定位，2.字符限制数
    ${limitNum}    Get Element Attribute    ${locator}@maxlength
    Should Be Equal As Integers    ${limitNum}    ${limit}    msg=输入框字符限制数"${limit}"与实际值"${limitNum}"不相等

verify confirm box info
    [Arguments]    ${msg}    ${title}=default    ${confirm}=default    ${cancel}=default
    [Documentation]    验证页面弹窗信息（比如：点击删除按钮的弹窗）
    ...    参数：1.弹窗提示信息；2.弹窗标题(默认值:友情提示)；
    ...    3.确定按钮信息(默认值:确定，如果是None表示不要验证该信息)；
    ...    4.取消按钮信息(默认值:取消，如果是None表示不要验证该信息)
    Unselect Frame
    Wait Until Element Is Visible    ${popup_box_text_ID}    error=弹窗不可见
    ${titleNew}    Set Variable If    '${title}'=='default'    ${confirmTitle}    '${title}'!='default'    ${title}
    ${confirmNew}    Set Variable If    '${confirm}'=='default'    ${confirmBtn1}    '${confirm}'!='default'    ${confirm}
    ${cancelNew}    Set Variable If    '${cancel}'=='default'    ${confirmBtn2}    '${cancel}'!='default'    ${cancel}
    verify element text    ${popup_title_ID}    ${titleNew}
    verify element text    ${popup_box_text_ID}    ${msg}
    Run Keyword If    '${confirm}'!='None'    verify element text    ${popup_confirm_ID}    ${confirmNew}
    Run Keyword If    '${cancel}'!='None'    verify element text    ${popup_cancel_ID}    ${cancelNew}

verify confirm not exist
    [Documentation]    验证确认弹窗页面不存在
    Unselect Frame
    Wait Until Element Is Not Visible    ${popup_box_text_ID}    error=弹窗仍可见
    Wait Until Element Is Visible    ${main_welcome_button}    error=弹窗消失后界面上"欢迎 xxx"不可见

verify element value attribute value
    [Arguments]    ${locator}    ${value}
    [Documentation]    验证某元素的value属性值
    ...    参数：1.元素的定位；2.value验证的值
    ${valueStr}    Get Element Attribute    ${locator}@value
    ${valueStr}    Strip String    ${valueStr}
    Should Be Equal As Strings    ${valueStr}    ${value}    msg=vlaue属性值"${value}"与实际值"${valueStr}"不相等

verify element placeholder attribute value
    [Arguments]    ${locator}    ${value}
    [Documentation]    验证某元素的placeholder属性值
    ...    参数：1.元素的定位；2.placeholder验证的值
    ${valueStr}    Get Element Attribute    ${locator}@placeholder
    ${valueStr}    Strip String    ${valueStr}
    Should Be Equal As Strings    ${valueStr}    ${value}    msg=placeholder属性值"${value}"与实际值"${valueStr}"不相等

verify element title attribute value
    [Arguments]    ${locator}    ${titleValue}
    [Documentation]    验证某元素title属性值
    ...    参数：1.元素定位器；2.title的值
    ${titleStr}    Get Element Attribute    ${locator}@title
    ${titleStr}    Strip String    ${titleStr}
    Should Be Equal As Strings    ${titleStr}    ${titleValue}    msg=title属性值"${titleValue}"与实际值"${titleStr}"不相等

verify lay UI not exit
    [Documentation]    验证layer界面不可见
    Unselect Frame
    Wait Until Element Is Not Visible    ${layui_title_ID}    error=layer界面title仍可见
    Wait Until Element Is Visible    ${main_welcome_button}    error=“欢迎 xxx”不可见

verify lay UI title info
    [Arguments]    ${title1}    ${title2}=default    ${status}=True
    [Documentation]    验证layer界面title信息和按钮信息
    ...    参数：1.layer的title即第一个title；2.第二个title(默认与第一个title相同)；3.是否有保存和取消按钮(默认是有)
    ${title2New}    Set Variable If    '${title2}'=='default'    ${title1}    '${title2}'!='default'    ${title2}
    Unselect Frame
    verify element text    ${layui_title_ID}    ${title1}
    Run Keyword If    '${status}'=='True'    verify element text    ${layui_save_button_ID}    ${saveButton}
    Run Keyword If    '${status}'=='True'    verify element text    ${layui_cancel_button_ID}    ${cancelButton}
    Select Frame    ${layui_iframe_ID}
    verify element text    ${layui_title2_ID}    ${title2New}

verify lobibox info
    [Arguments]    ${msg}=default    ${msgStatus}=True
    [Documentation]    操作后右下角lobibox的标题和具体提示信息
    ...    参数：1.lobibox的具体信息(默认为操作成功)，2.是否有msg(默认有msg)
    Unselect Frame
    ${titleNew}    Set Variable If    '${msg}'!='default'    ${lobiTitle2}    '${msg}'=='default'    ${lobiTitle1}
    ${msgNew}    Set Variable If    '${msg}'!='default'    ${msg}    '${msg}'=='default'    ${lobiMsg1}
    Wait Until Element Is Visible    ${lobibox_body_ID}    error=右下角弹窗不可见
    verify element text    ${lobibox_title_ID}    ${titleNew}
    Run Keyword If    '${msgStatus}'=='True'    verify element text    ${lobibox_msg_ID}    ${msgNew}

verify same element text by UI
    [Arguments]    ${locator}    @{verifyText}
    [Documentation]    验证界面上相同元素的文本
    ...    参数：1.相同的元素的地址，2.待验证的信息组合(没有信息的用户${EMPTY})
    ${elements}    Get Webelements    ${locator}
    ${elementNum}    Get Length    ${elements}
    ${len1}    Get Length    ${verifyText}
    Should Be Equal As Integers    ${elementNum}    ${len1}    msg=待验证信息个数"${len1}"与locator获取的个数"${elementNum}"不一致
    : FOR    ${i}    IN RANGE    ${len1}
    \    Run Keyword And Continue On Failure    verify element text    ${elements[${i}]}    ${verifyText[${i}]}

verify table records current page
    [Arguments]    ${number}    ${table_locator}=default
    [Documentation]    验证当前页面table的记录条数
    ...    参数：1.验证的个数；2.table元素地址(默认值：css=#sample-table-2，格式需要与默认值相同)
    ${num}    get current table record number    ${table_locator}
    Should Be Equal As Numbers    ${num}    ${number}    msg=table中记录数${num}与期望值${number}不相等
    
wait until file upload down
    [Arguments]    ${timeout}=300
    [Documentation]    等待文件上传完成
    ...    参数：超时时间(默认为5分钟)
    Wait Until Element Is Visible    ${public_upFile_100%}    timeout=${timeout}
    ${txt}    Get Element Attribute    ${public_upFile_progress}@data-percent
    Should Be Equal As Strings    ${txt}    ${upFile['msg2']}    msg=等待${timeout}后，没有上传到100%    
    : FOR    ${i}    IN RANGE    1    10
    \    Sleep    ${i}
    \    ${text}    Get Text    ${public_upFile_prompt}
    \    Exit For Loop If    '${text}'=='${upFile['msg1']}'

verify main UI info
    [Documentation]    验证主页面信息
    verify same element text by UI    ${main_menulist_ID}    @{mainUI['menuText']}
    ${elements}    Get Webelements    ${main_menulist_ID}
    ${len}    Get Length    ${elements}
    ${subList}    Create List    ${mainUI['user']}    ${mainUI['vtop']}
    ...    ${mainUI['policy']}    ${mainUI['resouce']}    ${mainUI['auth']}
    ...    ${mainUI['log']}    ${mainUI['safe']}    ${mainUI['sys']}
    :FOR    ${i}    IN RANGE    1    ${len}
    \    Click Element    ${elements[${i}]}
    \    Wait Until Element Is Visible    //ul[@class='submenu nav-show']
    \    Sleep    ${clickSleep}       
    \    verify same element text by UI    //ul[@class='submenu nav-show']//a    @{subList[${i-1}]}
    Click Element    ${main_welcome_button}
    Sleep    ${clickSleep}
    verify same element text by UI    ${main_welcome_sublist}    @{mainUI['welcome']}
    Click Element    ${main_power_button}
    Sleep    ${clickSleep}
    verify same element text by UI    ${main_power_sublist}    @{mainUI['power']}
    verify element text    ${main_companyCN_ID}    ${mainUI['msg1']}
    verify element text    ${main_companyEN_ID}    ${mainUI['msg2']}     
    verify element text    ${main_authorization_ID}    ${mainUI['msg3']}
    verify element text    ${main_aboutMe_ID}    ${mainUI['msg4']}
    verify element title attribute value    ${main_power_button}    ${mainUI['title2']}
    ${elemens}    Get Webelements    //button[contains(@onclick,'quickClick')]
    ${len1}    Get Length    ${elemens}
    ${len2}    Get Length    ${mainUI['shortT']}
    Should Be Equal As Integers    ${len1}    ${len2}
    :FOR    ${i}    IN RANGE    ${len2}
    \    verify element title attribute value    //button[contains(@onclick,'quickClick${i+1}')]
    ...    ${mainUI['shortT'][${i}]}    
    
verify about me UI info
    [Documentation]    验证关于我们界面信息   
    ${infoList1}    Copy List    ${mainUI['info']}
    Set List Value    ${infoList1}    1    ${mainUI['info'][1]}${vc_version}
    verify element text    ${popup_title_ID}    ${mainUI['title1']}
    verify element text    ${popup_cancel_ID}    ${confirmBtn3}
    ${infoList2}    Get Text    ${popup_box_text_ID}
    ${infoList2}    Split String    ${infoList2}    \n
    :FOR    ${i}    ${j}    IN ENUMERATE    @{infoList2}
    \    ${j}    Strip String    ${j}
    \    Should Be Equal As Strings    ${j}    ${infoList1[${i}]}    

verify auth UI info
    [Documentation]    验证授权文件界面信息
    verify same element text by UI    ${main_auth_info_name}    @{mainUI['labelL2']}
    verify element text    ${main_auth_company_value}    ${mainUI['value1']}
    verify same element text by UI    ${main_auth_blue_label}    @{mainUI['labelL1']}    
    Unselect Frame
    verify element text    ${layui_title_ID}    ${mainUI['title3']}

verify home page UI info
    [Documentation]    我的主页界面信息验证
    verify same element text by UI    ${home_colour_label}    @{mainUI['labelL3']}
    verify same element text by UI    ${home_select_lable}    @{mainUI['labelL4']}