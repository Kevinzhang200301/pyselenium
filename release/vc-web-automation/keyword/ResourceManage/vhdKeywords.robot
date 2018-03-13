*** Settings ***
Resource          ../PublicKeywords.robot
Resource          ../../ElementLocators/ResourceElementID.robot
Resource          ../../Keyword/ResourceManage/TemplateKeywords.robot
Resource          ../SystemManage/RankManageKeywords.robot
Resource          ../SystemManage/ParameterSettingKeywords.robot
Variables         ../../TestData/ResourceTestData.py

*** Keywords ***
choose upload vhd file by UI
    [Arguments]    ${filePath}
    [Documentation]    选择上传的镜像文件
    ...    参数：镜像文件绝对路径
    Choose File    ${vhd_create_selectFile_ID}    ${filePath}

clear env for edit vhd
    [Documentation]    清空编辑镜像环境：1.删除镜像；2.关闭浏览器
    delete all template by UI
    delete all vhd by UI
    close browser and kill chrome process

click vhd name for see detail info
    [Arguments]    ${vhdName}
    [Documentation]    点击镜像名称，查看镜像的详细信息
    ...    参数：镜像名称
    ${nameId}    get vhd id by database    ${vhdName}
    Click Element    //a[contains(@href,'seeDetail(${nameId})')]
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${layui_title2_ID}

click clear vhd button
    [Documentation]    点击清理镜像按钮
    Wait Until Element Is Visible    ${vhd_clear_button_ID}
    Click Element    ${vhd_clear_button_ID}

click create vhd button
    [Documentation]    点击创建镜像按钮
    Click Element    ${vhd_create_button_ID}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${vhd_create_name_input_ID}

click delete vhd button
    [Arguments]    ${vhdName}
    [Documentation]    点击删除镜像按钮
    ...    参数：镜像名称
    ${nameId}    get vhd id by database    ${vhdName}
    Click Element    //a[contains(@onclick,'deletePatch(${nameId})')]

click download vhd button
    [Arguments]    ${vhdName}
    [Documentation]    点击下载镜像按钮
    ...    参数：镜像名称
    ${nameId}    get vhd id by database    ${vhdName}
    Click Element    //a[contains(@onclick,'downloadPatch(${nameId})')]

click edit vhd button
    [Arguments]    ${vhdName}
    [Documentation]    点击编辑镜像按钮
    ...    参数：镜像名称
    ${nameId}    get vhd id by database    ${vhdName}
    Click Element    //a[contains(@onclick,'editPatch(${nameId})')]
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${vhd_create_name_input_ID}

click get vhd button
    [Documentation]    点击获取镜像列表按钮
    scroll to the bottom
    Select Frame    ${vhd_manage_iframe_ID}
    Wait Until Element Is Visible    ${vhd_getVC_button_ID}
    Click Element    ${vhd_getVC_button_ID}

click merge vhd button
    [Documentation]    点击合并镜像按钮
    Wait Until Element Is Visible    ${vhd_merge_button_ID}
    Click Element    ${vhd_merge_button_ID}

click rollback vhd button
    [Arguments]    ${vhdName}
    [Documentation]    点击回滚镜像按钮
    ${nameId}    get vhd id by database    ${vhdName}
    Click Element    roll${nameId}

click set desktop button
    [Arguments]    ${staus}=True
    [Documentation]    点击设置桌面按钮
    ...    参数：点击按钮后是否有错误提示(默认没有)
    Wait Until Element Is Visible    ${vhd_desktop_button_ID}
    Click Element    ${vhd_desktop_button_ID}
    Unselect Frame
    : FOR    ${i}    IN    1
    \    Exit For Loop If    '${staus}'!='True'
    \    Wait Until Element Is Visible    ${layui_title_ID}
    \    Select Frame    ${layui_iframe_ID}
    \    Wait Until Element Is Visible    ${vhd_desktop_UI_ID}

click upload file button
    [Documentation]    点击上传文件按钮(创建镜像界面浏览文件后的上传按钮)
    Wait Until Element Is Visible    ${vhd_create_upButton_ID}
    Click Element    ${vhd_create_upButton_ID}

create right vhd by UI
    [Arguments]    ${vhdName}
    [Documentation]    在镜像管理界面正确上传镜像
    ...    参数：镜像名称
    into vhd manage UI
    click create vhd button
    Choose File    ${vhd_create_selectFile_ID}    ${vhdTD['fileR']}
    click upload file button
    wait until file upload down
    input vhd name    ${vhdName}
    input vhd version    ${vhdTD['versionD']}
    click save button    True
    verify vhd name exist on the UI    ${vhdName}

delete all vhd by UI
    [Documentation]    在界面上删除镜像文件
    into vhd manage UI
    ${len}    get rows of database table    SELECT id FROM resource_template_patch;
    : FOR    ${i}    IN RANGE    ${len}
    \    ${element}    Get Webelement    //a[contains(@onclick,'deletePatch')]
    \    Wait Until Element Is Enabled    ${element}
    \    Click Element    ${element}
    \    click confirm box confirm button
    \    Select Frame    ${vhd_manage_iframe_ID}

get vhd id by database
    [Arguments]    ${vdhName}
    [Documentation]    在数据库中获取vhd的ID
    ...    参数：镜像名称
    ${nameId}    get return value of the database query    SELECT id FROM resource_template_patch WHERE NAME='${vdhName}';
    [Return]    ${nameId}

input search vhd name
    [Arguments]    ${vhdName}
    [Documentation]    输入搜索镜像的名字
    ...    参数：镜像名称
    open the search UI
    Clear Element Text    ${vhd_search_input_ID}
    Input Text    ${vhd_search_input_ID}    ${vhdName}
    Sleep    ${inputSleep}

input vhd description
    [Arguments]    ${des}
    [Documentation]    输入镜像说明
    ...    参数：镜像说明
    Clear Element Text    ${vhd_create_description_ID}
    Input Text    ${vhd_create_description_ID}    ${des}
    Sleep    ${inputSleep}

input vhd name
    [Arguments]    ${vhdName}
    [Documentation]    输入镜像名称
    ...    参数：镜像名称
    Clear Element Text    ${vhd_create_name_input_ID}
    Input Text    ${vhd_create_name_input_ID}    ${vhdName}
    Sleep    ${inputSleep}

input vhd version
    [Arguments]    ${version}
    [Documentation]    输入镜像版本
    ...    参数：镜像版本
    Clear Element Text    ${vhd_create_version_input_ID}
    Input Text    ${vhd_create_version_input_ID}    ${version}
    Sleep    ${inputSleep}

into vhd manage UI
    [Documentation]    进入到镜像管理界面
    refresh page
    Wait Until Element Is Enabled    ${resource_manage_ID}
    Click Element    ${resource_manage_ID}
    Wait Until Element Is Visible    ${vhd_menu_ID}
    Click Element    ${vhd_menu_ID}
    Wait Until Element Is Visible    ${vhd_manage_UI_ID}
    Select Frame    ${vhd_manage_iframe_ID}
    Wait Until Element Is Visible    ${vhd_create_button_ID}

prepare env for edit vhd
    [Documentation]    为测试编辑镜像准备环境：1.admin用户登录；2.创建镜像
    login by admin
    create right vhd by UI    ${vhdTD['nameD']}
    : FOR    ${name}    IN    @{vhdTD['srcName']}
    \    create right vhd by UI    ${name}
    create right vhd by UI    ${vhdTD['editD']}
    create right vhd by UI    ${vhdTD['del']}

select desktop image
    [Arguments]    ${imgNumber}
    [Documentation]    选择第几张图片作为镜像桌面，参数为第几张(一共22张)
    ...    参数：桌面壁纸编号
    ${imgElements}    Get Webelements    ${vhd_desktop_imgs_ID}
    Convert To Integer    ${imgNumber}
    Click Image    ${imgElements[${imgNumber-1}]}
    Sleep    ${clickSleep}

select vhd in local table
    [Arguments]    ${vhdName}
    [Documentation]    在镜像管理界面的本地镜像中选择vhd
    ${nameId}    get vhd id by database    ${vhdName}
    ${nameId}    Convert To String    ${nameId}
    Select Radio Button    ${vhd_local_radio_name}    ${nameId}
    Sleep    ${selectSleep}
    Radio Button Should Be Set To    ${vhd_local_radio_name}    ${nameId}

verify create vhd UI info
    verify same element text by UI    ${vhd_create_label}    @{vhdUI['labelL']}
    verify input box character limit    ${vhd_create_name_input_ID}    ${vhdUI['len1']}
    verify input box character limit    ${vhd_create_version_input_ID}    ${vhdUI['len2']}
    verify lay UI title info    ${vhdUI['title2']}

verify desktop image number
    [Arguments]    ${imgNumber}=22
    [Documentation]    验证设置桌面界面图片数量
    ...    参数：桌面图片数量(默认值为22)
    ${imgElements}    Get Webelements    ${vhd_desktop_imgs_ID}
    ${len}    Get Length    ${imgElements}
    Should Be Equal As Numbers    ${len}    ${imgNumber}
    verify lay UI title info    ${vhdUI['title13']}    ${vhdUI['title14']}

verify edit vhd UI info
    verify same element text by UI    ${vhd_create_label}    @{vhdUI['editLabel']}
    verify input box character limit    ${vhd_create_name_input_ID}    ${vhdUI['len1']}
    verify input box character limit    ${vhd_create_version_input_ID}    ${vhdUI['len2']}
    verify lay UI title info    ${vhdUI['title3']}

verify set desktop error info
    [Arguments]    ${errMsg}
    [Documentation]    验证设置桌面错误提示信息
    ...    参数：错题提示信息
    Wait Until Element Is Visible    ${vhd_desktop_error_ID}
    verify element text    ${vhd_desktop_error_ID}    ${errMsg}

verify vhd manage other info
    [Documentation]    验证镜像管理界面其他信息
    Element Should Be Visible    //input[@value='${vhdUI['button1']}']
    Element Should Be Visible    //input[@value='${vhdUI['button2']}']
    Element Should Be Visible    //input[@value='${vhdUI['button3']}']
    Element Should Be Visible    //input[@value='${vhdUI['button4']}']
    Element Should Be Visible    //input[@value='${vhdUI['button5']}']
    Element Should Be Visible    //input[@title='${vhdUI['title4']}']
    Element Should Be Visible    //input[@title='${vhdUI['title5']}']
    Element Should Be Visible    //input[@title='${vhdUI['title6']}']
    Element Should Be Visible    //input[@title='${vhdUI['title7']}']
    Element Should Be Visible    //input[@title='${vhdUI['title8']}']
    open the search UI
    verify element text    ${vhd_search_label_ID}    ${vhdUI['srcLabel']}
    verify same element text by UI    ${public_manage_title_ID}    @{vhdUI['strongL']}
    : FOR    ${text}    IN    @{vhdUI['promptL']}
    \    Run Keyword And Continue On Failure    Element Should Contain    ${vhd_prompt_info_ID}    ${text}
    Unselect Frame
    verify element text    ${vhd_tab_ID}    ${vhdUI['title1']}

verify vhd manage table info
    [Documentation]    验证镜像管理界面table信息
    verify same element text by UI    ${vhd_local_table_head}    @{vhdUI['tableH1']}
    Element Should Be Visible    //a[@title='${vhdUI['title9']}']
    Element Should Be Visible    //a[@title='${vhdUI['title10']}']
    Element Should Be Visible    //a[@title='${vhdUI['title11']}']
    Element Should Be Visible    //a[@title='${vhdUI['title12']}']
    verify same element text by UI    ${vhd_topvc_table_head}    @{vhdUI['tableH2']}

prepare env for sync vhd
    [Documentation]    为测试同步上级vTopCenter镜像准备环境：1.上级vTopCenter配置分级管理；
    ...    2.在测试vTopCenter上配置好参数
    ${win}    login by new tab    ${vc_web_user}    ${vc_web_pwd}    ip=${vhdTD['upperVc']}    
    into rank manage UI
    open the search UI
    input search rank name    robot-${vhdTD['upperVc']}
    click search button
    ${status}    Run Keyword And Return Status    verify table records current page    0
    Run Keyword If    '${status}'=='True'    create right rank by UI
    ...    robot-${vhdTD['upperVc']}    https://${vc_ip}/    ${vhdTD['syncKey']}      
    Close Window
    Select Window    ${win[0]}
    ${win}    login by new tab    ${vc_web_user}    ${vc_web_pwd}
    into parameter setting manage UI
    ${valueList}    Create List    https://${vhdTD['upperVc']}/
    ...    https://${vc_ip}/    ${vhdTD['syncKey']}
    : FOR    ${i}    ${j}    IN ZIP    ${parameterUI['nameL'][1:4]}
    ...    ${valueList}
    \    into parameter setting manage UI
    \    ${id}    get return value of the database query
    ...    SELECT id FROM ulms_enumeration WHERE DESCRIPTION='${i}';
    \    Click Element    //a[contains(@onclick,'enumerationEdit(${id})')]
    \    Unselect Frame
    \    Wait Until Element Is Visible    ${layui_title_ID}
    \    Select Frame    ${layui_iframe_ID}
    \    Wait Until Element Is Visible    ${layui_title2_ID}
    \    input parameter value    ${j}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    Close Window
    [Teardown]    Select Window    ${win[0]}
    
verify vhd name error info
    [Arguments]    ${errMsg}
    [Documentation]    验证镜像名称错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${vhd_create_name_error_ID}
    verify element text    ${vhd_create_name_error_ID}    ${errMsg}

verify vhd name exist on the UI
    [Arguments]    ${vhdName}
    [Documentation]    在镜像管理界面本地镜像中验证某镜像存在
    ...    参数：镜像名称
    into vhd manage UI
    Table Column Should Contain    ${vhd_local_table_ID}    2    ${vhdName}

verify vhd upload file error info
    [Arguments]    ${errMsg}
    [Documentation]    验证上传错误格式文件提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${vhd_create_fileErr_ID}
    Element Should Contain    ${vhd_create_fileErr_ID}    ${errMsg}

verify vhd version error info
    [Arguments]    ${errMsg}
    [Documentation]    验证镜像版本错误提示信息
    ...    参数：错误提示信息
    Wait Until Element Is Visible    ${vhd_create_version_error_ID}
    verify element text    ${vhd_create_version_error_ID}    ${errMsg}

verify vhd version on the UI
    [Arguments]    ${vhdName}    ${version}
    [Documentation]    在镜像管理界面本地镜像中验证某镜像的系统版本
    ...    参数：1.镜像名称；2.镜像系统版本
    into vhd manage UI
    ${nameId}    get vhd id by database    ${vhdName}
    verify element text    //input[@value=${nameId}]/../../td[4]    ${version}

verify vhd detail UI info
    [Arguments]    ${vhdName}
    [Documentation]    镜像详细信息界面信息验证
    ...    参数：镜像名称
    verify same element text by UI    ${vhd_detail_name}    @{vhdUI['detalLabel']}    
    ${version}    get return value of the database query
    ...    SELECT template_version FROM resource_template_patch WHERE NAME='${vhdName}';
    ${pubUser}    get return value of the database query
    ...    SELECT published_name FROM resource_template_patch WHERE NAME='${vhdName}';
    ${pubTime}    get return value of the database query
    ...    SELECT published_time FROM resource_template_patch WHERE NAME='${vhdName}';
    ${parentUUID}    get return value of the database query
    ...    SELECT parent_uuid FROM resource_template_patch WHERE NAME='${vhdName}';
    ${vhdUUID}    get return value of the database query
    ...    SELECT uuid FROM resource_template_patch WHERE NAME='${vhdName}';
    ${value}    Create List    ${vhdName}    ${version}    ${pubUser}
    ...    ${pubTime}    0 B    ${parentUUID}    /storage/pool/${pubUser}/${parentUUID}/
    verify same element text by UI    ${vhd_detail_value}    @{value}
    verify same element text by UI    ${public_table_head}    @{vhdUI['tableH3']}
    verify same element text by UI    //td    ${vhdUUID}.vhd    0 B
    verify element title attribute value    //tr/th[1]    ${vhdUI['title15']}
    verify lay UI title info    ${vhdUI['title16']}    ${vhdUI['title17']}    False   