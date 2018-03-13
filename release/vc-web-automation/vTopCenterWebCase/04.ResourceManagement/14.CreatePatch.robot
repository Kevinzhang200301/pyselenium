*** Settings ***
Suite Setup    login by admin
Suite Teardown    close browser and kill chrome process
Force Tags    ${patchTag['default']}
Resource    ../../Keyword/ResourceManage/UpgradePackageKeywords.robot

*** Test Cases ***
升级包管理界面信息验证
    [Tags]    ${patchTag['info']}
    [Setup]    up right patch by UI    ${patchTD['name']}
    into patch manage UI
    verify patch manage UI info
    [Teardown]    delete all patch by UI
    
上传升级包界面信息验证
    [Tags]    ${patchTag['info']}
    into patch manage UI
    click upload patch button
    verify up patch UI info
    
上传升级包_未选择升级包
    [Tags]    ${patchTag['create']}
    into patch manage UI
    click upload patch button
    click save button
    verify patch error info    ${patchUI['msg5']}

上传升级包_升级包格式错误
    [Tags]    ${patchTag['create']}
    into patch manage UI
    click upload patch button
    :FOR    ${path}    IN    @{patchTD['errSuffix']}
    \    Choose File    ${up_package_choose_ID}    ${path}
    \    ${filePath}    ${file}    Split Path    ${path}    
    \    Run Keyword And Continue On Failure    verify patch error info    ${patchUI['msg6']}${file}   

上传升级包_升级包格式正确但内容错误
    [Tags]    ${patchTag['create']}
    into patch manage UI
    click upload patch button
    Choose File    ${up_package_choose_ID}    ${patchTD['errPatch']}
    click upload button
    verify patch error info    ${patchUI['msg7']}
    
上传升级包_升级包名称为空
    [Tags]    ${patchTag['create']}
    into patch manage UI
    click upload patch button
    Choose File    ${up_package_choose_ID}    ${patchTD['ritPatch']}
    click upload button
    wait until file upload down    
    input patch name    ${EMPTY}
    click save button
    verify path name error info    ${patchUI['msg8']}
    
上传升级包_版本为空
    [Tags]    ${patchTag['create']}
    into patch manage UI
    click upload patch button
    Choose File    ${up_package_choose_ID}    ${patchTD['ritPatch']}
    click upload button
    wait until file upload down    
    input patch version    ${EMPTY}
    click save button
    verify path version error info    ${patchUI['msg9']}
    
上传升级包_输入说明信息
    [Tags]    ${patchTag['create']}    smokeCase
    into patch manage UI
    click upload patch button
    Choose File    ${up_package_choose_ID}    ${patchTD['ritPatch']}
    click upload button
    wait until file upload down    
    input patch name    ${patchTD['name']}
    input patch description    ${patchTD['description']}
    click save button    True
    verify lobibox info    
    verify patch name exist by UI    ${patchTD['name']}
    [Teardown]    delete all patch by UI
    
上传升级包_取消“x”
    [Tags]    ${patchTag['create']}
    into patch manage UI
    click upload patch button
    click "x" button
    verify up patch UI not exist
    
上传升级包_取消按钮
    [Tags]    ${patchTag['create']}
    into patch manage UI
    click upload patch button
    click cancle button
    verify up patch UI not exist