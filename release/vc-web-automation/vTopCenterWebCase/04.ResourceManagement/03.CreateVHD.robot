*** Settings ***
Suite Setup       login by admin
Suite Teardown    close browser and kill chrome process
Force Tags      ${vhdTag['default']}
Resource          ../../Keyword/ResourceManage/VhdKeywords.robot

*** Test Cases ***
镜像管理界面信息验证
    [Tags]    ${vhdTag['info']}
    [Setup]    create right vhd by UI    ${vhdTD['nameD']}
    into vhd manage UI
    verify vhd manage table info
    verify vhd manage other info
    [Teardown]    delete all vhd by UI

用快捷键打开镜像管理界面
    refresh page
    Click Element    //button[contains(@onclick,'quickClick4')]
    Wait Until Element Is Visible    ${vhd_manage_UI_ID}
    Select Frame    ${vhd_manage_iframe_ID}
    Wait Until Element Is Visible    ${vhd_create_button_ID}

创建镜像界面信息验证
    [Tags]    ${vhdTag['info']}
    into vhd manage UI
    click create vhd button
    verify create vhd UI info

创建镜像_上传文件为空
    [Tags]    ${vhdTag['create']}
    into vhd manage UI
    click create vhd button
    click save button
    verify vhd upload file error info    ${vhdUI['err5']}

创建镜像_镜像文件格式错误
    [Tags]    ${vhdTag['create']}
    into vhd manage UI
    click create vhd button
    : FOR    ${filePath}    IN    @{vhdTD['fileE']}
    \    choose upload vhd file by UI    ${filePath}
    \    Run Keyword And Continue On Failure    verify vhd upload file error info    ${vhdUI['err1']}

创建镜像_镜像文件格式正确
    [Tags]    ${vhdTag['create']}    smokeCase
    into vhd manage UI
    click create vhd button
    choose upload vhd file by UI    ${vhdTD['fileR']}
    click upload file button
    wait until file upload down
    input vhd name    ${vhdTD['nameD']}
    input vhd version    ${vhdTD['versionD']}
    click save button    True
    verify lobibox info
    verify vhd name exist on the UI    ${vhdTD['nameD']}
    [Teardown]    delete all vhd by UI

创建镜像_镜像名称为空
    [Tags]    ${vhdTag['create']}
    into vhd manage UI
    click create vhd button
    choose upload vhd file by UI    ${vhdTD['fileR']}
    click upload file button
    wait until file upload down
    input vhd name    ${EMPTY}
    input vhd version    ${vhdTD['versionD']}
    click save button
    verify vhd name error info    ${vhdUI['err3']}

创建镜像_镜像名称正确
    [Tags]    ${vhdTag['create']}    smokeCase
    : FOR    ${name}    IN    @{vhdTD['nameR']}
    \    into vhd manage UI
    \    click create vhd button
    \    choose upload vhd file by UI    ${vhdTD['fileR']}
    \    click upload file button
    \    wait until file upload down
    \    input vhd name    ${name}
    \    input vhd version    ${vhdTD['versionD']}
    \    click save button    True
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify vhd name exist on the UI    ${name}
    [Teardown]    delete all vhd by UI

创建镜像_镜像名称已存在
    [Tags]    ${vhdTag['create']}
    [Setup]    create right vhd by UI    ${defaultNameTD}2
    into vhd manage UI
    click create vhd button
    choose upload vhd file by UI    ${vhdTD['fileR']}
    click upload file button
    wait until file upload down
    input vhd name    ${defaultNameTD}2
    input vhd version    ${vhdTD['versionD']}
    click save button
    verify vhd name error info    ${vhdUI['err7']}

创建镜像_镜像名称忽略大小写
    [Tags]    ${vhdTag['create']}
    [Setup]    create right vhd by UI    ${defaultNameTD}3
    into vhd manage UI
    click create vhd button
    choose upload vhd file by UI    ${vhdTD['fileR']}
    click upload file button
    wait until file upload down
    ${upper}    Convert To Uppercase    ${defaultNameTD}3
    input vhd name    ${upper}
    input vhd version    ${vhdTD['versionD']}
    click save button
    verify vhd name error info    ${vhdUI['err7']}

创建镜像_版本为空
    [Tags]    ${vhdTag['create']}
    into vhd manage UI
    click create vhd button
    choose upload vhd file by UI    ${vhdTD['fileR']}
    click upload file button
    wait until file upload down
    input vhd name    ${vhdTD['nameD']}
    input vhd version    ${EMPTY}
    click save button
    verify vhd version error info    ${vhdUI['err4']}

创建镜像_版本正确
    [Tags]    ${vhdTag['create']}    smokeCase
    into vhd manage UI
    click create vhd button
    choose upload vhd file by UI    ${vhdTD['fileR']}
    click upload file button
    wait until file upload down
    input vhd name    ${vhdTD['nameD']}
    input vhd version    ${vhdTD['versionR']}
    click save button    True
    verify lobibox info
    verify vhd version on the UI    ${vhdTD['nameD']}    ${vhdTD['versionR']}
    [Teardown]    delete all vhd by UI

创建镜像_输入说明
    [Tags]    ${vhdTag['create']}    smokeCase
    into vhd manage UI
    click create vhd button
    choose upload vhd file by UI    ${vhdTD['fileR']}
    click upload file button
    wait until file upload down
    input vhd name    ${vhdTD['nameD']}
    input vhd version    ${vhdTD['versionD']}
    input vhd description    ${vhdTD['des']}
    click save button    True
    verify lobibox info
    [Teardown]    delete all vhd by UI

同步镜像
    [Tags]    smokeCase
    [Setup]    prepare env for sync vhd
    into vhd manage UI
    click get vhd button
    Wait Until Element Is Visible    //a[@title='${vhdUI['title18']}']
    Wait Until Element Is Visible    //a[@title='${vhdUI['title19']}']
    ${element1}    Get Webelement    //a[contains(@id,'syn')]
    verify element text    ${element1}    ${vhdUI['button6']}
    ${element2}    Get Webelement    //a[contains(@id,'del2')]
    verify element text    ${element2}    ${vhdUI['button7']}
    Click Element    ${element1}
    Wait Until Element Is Visible    //div[@data-percent='${vhdUI['title20']}']    300
    [Teardown]    Run Keywords    restore default parameter value by database    delete all vhd by UI
