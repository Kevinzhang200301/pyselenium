*** Settings ***
Suite Setup       login by admin
Suite Teardown    close browser and kill chrome process
Force Tags    ${policyTag['Udefault']}
Resource          ../../Keyword/PolicyManage/UserPolicyKeywords.robot

*** Test Cases ***
用户策略管理界面信息验证
    [Tags]    ${policyTag['Uinfo']}
    [Setup]    create right user policy by UI    ${defaultNameTD}1
    into userpolicy manage UI
    verify user policy manage UI info
    [Teardown]    delete all userpolicy by UI

新建用户策略界面信息验证
    [Tags]    ${policyTag['Uinfo']}
    into userpolicy manage UI
    click create user policy button
    verify create userPolicy UI info

新建用户策略_不输入策略名称
    [Tags]    ${policyTag['Ucreate']}
    into userpolicy manage UI
    click create user policy button
    input user policy name    ${EMPTY}
    click save button
    verify user policy name error msg    ${policyUI['err1']}

新建用户策略_策略名称有单引号
    [Tags]    ${policyTag['Ucreate']}
    into userpolicy manage UI
    click create user policy button
    input user policy name    ${policyTD['nameE']}
    click save button
    verify user policy name error msg    ${policyUI['err2']}

新建用户策略_策略名称已存在
    [Tags]    ${policyTag['Ucreate']}
    [Setup]    create right user policy by UI    ${defaultNameTD}2
    into userpolicy manage UI
    click create user policy button
    input user policy name     ${defaultNameTD}2
    click save button
    verify user policy name error msg    ${policyUI['err5']}
    [Teardown]    delete all userpolicy by UI

新建用户策略_策略名称忽略大小写
    [Tags]    ${policyTag['Ucreate']}
    [Setup]    create right user policy by UI    ${defaultNameTD}3
    into userpolicy manage UI
    click create user policy button
    ${upper}    Convert To Uppercase    ${defaultNameTD}3
    input user policy name     ${upper}
    click save button
    verify user policy name error msg    ${policyUI['err5']}
    [Teardown]    delete all userpolicy by UI

新建用户策略_正确的策略名称
    [Tags]    ${policyTag['Ucreate']}    smokeCase
    into userpolicy manage UI
    click create user policy button
    input user policy name    ${policyTD['nameR']}
    select user policy    ${policyUI['ruleL'][0]}
    click save button    True
    verify lobibox info    
    verify user policy name by UI    ${policyTD['nameR']}
    [Teardown]    delete all userpolicy by UI

新建用户策略_用户规则为空
    [Tags]    ${policyTag['Ucreate']}    smokeCase
    into userpolicy manage UI
    click create user policy button
    input user policy name    ${defaultNameTD}4
    click save button    True
    verify lobibox info
    verify no rules on userPolicy manage UI    ${defaultNameTD}4
    [Teardown]    delete all userpolicy by UI

新建用户策略_先选用户数据漫游再选择多点
    [Tags]    ${policyTag['Ucreate']}
    into userpolicy manage UI
    click create user policy button
    select user policy     ${policyUI['ruleL'][-2]}    ${policyUI['ruleL'][2]}
    verify user policy rule error msg    ${policyUI['err4']}

新建用户策略_先选系统数据漫游再选择多点
    [Tags]    ${policyTag['Ucreate']}
    into userpolicy manage UI
    click create user policy button
    select user policy    ${policyUI['ruleL'][-1]}    ${policyUI['ruleL'][2]}
    verify user policy rule error msg    ${policyUI['err4']}

新建用户策略_先选择多点再选择用户数据漫游
    [Tags]    ${policyTag['Ucreate']}
    into userpolicy manage UI
    click create user policy button
    select user policy    ${policyUI['ruleL'][2]}    ${policyUI['ruleL'][-2]}
    verify user policy rule error msg    ${policyUI['err3']}

新建用户策略_先选择多点再选择系统数据漫游
    [Tags]    ${policyTag['Ucreate']}
    into userpolicy manage UI
    click create user policy button
    select user policy    ${policyUI['ruleL'][2]}    ${policyUI['ruleL'][-1]}
    verify user policy rule error msg    ${policyUI['err3']}

新建用户策略_用户规则在"备选"和"已选"间切换
    [Tags]    ${policyTag['Ucreate']}
    into userpolicy manage UI
    click create user policy button
    : FOR    ${rule}    IN    @{policyUI['ruleL']}
    \    select user policy    ${rule}
    \    unselect user policy    ${rule}

新建用户策略_没有多点策略组合
    [Tags]    ${policyTag['Ucreate']}    smokeCase
    into userpolicy manage UI
    click create user policy button
    input user policy name    ${defaultNameTD}5
    select user policy    @{policyUI['ruleL'][:2]}    @{policyUI['ruleL'][3:]}
    click save button    True
    verify lobibox info
    verify user policy rule by UI    ${defaultNameTD}5
    ...    @{policyUI['ruleL'][:2]}    @{policyUI['ruleL'][3:]}
    [Teardown]    delete all userpolicy by UI

新建用户策略_没有数据漫游策略组合
    [Tags]    ${policyTag['Ucreate']}    smokeCase
    into userpolicy manage UI
    click create user policy button
    input user policy name    ${defaultNameTD}6
    select user policy    @{policyUI['ruleL'][:-2]}
    click save button    True
    verify lobibox info
    verify user policy rule by UI    ${defaultNameTD}6
    ...    @{policyUI['ruleL'][:-2]}
    [Teardown]    delete all userpolicy by UI

新建用户策略_输入策略说明
    [Tags]    ${policyTag['Ucreate']}    smokeCase
    into userpolicy manage UI
    click create user policy button
    input user policy name    ${defaultNameTD}7
    select user policy    ${policyUI['ruleL'][0]}
    input user policy description    ${policyTD['nameR']}
    click save button    True
    verify lobibox info
    [Teardown]    delete all userpolicy by UI

新建用户策略_取消按钮
    [Tags]    ${policyTag['Ucreate']}
    into userpolicy manage UI
    click create user policy button
    click cancle button
    verify create user policy UI not exist

新建用户策略_取消“x”
    [Tags]    ${policyTag['Ucreate']}
    into userpolicy manage UI
    click create user policy button
    click "x" button
    verify create user policy UI not exist