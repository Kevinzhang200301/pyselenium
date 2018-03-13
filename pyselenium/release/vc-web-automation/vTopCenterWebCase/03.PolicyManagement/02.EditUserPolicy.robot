*** Settings ***
Suite Setup    prepare env for edit user policy
Suite Teardown    clear env for edit user policy
Force Tags    ${policyTag['Udefault']}
Resource          ../../Keyword/PolicyManage/UserPolicyKeywords.robot

*** Test Cases ***
编辑用户策略界面信息验证
    [Tags]    ${policyTag['Uinfo']}
    into userpolicy manage UI
    click edit user policy button    ${defaultNameTD}
    verify lay UI title info    ${policyUI['title14']}
    
编辑用户策略_不输入策略名称
    [Tags]    ${policyTag['Uedit']}
    into userpolicy manage UI
    click edit user policy button    ${defaultNameTD}
    input user policy name    ${EMPTY}
    click save button
    verify user policy name error msg    ${policyUI['err1']}

编辑用户策略_单引号
    [Tags]    ${policyTag['Uedit']}
    into userpolicy manage UI
    click edit user policy button    ${defaultNameTD}
    input user policy name    ${policyTD['nameE']}
    click save button
    verify user policy name error msg    ${policyUI['err2']}

编辑用户策略_策略名称已存在
    [Tags]    ${policyTag['Uedit']}
    into userpolicy manage UI
    click edit user policy button    ${defaultNameTD}
    input user policy name    ${editNameTD}
    click save button
    verify user policy name error msg    ${policyUI['err5']}    

编辑用户策略_策略名称忽略大小写
    [Tags]    ${policyTag['Uedit']}
    into userpolicy manage UI
    click edit user policy button    ${defaultNameTD}
    ${upper}    Convert To Uppercase    ${editNameTD}
    input user policy name     ${upper}
    click save button
    verify user policy name error msg    ${policyUI['err5']}

编辑用户策略_正确的策略名称
    [Tags]    ${policyTag['Uedit']}    smokeCase
    into userpolicy manage UI
    click edit user policy button    ${editNameTD}
    input user policy name    ${policyTD['nameR']}
    click save button    True
    verify lobibox info    
    verify user policy name by UI    ${policyTD['nameR']}

编辑用户策略_用户规则为空
    [Tags]    ${policyTag['Uedit']}    smokeCase
    into userpolicy manage UI
    click edit user policy button    ${defaultNameTD}
    unselect all userpolicy
    click save button    True
    verify lobibox info
    verify no rules on userPolicy manage UI    ${defaultNameTD}
    
编辑用户策略_先选用户数据漫游再选择多点
    [Tags]    ${policyTag['Uedit']}
    into userpolicy manage UI
    click edit user policy button    ${defaultNameTD}
    unselect all userpolicy
    select user policy    ${policyUI['ruleL'][-2]}    ${policyUI['ruleL'][2]}
    verify user policy rule error msg    ${policyUI['err4']}
    
编辑用户策略_先选系统数据漫游再选择多点
    [Tags]    ${policyTag['Uedit']}
    into userpolicy manage UI
    click edit user policy button    ${defaultNameTD}
    unselect all userpolicy
    select user policy    ${policyUI['ruleL'][-1]}    ${policyUI['ruleL'][2]}
    verify user policy rule error msg    ${policyUI['err4']}
    
编辑用户策略_先选择多点再选择用户数据漫游
    [Tags]    ${policyTag['Uedit']}
    into userpolicy manage UI
    click edit user policy button    ${defaultNameTD}
    unselect all userpolicy
    select user policy    ${policyUI['ruleL'][2]}    ${policyUI['ruleL'][-2]}
    verify user policy rule error msg    ${policyUI['err3']}
    
编辑用户策略_先选择多点再选择系统数据漫游
    [Tags]    ${policyTag['Uedit']}
    into userpolicy manage UI
    click edit user policy button    ${defaultNameTD}
    unselect all userpolicy
    select user policy    ${policyUI['ruleL'][2]}    ${policyUI['ruleL'][-1]}
    verify user policy rule error msg    ${policyUI['err3']}
    
编辑用户策略_用户规则在"备选"和"已选"间切换
    [Tags]    ${policyTag['Uedit']}
    into userpolicy manage UI
    click edit user policy button    ${defaultNameTD}
    unselect all userpolicy
    : FOR    ${rule}    IN    @{policyUI['ruleL']}
    \    select user policy    ${rule}
    \    unselect user policy    ${rule}
    
编辑用户策略_没有多点策略组合
    [Tags]    ${policyTag['Uedit']}    smokeCase
    into userpolicy manage UI
    click edit user policy button    ${defaultNameTD}
    unselect all userpolicy
    select user policy    @{policyUI['ruleL'][:2]}    @{policyUI['ruleL'][3:]}
    click save button    True
    verify lobibox info
    verify user policy rule by UI    ${defaultNameTD}
    ...    @{policyUI['ruleL'][:2]}    @{policyUI['ruleL'][3:]}

编辑用户策略_没有漫游策略组合
    [Tags]    ${policyTag['Uedit']}    smokeCase
    into userpolicy manage UI
    click edit user policy button    ${defaultNameTD}
    unselect all userpolicy
    select user policy    @{policyUI['ruleL'][:-2]}
    click save button    True
    verify lobibox info
    verify user policy rule by UI    ${defaultNameTD}
    ...    @{policyUI['ruleL'][:-2]}

编辑用户策略_输入策略说明
    [Tags]    ${policyTag['Uedit']}    smokeCase
    into userpolicy manage UI
    click edit user policy button    ${defaultNameTD}
    input user policy description    ${policyTD['nameR']}
    click save button    True
    verify lobibox info
    
删除用户策略_弹窗信息验证
    [Tags]    ${policyTag['Uinfo']}
    into userpolicy manage UI
    click delete user policy button    ${deleteNameTD}
    verify confirm box info    ${policyBox['msg1']}
    
删除用户策略_取消
    [Tags]    ${policyTag['Udel']}
    into userpolicy manage UI
    click delete user policy button    ${deleteNameTD}
    click confirm box cancel button
    verify confirm not exist
    
删除用户策略_确认
    [Tags]    ${policyTag['Udel']}
    into userpolicy manage UI
    click delete user policy button    ${deleteNameTD}
    click confirm box confirm button
    verify confirm not exist
    ${status}    Run Keyword And Return Status    verify user policy name by UI    ${policyTD['Name']['delete']}
    Should Be Equal As Strings    ${status}    False
    
删除用户策略_已分配用户
    [Tags]    ${policyTag['Udel']}
    into userpolicy manage UI
    click delete user policy button    ${defaultNameTD}
    click confirm box confirm button
    verify lobibox info    ${policyBox['msg2']}

搜索用户策略_不输入任何值点击搜索按钮
    [Tags]    ${policyTag['Usearch']}
    into userpolicy manage UI
    ${ply_num}    get current table record number
    input search user policy name    ${EMPTY}
    click search button
    verify table records current page    ${ply_num}    
        
搜索用户策略_不存在的用户策略搜索(包括特殊符号)
    [Tags]    ${policyTag['Usearch']}
    into userpolicy manage UI
    :FOR    ${name}    IN   @{searchNoName}
    \    input search user policy name    ${name}
    \    click search button
    \    verify table records current page    0

搜索用户策略_已存在用户策略
    [Tags]    ${policyTag['Usearch']}
    into userpolicy manage UI
    input search user policy name    ${searchNameList[2]}
    click search button
    verify table records current page    1
    
搜索用户策略_策略名称部分字段
    [Tags]    ${policyTag['Usearch']}
    into userpolicy manage UI
    input search user policy name    ${searchNameList[0]}
    click search button
    ${len}    Get Length    ${searchNameList}
    verify table records current page    ${len}         