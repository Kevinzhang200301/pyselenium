*** Settings ***
Suite Setup       prepare env for edit patch
Suite Teardown    clear env for edit patch
Force Tags    ${patchTag['default']}
Resource          ../../Keyword/ResourceManage/UpgradePackageKeywords.robot

*** Test Cases ***
编辑升级包_界面信息验证
    [Tags]    ${patchTag['info']}
    into patch manage UI
    click edit patch button    ${patchTD['name']}
    verify lay UI title info    ${patchUI['title3']}

编辑升级包_升级包名称为空
    [Tags]    ${patchTag['edit']}
    into patch manage UI
    click edit patch button    ${patchTD['name']}
    input patch name    ${EMPTY}
    click save button
    verify path name error info    ${patchUI['msg8']}

编辑升级包_升级包版本为空
    [Tags]    ${patchTag['edit']}
    into patch manage UI
    click edit patch button    ${patchTD['name']}
    input patch version    ${EMPTY}
    click save button
    verify path version error info    ${patchUI['msg9']}

编辑升级包_输入升级包说明
    [Tags]    ${patchTag['edit']}    smokeCase
    into patch manage UI
    click edit patch button    ${patchTD['name']}
    input patch description    ${patchTD['description']}
    click save button    True
    verify lobibox info

编辑升级包_修改版本
    [Tags]    ${patchTag['edit']}    smokeCase
    into patch manage UI
    click edit patch button    ${patchTD['name']}
    input patch version    ${patchTD['editV']}
    click save button    True
    verify patch version by UI    ${patchTD['name']}    ${patchTD['editV']}

编辑升级包_修改升级包名称
    [Tags]    ${patchTag['edit']}    smokeCase
    into patch manage UI
    click edit patch button    ${patchTD['editN']}
    input patch name    ${patchTD['editR']}
    click save button    True
    verify patch name exist by UI    ${patchTD['editR']}

删除升级包_弹出窗口信息验证
    [Tags]    ${patchTag['info']}
    into patch manage UI
    click delete patch button    ${patchTD['name']}
    verify confirm box info    ${patchUI['msg10']}

删除升级包_取消
    [Tags]    ${patchTag['del']}
    into patch manage UI
    click delete patch button    ${patchTD['name']}
    click confirm box cancel button
    verify confirm not exist

删除升级包_确认
    [Tags]    ${patchTag['del']}
    into patch manage UI
    click delete patch button    ${patchTD['name']}
    click confirm box confirm button
    verify confirm not exist
    ${status}    Run Keyword And Return Status    verify patch name exist by UI    ${patchTD['name']}
    Should Be Equal As Strings    ${status}    False
