*** Settings ***
Suite Setup       prepare env for assign template
Suite Teardown    clear env for assign template
Force Tags    userManageCase
Resource          ../../Keyword/UserManage/UserKeywords.robot

*** Test Cases ***
分配模板_界面信息验证
    [Tags]    assignTemplateCase    userInfoCase
    into user management UI
    select user on the user manage UI    ${userTD['comName'][0]}
    click assign template button
    verify assign template UI info

分配模板_未勾选用户
    [Tags]    assignTemplateCase
    into user management UI
    click assign template button    False
    verify lobibox info    ${userBox['msg1']}

分配模板_勾选一个普通用户未选择模板
    [Tags]    assignTemplateCase
    into user management UI
    select user on the user manage UI    ${userTD['comName'][0]}
    click assign template button
    click save button
    verify lobibox info    ${userBox['msg2']}

分配模板_勾选一个普通用户选择一个模板
    [Tags]    assignTemplateCase
    into user management UI
    select user on the user manage UI    ${userTD['comName'][0]}
    click assign template button
    select template on assign template UI    ${userTD['tempName'][0]}
    click save button    True
    verify lobibox info
    verify user template number info on the UI    ${userTD['comName'][0]}    1

分配模板_勾选一个普通用户选择所有模板(包括加密模板)
    [Tags]    assignTemplateCase
    into user management UI
    ${len}    Get Length    ${userTD['tempName']}
    select user on the user manage UI    ${userTD['comName'][1]}
    click assign template button
    select table checkbox on UI
    click save button    True
    verify lobibox info
    verify user template number info on the UI    ${userTD['comName'][1]}    ${len}

分配模板_勾选一个发布者选择所有模板(包括加密模板)
    [Tags]    assignTemplateCase
    into user management UI
    ${len}    Get Length    ${userTD['tempName']}
    select user on the user manage UI    ${userTD['pubName']}
    click assign template button
    select table checkbox on UI
    click save button    True
    verify lobibox info
    verify user template number info on the UI    ${userTD['pubName']}    ${len-1}

分配模板_搜索已存在的模板名称
    [Tags]    assignTemplateCase
    into user management UI
    select user on the user manage UI    ${userTD['comName'][0]}
    click assign template button
    input assign template search name    ${userTD['tempName'][1]}
    click assign template search button
    verify table records current page    1

分配模板_搜索不存在的模板名称
    [Tags]    assignTemplateCase
    into user management UI
    select user on the user manage UI    ${userTD['comName'][0]}
    click assign template button
    : FOR    ${name}    IN    @{userTD['srcNoName']}
    \    input assign template search name    ${name}
    \    click assign template search button
    \    Run Keyword And Continue On Failure    verify table records current page    0

分配模板_搜索时输入模板名称部分字段
    [Tags]    assignTemplateCase
    into user management UI
    ${len}    Get Length    ${userTD['tempName']}
    select user on the user manage UI    ${userTD['comName'][0]}
    click assign template button
    input assign template search name    ${userTD['tempName'][0]}
    click assign template search button
    verify table records current page    ${len}

查看模板_界面信息验证
    [Tags]    seeTemplateCase    userInfoCase
    into user management UI
    verify see template UI info    ${userTD['nameD']}    ${userTD['tempName'][2]}

查看模板_模板详细信息验证
    [Tags]    seeTemplateCase    userInfoCase
    into user management UI
    click template number on user manage UI    ${userTD['nameD']}
    click template name on see template UI    ${userTD['nameD']}    ${userTD['tempName'][2]}
    verify template detail UI info of see template    ${userTD['tempName'][2]}

查看模板_设置开关机联动界面信息验证
    [Tags]    seeTemplateCase    userInfoCase
    into user management UI
    click template number on user manage UI    ${userTD['nameD']}
    click set auto button on see template UI    ${userTD['tempName'][0]}
    verify confirm box info    ${userBox['msg5'][:6]}${userTD['tempName'][0]}${userBox['msg5'][6:]}

查看模板_设置开关机联动取消
    [Tags]    seeTemplateCase
    into user management UI
    click template number on user manage UI    ${userTD['nameD']}
    click set auto button on see template UI    ${userTD['tempName'][0]}
    click confirm box cancel button
    verify confirm not exist

查看模板_设置开关机联动确定
    [Tags]    seeTemplateCase
    into user management UI
    click template number on user manage UI    ${userTD['nameD']}
    click set auto button on see template UI    ${userTD['tempName'][0]}
    click confirm box confirm button
    verify lobibox info    ${userBox['msg6'][:3]}${userTD['tempName'][0]}${userBox['msg6'][3:]}

查看模板_取消开关机联动界面信息验证
    [Tags]    seeTemplateCase    userInfoCase
    into user management UI
    click template number on user manage UI    ${userTD['nameD']}11
    click cancel auto button on see template UI    ${userTD['tempName'][1]}
    verify confirm box info    ${userBox['msg7'][:7]}${userTD['tempName'][1]}${userBox['msg7'][7:]}

查看模板_取消开关机联动取消
    [Tags]    seeTemplateCase
    into user management UI
    click template number on user manage UI    ${userTD['nameD']}11
    click cancel auto button on see template UI    ${userTD['tempName'][1]}
    click confirm box cancel button
    verify confirm not exist

查看模板_取消开关机联动确定
    [Tags]    seeTemplateCase
    into user management UI
    click template number on user manage UI    ${userTD['nameD']}11
    click cancel auto button on see template UI    ${userTD['tempName'][1]}
    click confirm box confirm button
    verify lobibox info    ${userBox['msg8'][:3]}${userTD['tempName'][1]}${userBox['msg8'][3:]}

查看模板_删除一个界面信息验证
    [Tags]    seeTemplateCase    userInfoCase
    into user management UI
    click template number on user manage UI    ${userTD['nameD']}
    click delete one button on see template UI    ${userTD['nameD']}    ${userTD['tempName'][1]}
    verify confirm box info    ${userBox['msg9']}

查看模板_删除一个取消
    [Tags]    seeTemplateCase
    into user management UI
    click template number on user manage UI    ${userTD['nameD']}
    click delete one button on see template UI    ${userTD['nameD']}    ${userTD['tempName'][1]}
    click confirm box cancel button
    verify confirm not exist

查看模板_删除一个确定
    [Tags]    seeTemplateCase
    into user management UI
    click template number on user manage UI    ${userTD['nameD']}
    click delete one button on see template UI    ${userTD['nameD']}    ${userTD['tempName'][1]}
    click confirm box confirm button
    Select Frame    ${tuser_seetmpl_iframe_ID}
    ${status}    Run Keyword And Return Status    Table Column Should Contain    ${public_table_ID}    2    ${userTD['tempName'][1]}
    Should Be Equal As Strings    ${status}    False

查看模板_删除多个未勾选模板
    [Tags]    seeTemplateCase
    into user management UI
    click template number on user manage UI    ${userTD['nameD']}
    click delete more button on see template UI
    verify lobibox info    ${userBox['msg10']}

查看模板_删除多个界面信息
    [Tags]    seeTemplateCase    userInfoCase
    into user management UI
    click template number on user manage UI    ${userTD['nameD']}
    select table checkbox on UI
    click delete more button on see template UI
    ${number}    get current table record number
    verify confirm box info    ${userBox['msg11'][:6]}${number}${userBox['msg11'][6:]}

查看模板_删除多个取消
    [Tags]    seeTemplateCase
    into user management UI
    click template number on user manage UI    ${userTD['nameD']}
    select table checkbox on UI
    click delete more button on see template UI
    click confirm box cancel button
    verify confirm not exist

查看模板_删除多个勾选一个确定
    [Tags]    seeTemplateCase
    into user management UI
    click template number on user manage UI    ${userTD['nameD']}
    select template on see template UI    ${userTD['nameD']}    ${userTD['tempName'][2]}
    click delete more button on see template UI
    click confirm box confirm button
    Sleep    5
    Select Frame    ${tuser_seetmpl_iframe_ID}
    ${status}    Run Keyword And Return Status    Table Column Should Contain    ${public_table_ID}    2    ${userTD['tempName'][2]}
    Should Be Equal As Strings    ${status}    False

查看模板_删除多个勾选所有
    [Tags]    seeTemplateCase
    into user management UI
    click template number on user manage UI    ${userTD['nameD']}
    select table checkbox on UI
    click delete more button on see template UI
    click confirm box confirm button
    Select Frame    ${tuser_seetmpl_iframe_ID}
    verify table records current page    0
