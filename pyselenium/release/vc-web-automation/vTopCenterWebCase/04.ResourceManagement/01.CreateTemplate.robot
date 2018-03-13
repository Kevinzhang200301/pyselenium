*** Settings ***
Suite Setup       prepare env for create template
Suite Teardown    clear env for create template
Force Tags      ${templateTag['default']}
Resource          ../../Keyword/ResourceManage/TemplateKeywords.robot

*** Test Cases ***
模板管理界面信息验证
    [Tags]    ${templateTag['info']}
    [Setup]    create right template by UI    ${tempTD['nameD']}
    into template manage UI
    verify template manage UI table info
    verify template manage UI other info
    [Teardown]    delete all template by UI

模板详细信息界面验证
    [Tags]    ${templateTag['info']}
    [Setup]    create right template by UI    ${tempTD['nameD']}51
    into template manage UI
    click template name on template manage UI    ${tempTD['nameD']}51
    verify template detail UI info    ${tempTD['nameD']}51    ${tempTD['vhdD']}
    [Teardown]    delete all template by UI

创建模板界面信息验证_前4个界面
    [Tags]    ${templateTag['info']}
    into template manage UI
    click create template button
    verify create template step1 UI
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    verify create template other info
    click next step    1
    verify create template other info
    verify create template step2 UI
    click next step    2
    verify create template other info
    : FOR    ${i}    IN RANGE    1    5
    \    verify create template step3 UI    ${i}
    click next step    3
    verify create template other info
    verify create template step4 UI

创建模板界面信息验证_第5个界面
    [Tags]    ${templateTag['info']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    click next step    1
    click next step    2
    click next step    3
    click next step    4
    verify create template step5 UI    ${tempTD['nameD']}    ${tempTD['vhdD']}
    verify create template other info

创建模板_镜像未选择
    [Tags]    ${templateTag['create']}
    into template manage UI
    click create template button
    click next step    1    False
    verify vhd select error info    ${tempUI['err1']}

创建模板_模板名称为空
    [Tags]    ${templateTag['create']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${EMPTY}
    click next step    1    False
    verify template name error info    ${tempUI['err3']}

创建模板_模板名称非法字段
    [Tags]    ${templateTag['create']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    : FOR    ${name}    IN    @{tempTD['nameE']}
    \    input template name    ${name}
    \    click next step    1    False
    \    Run Keyword And Continue On Failure    verify template name error info    ${tempUI['err2']}

创建模板_模板名称正确
    [Tags]    ${templateTag['create']}    smokeCase
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameR']}
    click next step    1
    click next step    2
    click next step    3
    click next step    4
    click next step    5
    verify lobibox info
    verify template name on the UI    ${tempTD['nameR']}
    verify template vhd name on the UI    ${tempTD['nameR']}    ${tempTD['vhdD']}
    [Teardown]    delete all template by UI

创建模板_模板名称重复
    [Tags]    ${templateTag['create']}
    [Setup]    create right template by UI    ${defaultNameTD}3
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${defaultNameTD}3
    click next step    1    False
    verify template name error info    ${tempUI['err19']}

创建模板_模板名称忽略大小写
    [Tags]    ${templateTag['create']}
    [Setup]    create right template by UI    ${defaultNameTD}5
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    ${upper}    Convert To Uppercase    ${defaultNameTD}5
    input template name    ${upper}
    click next step    1    False
    verify template name error info    ${tempUI['err19']}

创建模板_自定义前缀为空
    [Tags]    ${templateTag['create']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    select name rule for template    ${tempUI['selectL1'][-1]}
    input custom praefixum    ${EMPTY}
    click next step    1    False
    verify custom praefixum rule error info    ${tempUI['err4']}

创建模板_自定义前缀非法字符
    [Tags]    ${templateTag['create']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    select name rule for template    ${tempUI['selectL1'][-1]}
    : FOR    ${name}    IN    @{tempTD['customNameE1']}
    \    input custom praefixum    ${name}
    \    click next step    1    False
    \    verify custom praefixum rule error info    ${tempUI['err5']}

创建模板_自定义前缀大于7位
    [Tags]    ${templateTag['create']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    select name rule for template    ${tempUI['selectL1'][-1]}
    input custom praefixum    ${tempTD['customNameE2']}
    click next step    1    False
    verify custom praefixum rule error info    ${tempUI['err18']}

创建模板_自定义前缀正确
    [Tags]    ${templateTag['create']}    smokeCase
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    select name rule for template    ${tempUI['selectL1'][-1]}
    input custom praefixum    ${tempTD['customNameR']}
    click next step    1
    click next step    2
    click next step    3
    click next step    4
    click next step    5
    verify lobibox info
    [Teardown]    delete all template by UI

创建模板_其他命名规则
    [Tags]    ${templateTag['create']}    smokeCase
    ${len}    Get Length    ${tempUI['selectL1'][:-1]}
    : FOR    ${i}    IN RANGE    ${len}
    \    into template manage UI
    \    click create template button
    \    select VHD for template    ${tempTD['vhdD']}
    \    input template name    ${i}
    \    select name rule for template    ${tempUI['selectL1'][${i}]}
    \    click next step    1
    \    click next step    2
    \    click next step    3
    \    click next step    4
    \    click next step    5
    \    verify lobibox info
    [Teardown]    delete all template by UI

创建模板_选择AD域
    [Tags]    ${templateTag['create']}    smokeCase
    [Setup]    create right ad    ${tempTD['adD']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    select ad for template    ${tempTD['adD']}
    Run Keyword And Return Status    List Selection Should Be    ${tmpl_add1_select_nameRule_ID}    ${tempUI['selectL1'][0]}
    click next step    1
    click next step    2
    click next step    3
    click next step    4
    click next step    5
    verify lobibox info
    [Teardown]    Run Keywords    delete all template by UI    delete all ad by UI

创建模板_CPU数量
    [Tags]    ${templateTag['create']}    smokeCase
    ${len}    Get Length    ${tempUI['cpuNum']}
    : FOR    ${i}    IN RANGE    ${len}
    \    into template manage UI
    \    click create template button
    \    select VHD for template    ${tempTD['vhdD']}
    \    input template name    ${i}
    \    click next step    1
    \    select cpu number for template    ${tempUI['cpuNum'][${i}]}
    \    click next step    2
    \    click next step    3
    \    click next step    4
    \    click next step    5
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify template cpu number on the UI    ${i}    ${tempUI['cpuNum'][${i}]}
    [Teardown]    delete all template by UI

创建模板_内存为空
    [Tags]    ${templateTag['create']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    click next step    1
    input memory size    ${EMPTY}
    click next step    2    False
    verify momery size error info    ${tempUI['err6']}

创建模板_内存为负数
    [Tags]    ${templateTag['create']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    click next step    1
    input memory size    ${tempTD['memoryE1']}
    click next step    2    False
    verify momery size error info    ${tempUI['err16']}

创建模板_内存为非数字
    [Tags]    ${templateTag['create']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    click next step    1
    : FOR    ${size}    IN    @{tempTD['memoryE2']}
    \    input memory size    ${size}
    \    click next step    2    False
    \    Run Keyword And Continue On Failure    verify momery size error info    ${tempUI['err10']}

创建模板_内存不大于128
    [Tags]    ${templateTag['create']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    click next step    1
    input memory size    ${tempTD['memoryE3']}
    click next step    2    False
    verify momery size error info    ${tempUI['err8']}

创建模板_内存大于16*1024
    [Tags]    ${templateTag['create']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    click next step    1
    input memory size    ${tempTD['memoryE4']}
    click next step    2    False
    verify momery size error info    ${tempUI['err11']}

创建模板_内存大小正确
    [Tags]    ${templateTag['create']}    smokeCase
    ${len}    Get Length    ${tempTD['memoryR']}
    : FOR    ${i}    IN RANGE    ${len}
    \    into template manage UI
    \    click create template button
    \    select VHD for template    ${tempTD['vhdD']}
    \    input template name    ${i}
    \    click next step    1
    \    input memory size    ${tempTD['memoryR'][${i}]}
    \    click next step    2
    \    click next step    3
    \    click next step    4
    \    click next step    5
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify template memory size on the UI    ${i}    ${tempTD['memoryR'][${i}]}
    [Teardown]    delete all template by UI

创建模板_硬盘为空
    [Tags]    ${templateTag['create']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    click next step    1
    input disk size    ${EMPTY}
    click next step    2    False
    verify disk size error info    ${tempUI['err7']}

创建模板_硬盘为负数
    [Tags]    ${templateTag['create']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    click next step    1
    input disk size    ${tempTD['diskE1']}
    click next step    2    False
    verify disk size error info    ${tempUI['err17']}

创建模板_硬盘为非数字
    [Tags]    ${templateTag['create']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    click next step    1
    : FOR    ${size}    IN    @{tempTD['diskE2']}
    \    input disk size    ${size}
    \    click next step    2    False
    \    Run Keyword And Continue On Failure    verify disk size error info    ${tempUI['err12']}

创建模板_硬盘不大于5G
    [Tags]    ${templateTag['create']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    click next step    1
    input disk size    ${tempTD['diskE3']}
    click next step    2    False
    verify disk size error info    ${tempUI['err9']}

创建模板_内存大于4*1024G
    [Tags]    ${templateTag['create']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    click next step    1
    input disk size    ${tempTD['diskE4']}
    click next step    2    False
    verify disk size error info    ${tempUI['err13']}

创建模板_硬盘大小正确
    [Tags]    ${templateTag['create']}    smokeCase
    ${len}    Get Length    ${tempTD['diskR']}
    : FOR    ${i}    IN RANGE    ${len}
    \    into template manage UI
    \    click create template button
    \    select VHD for template    ${tempTD['vhdD']}
    \    input template name    ${i}
    \    click next step    1
    \    input disk size    ${tempTD['diskR'][${i}]}
    \    click next step    2
    \    click next step    3
    \    click next step    4
    \    click next step    5
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify template disk size on the UI    ${i}    ${tempTD['diskR'][${i}]}
    [Teardown]    delete all template by UI

创建模板_磁盘加密
    [Tags]    ${templateTag['create']}    smokeCase
    : FOR    ${i}    IN RANGE    1
    \    into template manage UI
    \    click create template button
    \    select VHD for template    ${tempTD['vhdD']}
    \    input template name    ${i}
    \    click next step    1
    \    select whether encrypt for disk    ${tempUI['diskEncry'][${i}]}
    \    click next step    2
    \    click next step    3
    \    click next step    4
    \    click next step    5
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify template disk encryption status on the UI    ${i}    ${tempUI['diskEncry'][${i}]}
    [Teardown]    delete all template by UI

创建模板_审计类型
    [Tags]    ${templateTag['create']}    smokeCase
    ${len}    Get Length    ${tempUI['auditType']}
    : FOR    ${i}    IN RANGE    ${len}
    \    into template manage UI
    \    click create template button
    \    select VHD for template    ${tempTD['vhdD']}
    \    input template name    ${i}
    \    click next step    1
    \    select audit for template    ${tempUI['auditType'][${i}]}
    \    click next step    2
    \    click next step    3
    \    click next step    4
    \    click next step    5
    \    Run Keyword And Continue On Failure    verify lobibox info
    [Teardown]    delete all template by UI

创建模板_禁用串并兼容模式
    [Tags]    ${templateTag['create']}    smokeCase
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${defaultNameTD}
    click next step    1
    select stubdom for template    ${tempUI['stubdom'][1]}
    click next step    2
    click next step    3
    click next step    4
    click next step    5
    Run Keyword And Continue On Failure    verify lobibox info
    [Teardown]    delete all template by UI

创建模板_启用串并兼容模式_未勾选串并口
    [Tags]    ${templateTag['create']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${defaultNameTD}
    click next step    1
    select stubdom for template    ${tempUI['stubdom'][0]}
    click next step    2    False
    verify tempalte stubdom error info    ${tempUI['err20']}

创建模板_启用串并兼容模式_清空
    [Tags]    ${templateTag['create']}
    Comment    into template manage UI
    Comment    click create template button
    Comment    select VHD for template    ${tempTD['vhdD']}
    Comment    input template name    ${defaultNameTD}
    Comment    click next step    1
    Comment    select stubdom for template    ${tempUI['stubdom'][0]}
    Comment    select table checkbox on UI    1
    Comment    click stubdom clear button
    Comment    click next step    2    False
    Comment    verify tempalte stubdom error info    ${tempUI['err20']}

创建模板_启用串并兼容模式_勾选一个串并口
    [Tags]    ${templateTag['create']}
    Comment    into template manage UI
    Comment    click create template button
    Comment    select VHD for template    ${tempTD['vhdD']}
    Comment    input template name    ${defaultNameTD}
    Comment    click next step    1
    Comment    select stubdom for template    ${tempUI['stubdom'][0]}
    Comment    select table checkbox on UI    1
    Comment    click next step    2
    Comment    click next step    3
    Comment    click next step    4
    Comment    click next step    5
    Comment    Run Keyword And Continue On Failure    verify lobibox info
    [Teardown]    delete all template by UI

创建模板_启用串并兼容模式_勾选全部串并口
    [Tags]    ${templateTag['create']}
    Comment    into template manage UI
    Comment    click create template button
    Comment    select VHD for template    ${tempTD['vhdD']}
    Comment    input template name    ${defaultNameTD}
    Comment    click next step    1
    Comment    select stubdom for template    ${tempUI['stubdom'][0]}
    Comment    ${num}    get current table record number    ${tmpl_add3_stubdom_table}
    Comment    select table checkbox on UI    ${num}
    Comment    click next step    2
    Comment    click next step    3
    Comment    click next step    4
    Comment    click next step    5
    Comment    Run Keyword And Continue On Failure    verify lobibox info
    [Teardown]    delete all template by UI

创建模板_没有选择网卡
    [Tags]    ${templateTag['create']}    smokeCase
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    click next step    1
    click next step    2
    disable the network for template
    click next step    3
    click next step    4
    click next step    5
    verify lobibox info
    verify template netCard number on the UI    ${tempTD['nameD']}    0
    [Teardown]    delete all template by UI

创建模板_启用网卡加密但未选择网络密钥
    [Tags]    ${templateTag['create']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    click next step    1
    click next step    2
    select network key for template    None
    click next step    3    False
    verify network card encrypt error info    ${tempUI['err14']}

创建模板_已选择网络密钥
    [Tags]    ${templateTag['create']}    smokeCase
    [Setup]    create right network key by UI    ${tempTD['netKeyR']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    click next step    1
    click next step    2
    select network key for template    ${tempTD['netKeyR']}
    click next step    3
    click next step    4
    click next step    5
    verify lobibox info
    [Teardown]    Run Keywords    delete all template by UI    delete all network key by UI

创建模板_启用VLAN但未选择具体VLAN
    [Tags]    ${templateTag['create']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    click next step    1
    click next step    2
    select vlan for template    None
    click next step    3    False
    verify vlan error info    ${tempUI['err15']}

创建模板_已选择具体VLAN
    [Tags]    ${templateTag['create']}    smokeCase
    [Setup]    create right vlan by UI    ${tempTD['vlanR']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    click next step    1
    click next step    2
    select vlan for template    ${tempTD['vlanR']}
    click next step    3
    click next step    4
    click next step    5
    verify lobibox info
    [Teardown]    Run Keywords    delete all template by UI    delete all vlan by UI

创建模板_NAT
    [Tags]    ${templateTag['create']}    smokeCase
    ${len}    Get Length    ${tempUI['phyCardL']}
    : FOR    ${i}    IN RANGE    ${len}
    \    into template manage UI
    \    click create template button
    \    select VHD for template    ${tempTD['vhdD']}
    \    input template name    ${i}
    \    click next step    1
    \    click next step    2
    \    select connection method for template    ${tempUI['connectL'][1]}
    \    Wait Until Element Is Not Visible    //div[@class='iplist_1']
    \    select physical card for template    ${tempUI['phyCardL'][${i}]}
    \    click next step    3
    \    click next step    4
    \    click next step    5
    \    verify lobibox info
    [Teardown]    delete all template by UI

创建模板_hostonly
    [Tags]    ${templateTag['create']}    smokeCase
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    click next step    1
    click next step    2
    select connection method for template    ${tempUI['connectL'][2]}
    Wait Until Element Is Not Visible    //div[@class='iplist_1']
    Wait Until Element Is Not Visible    //p[@class='ethlist_1']
    click next step    3
    click next step    4
    click next step    5
    verify lobibox info
    [Teardown]    delete all template by UI

创建模板_bridge
    [Tags]    ${templateTag['create']}    smokeCase
    [Setup]    create right network by UI    ${tempTD['netNameR']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    click next step    1
    click next step    2
    select connection method for template    ${tempUI['connectL'][0]}
    select bridge network for template    ${tempTD['netNameR']}
    click next step    3
    click next step    4
    click next step    5
    verify lobibox info
    [Teardown]    Run Keywords    delete all template by UI    delete all network by UI

创建模板_选择物理网卡
    [Tags]    ${templateTag['create']}    smokeCase
    ${len}    Get Length    ${tempUI['phyCardL']}
    : FOR    ${i}    IN RANGE    ${len}
    \    into template manage UI
    \    click create template button
    \    select VHD for template    ${tempTD['vhdD']}
    \    input template name    ${i}
    \    click next step    1
    \    click next step    2
    \    select physical card for template    ${tempUI['phyCardL'][${i}]}
    \    click next step    3
    \    click next step    4
    \    click next step    5
    \    verify lobibox info
    [Teardown]    delete all template by UI

创建模板_启用多张网卡
    [Tags]    ${templateTag['create']}    smokeCase
    ${len}    Get Length    ${tempUI['netCardNameL']}
    : FOR    ${i}    IN RANGE    1    ${len+1}
    \    into template manage UI
    \    click create template button
    \    select VHD for template    ${tempTD['vhdD']}
    \    input template name    ${i}
    \    click next step    1
    \    click next step    2
    \    enable the network for template    ${i}    True
    \    click next step    3
    \    click next step    4
    \    click next step    5
    \    verify lobibox info
    \    verify template netCard number on the UI    ${i}    ${i}
    [Teardown]    delete all template by UI

创建模板_选择设备策略
    [Tags]    ${templateTag['create']}    smokeCase
    [Setup]    create right device policy    ${tempTD['policyR']}
    into template manage UI
    click create template button
    select VHD for template    ${tempTD['vhdD']}
    input template name    ${tempTD['nameD']}
    click next step    1
    click next step    2
    click next step    3
    select device policy for template    ${tempTD['policyR']}
    click next step    4
    click next step    5
    verify lobibox info
    [Teardown]    Run Keywords    delete all template by UI    delete all device policy by UI
