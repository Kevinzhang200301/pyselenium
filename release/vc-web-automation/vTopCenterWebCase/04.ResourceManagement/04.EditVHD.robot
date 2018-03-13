*** Settings ***
Suite Setup       prepare env for edit vhd
Suite Teardown    clear env for edit vhd
Force Tags        ${vhdTag['default']}
Resource          ../../Keyword/ResourceManage/VhdKeywords.robot

*** Test Cases ***
编辑镜像界面信息验证
    [Tags]    ${vhdTag['info']}
    into vhd manage UI
    click edit vhd button    ${vhdTD['nameD']}
    verify edit vhd UI info

镜像详细信息界面验证
    [Tags]    ${vhdTag['info']}
    into vhd manage UI
    click vhd name for see detail info    ${vhdTD['nameD']}
    verify vhd detail UI info    ${vhdTD['nameD']}

编辑镜像_镜像名称为空
    [Tags]    ${vhdTag['edit']}
    into vhd manage UI
    click edit vhd button    ${vhdTD['nameD']}
    input vhd name    ${EMPTY}
    click save button
    verify vhd name error info    ${vhdUI['err3']}

编辑镜像_镜像名称正确
    [Tags]    ${vhdTag['edit']}    smokeCase
    ${nameNew}    Set Variable    ${vhdTD['editD']}
    : FOR    ${name}    IN    @{vhdTD['nameR']}
    \    into vhd manage UI
    \    click edit vhd button    ${nameNew}
    \    input vhd name    ${name}
    \    click save button    True
    \    verify lobibox info
    \    verify vhd name exist on the UI    ${name}
    \    ${nameNew}    Set Variable    ${name}

编辑镜像_镜像名称已存在
    [Tags]    ${vhdTag['edit']}
    into vhd manage UI
    click edit vhd button    ${vhdTD['nameD']}
    input vhd name    ${vhdTD['srcName'][1]}
    click save button
    verify vhd name error info    ${vhdUI['err7']}

创建镜像_镜像名称忽略大小写
    [Tags]    ${vhdTag['edit']}
    into vhd manage UI
    click edit vhd button    ${vhdTD['nameD']}
    ${upper}    Convert To Uppercase    ${vhdTD['srcName'][0]}
    input vhd name    ${upper}
    click save button
    verify vhd name error info    ${vhdUI['err7']}

编辑镜像_版本为空
    [Tags]    ${vhdTag['edit']}
    into vhd manage UI
    click edit vhd button    ${vhdTD['nameD']}
    input vhd version    ${EMPTY}
    click save button
    verify vhd version error info    ${vhdUI['err4']}

编辑镜像_版本正确
    [Tags]    ${vhdTag['edit']}    smokeCase
    into vhd manage UI
    click edit vhd button    ${vhdTD['nameD']}
    input vhd version    ${vhdTD['versionR']}
    click save button    True
    verify lobibox info
    verify vhd version on the UI    ${vhdTD['nameD']}    ${vhdTD['versionR']}

编辑镜像_输入说明
    [Tags]    ${vhdTag['edit']}    smokeCase
    into vhd manage UI
    scroll to the bottom
    Select Frame    ${vhd_manage_iframe_ID}
    Wait Until Element Is Visible    ${vhd_create_button_ID}
    click edit vhd button    ${vhdTD['nameD']}
    input vhd description    ${vhdTD['des']}
    click save button    True
    verify lobibox info

合并镜像_未选择镜像
    [Tags]    ${vhdTag['megre']}
    into vhd manage UI
    click merge vhd button
    verify lobibox info    ${resBox['msg7']}

合并镜像_选择镜像时弹窗信息验证
    [Tags]    ${vhdTag['info']}
    into vhd manage UI
    select vhd in local table    ${vhdTD['nameD']}
    click merge vhd button
    verify confirm box info    ${vhdUI['msg2']}

合并镜像_选择镜像弹窗点击取消
    [Tags]    ${vhdTag['megre']}
    into vhd manage UI
    select vhd in local table    ${vhdTD['nameD']}
    click merge vhd button
    click confirm box cancel button
    verify confirm not exist

合并镜像_选择发布次数为1的镜像点击确定
    [Tags]    ${vhdTag['megre']}
    into vhd manage UI
    select vhd in local table    ${vhdTD['nameD']}
    click merge vhd button
    click confirm box confirm button
    verify lobibox info    ${resBox['msg9']}

设置桌面_未选择镜像
    [Tags]    ${vhdTag['desktop']}
    into vhd manage UI
    Click Element    ${vhd_desktop_button_ID}
    verify lobibox info    ${resBox['msg7']}

设置桌面_界面信息验证
    [Tags]    ${vhdTag['info']}
    into vhd manage UI
    select vhd in local table    ${vhdTD['nameD']}
    click set desktop button
    verify lay UI title info    ${vhdUI['title13']}    ${vhdUI['title14']}
    verify desktop image number

设置桌面_选择镜像但未选择桌面图片
    [Tags]    ${vhdTag['desktop']}
    into vhd manage UI
    select vhd in local table    ${vhdTD['nameD']}
    click set desktop button
    click save button
    verify set desktop error info    ${vhdUI['err6']}

设置桌面_选择镜像并选择桌面图片
    [Tags]    ${vhdTag['desktop']}
    into vhd manage UI
    select vhd in local table    ${vhdTD['nameD']}
    click set desktop button
    select desktop image    ${vhdTD['imgNum']}
    click save button    True
    verify lobibox info

清理镜像_弹窗信息验证
    [Tags]    ${vhdTag['info']}
    into vhd manage UI
    click clear vhd button
    verify confirm box info    ${vhdUI['msg3']}

清理镜像_取消
    [Tags]    ${vhdTag['clear']}
    into vhd manage UI
    click clear vhd button
    click confirm box cancel button
    verify confirm not exist

清理镜像_确定
    [Tags]    ${vhdTag['clear']}
    into vhd manage UI
    click clear vhd button
    click confirm box confirm button
    verify lobibox info    ${resBox['msg6']}

获取镜像列表_没有配置上级VC
    [Tags]    ${vhdTag['getvc']}
    into vhd manage UI
    click get vhd button
    verify lobibox info    ${resBox['msg10']}

搜索镜像_不输入任何值
    [Tags]    ${vhdTag['search']}
    into vhd manage UI
    ${num}    get current table record number    ${vhd_local_table_ID}
    input search vhd name    ${EMPTY}
    click search button
    verify table records current page    ${num}    ${vhd_local_table_ID}

搜索镜像_不存在的镜像
    [Tags]    ${vhdTag['search']}
    into vhd manage UI
    : FOR    ${text}    IN    @{searchNoName}
    \    input search vhd name    ${text}
    \    click search button
    \    Run Keyword And Continue On Failure    verify table records current page    0    ${vhd_local_table_ID}

搜索镜像_已存在的镜像
    [Tags]    ${vhdTag['search']}
    into vhd manage UI
    input search vhd name    ${searchNameList[1]}
    click search button
    verify table records current page    1    ${vhd_local_table_ID}

搜索镜像_已存在镜像的部分字段
    [Tags]    ${vhdTag['search']}
    into vhd manage UI
    ${len}    Get Length    ${searchNameList}
    input search vhd name    ${searchNameLIst[0]}
    click search button
    verify table records current page    ${len}    ${vhd_local_table_ID}

删除镜像_弹窗界面信息验证
    [Tags]    ${vhdTag['info']}
    into vhd manage UI
    click delete vhd button    ${vhdTD['del']}
    verify confirm box info    ${vhdUI['msg5']}

删除镜像_取消
    [Tags]    ${vhdTag['del']}
    into vhd manage UI
    click delete vhd button    ${vhdTD['del']}
    click confirm box cancel button
    verify confirm not exist

删除镜像_已分配模板
    [Tags]    ${vhdTag['del']}
    [Setup]    create right template by UI    ${defaultNameTD}1    vhdName=${vhdTD['nameD']}
    into vhd manage UI
    scroll to the bottom
    Select Frame    ${vhd_manage_iframe_ID}
    Wait Until Element Is Visible    ${vhd_create_button_ID}
    click delete vhd button    ${vhdTD['nameD']}
    click confirm box confirm button
    verify lobibox info    ${resBox['msg17']}

删除镜像_确定
    [Tags]    ${vhdTag['del']}
    into vhd manage UI
    click delete vhd button    ${vhdTD['del']}
    click confirm box confirm button
    ${status}    Run Keyword And Return Status    verify vhd name exist on the UI    ${deviceTD['del']}
    Should Be Equal As Strings    ${status}    False

镜像回滚_弹窗信息验证
    [Tags]    ${vhdTag['info']}
    into vhd manage UI
    click rollback vhd button    ${vhdTD['nameD']}
    verify confirm box info    ${vhdUI['msg4']}

镜像回滚_取消
    [Tags]    ${vhdTag['rollback']}
    into vhd manage UI
    click rollback vhd button    ${vhdTD['nameD']}
    click confirm box cancel button
    verify confirm not exist

镜像回滚_镜像发布一次点击确定
    [Tags]    ${vhdTag['rollback']}
    into vhd manage UI
    click rollback vhd button    ${vhdTD['nameD']}
    click confirm box confirm button
    verify lobibox info    ${resBox['msg8']}
