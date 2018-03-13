*** Settings ***
Suite Setup       prepare env for edit template
Suite Teardown    clear env for edit template
Force Tags      ${templateTag['default']}
Resource          ../../Keyword/ResourceManage/TemplateKeywords.robot

*** Test Cases ***
编辑模板界面信息验证
    [Tags]    ${templateTag['info']}
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    verify lay UI title info    ${tempUI['title3']}    status=False

编辑模板_模板名称为空
    [Tags]    ${templateTag['edit']}
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    input template name    ${EMPTY}
    click next step    1    False
    verify template name error info    ${tempUI['err3']}

编辑模板_模板名称非法字段
    [Tags]    ${templateTag['edit']}
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    : FOR    ${name}    IN    @{tempTD['nameE']}
    \    input template name    ${name}
    \    click next step    1    False
    \    Run Keyword And Continue On Failure    verify template name error info    ${tempUI['err2']}

编辑模板_模板名称正确
    [Tags]    ${templateTag['edit']}    smokeCase
    into template manage UI
    click edit template button    ${tempTD['editD']}
    input template name    ${tempTD['nameR']}
    click next step    1
    click next step    2
    click next step    3
    click next step    4
    click next step    5
    verify lobibox info
    verify template name on the UI    ${tempTD['nameR']}

编辑模板_模板名称重复
    [Tags]    ${templateTag['edit']}
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    input template name    ${tempTD['srcName'][1]}
    click next step    1    False
    verify template name error info    ${tempUI['err19']}

编辑模板_模板名称忽略大小写
    [Tags]    ${templateTag['edit']}
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    ${upper}    Convert To Uppercase    ${tempTD['srcName'][2]}
    input template name    ${upper}
    click next step    1    False
    verify template name error info    ${tempUI['err19']}

编辑模板_自定义前缀为空
    [Tags]    ${templateTag['edit']}
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    select name rule for template    ${tempUI['selectL1'][-1]}
    input custom praefixum    ${EMPTY}
    click next step    1    False
    verify custom praefixum rule error info    ${tempUI['err4']}

编辑模板_自定义前缀非法字符
    [Tags]    ${templateTag['edit']}
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    select name rule for template    ${tempUI['selectL1'][-1]}
    : FOR    ${name}    IN    @{tempTD['customNameE1']}
    \    input custom praefixum    ${name}
    \    click next step    1    False
    \    verify custom praefixum rule error info    ${tempUI['err5']}

编辑模板_自定义前缀大于7位
    [Tags]    ${templateTag['edit']}
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    select name rule for template    ${tempUI['selectL1'][-1]}
    input custom praefixum    ${tempTD['customNameE2']}
    click next step    1    False
    verify custom praefixum rule error info    ${tempUI['err18']}

编辑模板_自定义前缀正确
    [Tags]    ${templateTag['edit']}    smokeCase
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    select name rule for template    ${tempUI['selectL1'][-1]}
    input custom praefixum    ${tempTD['customNameR']}
    click next step    1
    click next step    2
    click next step    3
    click next step    4
    click next step    5
    verify lobibox info

编辑模板_其他命名规则
    [Tags]    ${templateTag['edit']}    smokeCase
    ${len}    Get Length    ${tempUI['selectL1'][:-1]}
    : FOR    ${i}    IN RANGE    ${len}
    \    into template manage UI
    \    click edit template button    ${tempTD['nameD']}
    \    select name rule for template    ${tempUI['selectL1'][${i}]}
    \    click next step    1
    \    click next step    2
    \    click next step    3
    \    click next step    4
    \    click next step    5
    \    verify lobibox info

编辑模板_选择AD域
    [Tags]    ${templateTag['edit']}    smokeCase
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    select ad for template    ${tempTD['adD']}
    Run Keyword And Return Status    List Selection Should Be    ${tmpl_add1_select_nameRule_ID}    ${tempUI['selectL1'][0]}
    click next step    1
    click next step    2
    click next step    3
    click next step    4
    click next step    5
    verify lobibox info

编辑模板_CPU数量
    [Tags]    ${templateTag['edit']}    smokeCase
    : FOR    ${cpu}    IN    @{tempUI['cpuNum']}
    \    into template manage UI
    \    click edit template button    ${tempTD['nameD']}
    \    click next step    1
    \    select cpu number for template    ${cpu}
    \    click next step    2
    \    click next step    3
    \    click next step    4
    \    click next step    5
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify template cpu number on the UI    ${tempTD['nameD']}    ${cpu}

编辑模板_内存为空
    [Tags]    ${templateTag['edit']}
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    click next step    1
    input memory size    ${EMPTY}
    click next step    2    False
    verify momery size error info    ${tempUI['err6']}

编辑模板_内存为负数
    [Tags]    ${templateTag['edit']}
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    click next step    1
    input memory size    ${tempTD['memoryE1']}
    click next step    2    False
    verify momery size error info    ${tempUI['err16']}

编辑模板_内存为非数字
    [Tags]    ${templateTag['edit']}
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    click next step    1
    : FOR    ${size}    IN    @{tempTD['memoryE2']}
    \    input memory size    ${size}
    \    click next step    2    False
    \    Run Keyword And Continue On Failure    verify momery size error info    ${tempUI['err10']}

编辑模板_内存不大于128
    [Tags]    ${templateTag['edit']}
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    click next step    1
    input memory size    ${tempTD['memoryE3']}
    click next step    2    False
    verify momery size error info    ${tempUI['err8']}

编辑模板_内存大于16*1024
    [Tags]    ${templateTag['edit']}
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    click next step    1
    input memory size    ${tempTD['memoryE4']}
    click next step    2    False
    verify momery size error info    ${tempUI['err11']}

编辑模板_内存大小正确
    [Tags]    ${templateTag['edit']}    smokeCase
    : FOR    ${memory}    IN RANGE    @{tempTD['memoryR']}
    \    into template manage UI
    \    click edit template button    ${tempTD['nameD']}
    \    click next step    1
    \    input memory size    ${memory}
    \    click next step    2
    \    click next step    3
    \    click next step    4
    \    click next step    5
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify template memory size on the UI    ${tempTD['nameD']}    ${memory}

编辑模板_硬盘为空
    [Tags]    ${templateTag['edit']}
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    click next step    1
    input disk size    ${EMPTY}
    click next step    2    False
    verify disk size error info    ${tempUI['err7']}

编辑模板_硬盘为负数
    [Tags]    ${templateTag['edit']}
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    click next step    1
    input disk size    ${tempTD['diskE1']}
    click next step    2    False
    verify disk size error info    ${tempUI['err17']}

编辑模板_硬盘为非数字
    [Tags]    ${templateTag['edit']}
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    click next step    1
    : FOR    ${size}    IN    @{tempTD['diskE2']}
    \    input disk size    ${size}
    \    click next step    2    False
    \    Run Keyword And Continue On Failure    verify disk size error info    ${tempUI['err12']}

编辑模板_硬盘不大于5G
    [Tags]    ${templateTag['edit']}
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    click next step    1
    input disk size    ${tempTD['diskE3']}
    click next step    2    False
    verify disk size error info    ${tempUI['err9']}

编辑模板_内存大于4*1024G
    [Tags]    ${templateTag['edit']}
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    click next step    1
    input disk size    ${tempTD['diskE4']}
    click next step    2    False
    verify disk size error info    ${tempUI['err13']}

编辑模板_硬盘大小正确
    [Tags]    ${templateTag['edit']}    smokeCase
    : FOR    ${disk}    IN    @{tempTD['diskR']}
    \    into template manage UI
    \    click edit template button    ${tempTD['nameD']}
    \    click next step    1
    \    input disk size    ${disk}
    \    click next step    2
    \    click next step    3
    \    click next step    4
    \    click next step    5
    \    Run Keyword And Continue On Failure    verify lobibox info
    \    Run Keyword And Continue On Failure    verify template disk size on the UI    ${tempTD['nameD']}    ${disk}

编辑模板_审计类型
    [Tags]    ${templateTag['edit']}    smokeCase
    : FOR    ${type}    IN    @{tempUI['auditType']}
    \    into template manage UI
    \    click edit template button    ${tempTD['nameD']}
    \    click next step    1
    \    select audit for template    ${type}
    \    click next step    2
    \    click next step    3
    \    click next step    4
    \    click next step    5
    \    Run Keyword And Continue On Failure    verify lobibox info

编辑模板_串并兼容模式
    [Tags]    ${templateTag['edit']}    smokeCase
    Comment    : FOR    ${status}    IN    @{tempUI['stubdom']}
    Comment    \    into template manage UI
    Comment    \    click edit template button    ${tempTD['nameD']}
    Comment    \    click next step    1
    Comment    \    select stubdom for template    ${status}
    Comment    \    click next step    2
    Comment    \    click next step    3
    Comment    \    click next step    4
    Comment    \    click next step    5
    Comment    \    Run Keyword And Continue On Failure    verify lobibox info

编辑模板_没有选择网卡
    [Tags]    ${templateTag['edit']}    smokeCase
    into template manage UI
    click edit template button    ${tempTD['srcName'][2]}
    click next step    1
    click next step    2
    disable the network for template
    click next step    3
    click next step    4
    click next step    5
    verify lobibox info
    verify template netCard number on the UI    ${tempTD['srcName'][2]}    0

编辑模板_启用网卡加密但未选择网络密钥
    [Tags]    ${templateTag['edit']}
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    click next step    1
    click next step    2
    select network key for template    None
    click next step    3    False
    verify network card encrypt error info    ${tempUI['err14']}

编辑模板_已选择网络密钥
    [Tags]    ${templateTag['edit']}    smokeCase
    [Setup]    create right network key by UI    ${tempTD['netKeyR']}
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    click next step    1
    click next step    2
    select network key for template    ${tempTD['netKeyR']}
    click next step    3
    click next step    4
    click next step    5
    verify lobibox info

编辑模板_启用VLAN但未选择具体VLAN
    [Tags]    ${templateTag['edit']}
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    click next step    1
    click next step    2
    select vlan for template    None
    click next step    3    False
    verify vlan error info    ${tempUI['err15']}

编辑模板_已选择具体VLAN
    [Tags]    ${templateTag['edit']}    smokeCase
    [Setup]    create right vlan by UI    ${tempTD['vlanR']}
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    click next step    1
    click next step    2
    select vlan for template    ${tempTD['vlanR']}
    click next step    3
    click next step    4
    click next step    5
    verify lobibox info

编辑模板_NAT
    [Tags]    ${templateTag['edit']}    smokeCase
    : FOR    ${i}    IN    @{tempUI['phyCardL']}
    \    into template manage UI
    \    click edit template button    ${tempTD['srcName'][1]}
    \    click next step    1
    \    click next step    2
    \    select connection method for template    ${tempUI['connectL'][1]}
    \    Wait Until Element Is Not Visible    //div[@class='iplist_1']
    \    select physical card for template    ${i}
    \    click next step    3
    \    click next step    4
    \    click next step    5
    \    verify lobibox info

编辑模板_hostonly
    [Tags]    ${templateTag['edit']}    smokeCase
    into template manage UI
    click edit template button    ${tempTD['srcName'][0]}
    click next step    1
    click next step    2
    select connection method for template    ${tempUI['connectL'][2]}
    Wait Until Element Is Not Visible    //div[@class='iplist_1']
    Wait Until Element Is Not Visible    //p[@class='ethlist_1']
    click next step    3
    click next step    4
    click next step    5
    verify lobibox info

编辑模板_bridge
    [Tags]    ${templateTag['edit']}    smokeCase
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    click next step    1
    click next step    2
    select connection method for template    ${tempUI['connectL'][0]}
    select bridge network for template    ${tempTD['netNameR']}
    click next step    3
    click next step    4
    click next step    5
    verify lobibox info

编辑模板_选择物理网卡
    [Tags]    ${templateTag['edit']}    smokeCase
    : FOR    ${eth}    IN    @{tempUI['phyCardL']}
    \    into template manage UI
    \    click edit template button    ${tempTD['nameD']}
    \    click next step    1
    \    click next step    2
    \    select physical card for template    ${eth}
    \    click next step    3
    \    click next step    4
    \    click next step    5
    \    verify lobibox info

编辑模板_启用多张网卡
    [Tags]    ${templateTag['edit']}    smokeCase
    ${len}    Get Length    ${tempUI['netCardNameL']}
    : FOR    ${i}    IN RANGE    1    ${len+1}
    \    into template manage UI
    \    click edit template button    ${tempTD['nameD']}
    \    click next step    1
    \    click next step    2
    \    enable the network for template    ${i}    True
    \    select connection method for template    ${tempUI['connectL'][1]}    ${i}
    \    click next step    3
    \    click next step    4
    \    click next step    5
    \    verify lobibox info
    \    verify template netCard number on the UI    ${tempTD['nameD']}    ${i}

编辑模板_选择设备策略
    [Tags]    ${templateTag['edit']}    smokeCase
    into template manage UI
    click edit template button    ${tempTD['nameD']}
    click next step    1
    click next step    2
    click next step    3
    select device policy for template    ${tempTD['policyR']}
    click next step    4
    click next step    5
    verify lobibox info

分配用户界面信息验证
    [Tags]    ${templateTag['info']}
    into template manage UI
    select template    ${tempTD['nameD']}
    click assign users button
    verify assign user UI form info
    verify element text    ${tuser_assigntmpl_title}    ${tempUI['title15']}
    Unselect Frame
    verify element text    ${layui_title_ID}    ${tempUI['title15']}

分配用户_未选择模板
    [Tags]    ${templateTag['assign']}
    into template manage UI
    click assign users button    False
    verify lobibox info    ${resBox['msg11']}

分配用户_未选择用户
    [Tags]    ${templateTag['assign']}
    into template manage UI
    select template    ${tempTD['nameD']}
    click assign users button
    click save button
    verify lobibox info    ${resBox['msg12']}

分配用户_非加密模板勾选一个用户
    [Tags]    ${templateTag['assign']}    smokeCase
    into template manage UI
    select template    ${tempTD['nameD']}
    click assign users button
    select table checkbox on UI    1
    click save button    True
    verify lobibox info
    verify number of template users    ${tempTD['nameD']}    1

分配用户_非加密模板勾选多个用户
    [Tags]    ${templateTag['assign']}    smokeCase
    into template manage UI
    select template    ${tempTD['nameD']}
    click assign users button
    ${users}    get current table record number
    select table checkbox on UI
    click save button    True
    verify lobibox info
    verify number of template users    ${tempTD['nameD']}    ${users}

分配用户_加密模板勾选发布者
    [Tags]    ${templateTag['assign']}    smokeCase
    into template manage UI
    select template    ${defaultNameTD}6
    click assign users button
    select user for template    ${tempTD['userPub']}
    click save button    True
    verify lobibox info
    verify number of template users    ${defaultNameTD}6    0

分配用户_不输入任何值点击查询
    [Tags]    ${templateTag['assign']}
    into template manage UI
    select template    ${tempTD['nameD']}
    click assign users button
    ${num}    get current table record number
    click assign user search button
    verify table records current page    ${num}

分配用户_搜索不存在的用户名
    [Tags]    ${templateTag['assign']}
    into template manage UI
    select template    ${tempTD['nameD']}
    click assign users button
    : FOR    ${name}    IN    @{tempTD['srcNoName']}
    \    input assgin user name    ${name}
    \    click assign user search button
    \    verify table records current page    0

分配用户_搜索已存在完整用户名
    [Tags]    ${templateTag['assign']}
    into template manage UI
    select template    ${tempTD['nameD']}
    click assign users button
    input assgin user name    ${tempTD['userR'][1]}
    click assign user search button
    verify table records current page    1

分配用户_搜索已存在用户名的部分字段
    [Tags]    ${templateTag['assign']}
    into template manage UI
    select template    ${tempTD['nameD']}
    click assign users button
    ${len}    Get Length    ${tempTD['userR']}
    input assgin user name    ${tempTD['userR'][0]}
    click assign user search button
    verify table records current page    ${len}

分配用户_选择用户组
    [Tags]    ${templateTag['assign']}
    into template manage UI
    select template    ${tempTD['nameD']}
    click assign users button
    ${len}    Get Length    ${tempTD['userR']}
    select usergroup on layer UI    ${defaultNameTD}58
    click assign user search button
    verify table records current page    ${len}

分配用户_清空
    [Tags]    ${templateTag['assign']}
    into template manage UI
    select template    ${tempTD['nameD']}
    click assign users button
    ${len1}    get current table record number
    select usergroup on layer UI    ${defaultNameTD}58
    click assign user search button
    click assign users clear button
    click assign user search button
    verify table records current page    ${len1}
    ${len3}    get current table record number

使用情况界面信息验证
    [Tags]    ${templateTag['info']}
    into template manage UI
    select template    ${tempTD['nameD1']}
    click use situation button
    verify use situation UI table info
    verify use situation UI other info    ${tempTD['nameD1']}

使用情况_未勾选模板
    [Tags]    ${templateTag['use']}
    into template manage UI
    click use situation button    False
    verify lobibox info    ${resBox['msg16']}

使用情况_勾选多个模板
    [Tags]    ${templateTag['use']}
    into template manage UI
    Select Checkbox    ${public_selectall_ID}
    click use situation button    False
    verify lobibox info    ${resBox['msg13']}

使用情况_未勾选账户删除
    [Tags]    ${templateTag['use']}
    into template manage UI
    select template    ${tempTD['nameD1']}
    click use situation button
    click use situation delete button
    verify lobibox info    ${resBox['msg14']}

使用情况_未勾选账户设置开关机联动
    [Tags]    ${templateTag['use']}
    into template manage UI
    select template    ${tempTD['nameD1']}
    click use situation button
    click use situation setAuto button
    verify lobibox info    ${resBox['msg15']}

使用情况_设置开关机联动弹窗信息验证
    [Tags]    ${templateTag['info']}
    into template manage UI
    select template    ${tempTD['nameD1']}
    click use situation button
    select user for template    ${tempTD['userR'][0]}
    click use situation setAuto button
    verify confirm box info    ${tempUI['msg3']}

使用情况_设置开关机联动取消
    [Tags]    ${templateTag['use']}
    into template manage UI
    select template    ${tempTD['nameD1']}
    click use situation button
    select user for template    ${tempTD['userR'][0]}
    click use situation setAuto button
    click confirm box cancel button

使用情况_一个账号设置开关机联动确定
    [Tags]    ${templateTag['use']}
    into template manage UI
    select template    ${tempTD['nameD1']}
    click use situation button
    select user for template    ${tempTD['userR'][0]}
    click use situation setAuto button
    click confirm box confirm button
    verify confirm box info    ${tempUI['msg5']}    confirm=None    cancel=${tempUI['button12']}

使用情况_所有账号设置开关机联动确定
    [Tags]    ${templateTag['use']}    smokeCase
    into template manage UI
    select template    ${tempTD['nameD1']}
    click use situation button
    Select Checkbox    ${public_selectall_ID}
    click use situation setAuto button
    click confirm box confirm button
    verify confirm box info    ${tempUI['msg5']}    confirm=None    cancel=${tempUI['button12']}

使用情况_取消开关机联动弹窗信息验证
    [Tags]    ${templateTag['info']}
    into template manage UI
    select template    ${tempTD['nameD1']}
    click use situation button
    select user for template    ${tempTD['userR'][0]}
    click use situation cancelAuto button
    verify confirm box info    ${tempUI['msg4']}

使用情况_取消开关机联动取消
    [Tags]    ${templateTag['use']}
    into template manage UI
    select template    ${tempTD['nameD1']}
    click use situation button
    select user for template    ${tempTD['userR'][0]}
    click use situation cancelAuto button
    click confirm box cancel button

使用情况_一个账号取消开关机联动确定
    [Tags]    ${templateTag['use']}
    into template manage UI
    select template    ${tempTD['nameD1']}
    click use situation button
    select user for template    ${tempTD['userR'][0]}
    click use situation cancelAuto button
    click confirm box confirm button
    verify confirm box info    ${tempUI['msg6']}    confirm=None    cancel=${tempUI['button12']}

使用情况_所有账号取消开关机联动确定
    [Tags]    ${templateTag['use']}    smokeCase
    into template manage UI
    select template    ${tempTD['nameD1']}
    click use situation button
    Select Checkbox    ${public_selectall_ID}
    click use situation cancelAuto button
    click confirm box confirm button
    verify confirm box info    ${tempUI['msg6']}    confirm=None    cancel=${tempUI['button12']}

使用情况_删除弹窗信息验证
    [Tags]    ${templateTag['info']}
    into template manage UI
    select template    ${tempTD['nameD1']}
    click use situation button
    select user for template    ${tempTD['userR'][0]}
    click use situation delete button
    verify confirm box info    ${tempUI['msg2']}

使用情况_删除取消
    [Tags]    ${templateTag['use']}
    into template manage UI
    select template    ${tempTD['nameD1']}
    click use situation button
    select user for template    ${tempTD['userR'][0]}
    click use situation delete button
    click confirm box cancel button
    verify confirm not exist

使用情况_选择一个账号确定删除
    [Tags]    ${templateTag['use']}
    into template manage UI
    select template    ${tempTD['nameD1']}
    click use situation button
    select user for template    ${tempTD['userR'][0]}
    click use situation delete button
    click confirm box confirm button

使用情况_选择所有用户确定删除
    [Tags]    ${templateTag['use']}    smokeCase
    into template manage UI
    select template    ${tempTD['nameD1']}
    click use situation button
    Select Checkbox    ${public_selectall_ID}
    click use situation delete button
    click confirm box confirm button
    verify number of template users    ${tempTD['nameD1']}    0

搜索模板_不输入任何值
    [Tags]    ${templateTag['search']}
    into template manage UI
    ${len}    get current table record number
    input search template name    ${EMPTY}
    click search button
    verify table records current page    ${len}

搜索模板_不存在的名称
    [Tags]    ${templateTag['search']}
    into template manage UI
    : FOR    ${name}    IN    @{tempTD['srcNoName']}
    \    input search template name    ${name}
    \    click search button
    \    Run Keyword And Continue On Failure    verify table records current page    0

搜索模板_已存在模板完整名称
    [Tags]    ${templateTag['search']}
    into template manage UI
    input search template name    ${tempTD['srcName'][1]}
    click search button
    verify table records current page    1

搜索模板_已存在模板名称部分字段
    [Tags]    ${templateTag['search']}
    into template manage UI
    ${len}    Get Length    ${tempTD['srcName']}
    input search template name    ${tempTD['srcName'][0]}
    click search button
    verify table records current page    ${len}

删除模板_弹窗信息验证
    [Tags]    ${templateTag['info']}
    into template manage UI
    click delete template buton    ${tempTD['nameD']}
    verify confirm box info    ${tempUI['msg7']}

删除模板_取消
    [Tags]    ${templateTag['del']}
    into template manage UI
    click delete template buton    ${tempTD['nameD']}
    click confirm box cancel button
    verify confirm not exist

删除模板_确定
    [Tags]    ${templateTag['del']}    smokeCase
    into template manage UI
    click delete template buton    ${tempTD['del']}
    click confirm box confirm button
    verify confirm box info    ${tempUI['msg8']}    confirm=None    cancel=${tempUI['button12']}
    ${status}    Run Keyword And Return Status    verify template name on the UI    ${tempTD['del']}
    Should Be Equal As Strings    ${status}    False

删除模板_已分配给用户
    [Tags]    ${templateTag['del']}
    [Setup]    assign users of template    ${tempTD['srcName'][0]}
    into template manage UI
    click delete template buton    ${tempTD['srcName'][0]}
    click confirm box confirm button
    verify confirm box info    ${tempUI['msg9']}    confirm=None    cancel=${tempUI['button12']}
