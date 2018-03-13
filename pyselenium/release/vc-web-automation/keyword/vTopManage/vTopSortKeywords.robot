*** Settings ***
Resource          LocationKeywords.robot
Resource          VirtualMachineKeywords.robot
Resource          vTopKeywords.robot

*** Keywords ***
click name on location manage UI for sort
    [Documentation]    在位置管理界面点击位置名称
    Wait Until Element Is Visible    ${local_sort_name}
    Click Element    ${local_sort_name}
    Wait Until Element Is Visible    ${local_sort_name}

click parent on location manage UI for sort
    [Documentation]    在位置管理界面点击所属位置名称
    Wait Until Element Is Visible    ${local_sort_parentname}
    Click Element    ${local_sort_parentname}
    Wait Until Element Is Visible    ${local_sort_parentname}

click name on vtop manage UI for sort
    [Documentation]    在vTop管理界面点击主机名
    Wait Until Element Is Visible    ${vtop_sort_name}
    Click Element    ${vtop_sort_name}
    Wait Until Element Is Visible    ${vtop_sort_name}

click group on vtop manage UI for sort
    [Documentation]    在vTop管理界面点击所在位置
    Wait Until Element Is Visible    ${vtop_sort_group}
    Click Element    ${vtop_sort_group}
    Wait Until Element Is Visible    ${vtop_sort_group}

click mark on vtop manage UI for sort
    [Documentation]    在vTop管理界面点击编号
    Wait Until Element Is Visible    ${vtop_sort_mark}
    Click Element    ${vtop_sort_mark}
    Wait Until Element Is Visible    ${vtop_sort_mark}

click ip on vtop manage UI for sort
    [Documentation]    在vTop管理界面点击IP地址
    Wait Until Element Is Visible    ${vtop_sort_ip}
    Click Element    ${vtop_sort_ip}
    Wait Until Element Is Visible    ${vtop_sort_ip}

click bindUser on vtop manage UI for sort
    [Documentation]    在vTop管理界面点击绑定用户
    Wait Until Element Is Visible    ${vtop_sort_bindUser}
    Click Element    ${vtop_sort_bindUser}
    Wait Until Element Is Visible    ${vtop_sort_bindUser}

click anonymous on vtop manage UI for sort
    [Documentation]    在vTop管理界面点击自动登录
    Wait Until Element Is Visible    ${vtop_sort_anonymous_login}
    Click Element    ${vtop_sort_anonymous_login}
    Wait Until Element Is Visible    ${vtop_sort_anonymous_login}

click status on vtop manage UI for sort
    [Documentation]    在vTop管理界面点击当前状态
    Wait Until Element Is Visible    ${vtop_sort_wsstate}
    Click Element    ${vtop_sort_wsstate}
    Wait Until Element Is Visible    ${vtop_sort_wsstate}

click name on vm manage UI for sort
    [Documentation]    在虚拟机管理界面点击虚拟机名称
    Wait Until Element Is Visible    ${vm_sort_name}
    Click Element    ${vm_sort_name}
    Wait Until Element Is Visible    ${vm_sort_name}

click vhd on vm manage UI for sort
    [Documentation]    在虚拟机管理界面点击镜像名称
    Wait Until Element Is Visible    ${vm_sort_tmplate}
    Click Element    ${vm_sort_tmplate}
    Wait Until Element Is Visible    ${vm_sort_tmplate}

click vtop on vm manage UI for sort
    [Documentation]    在虚拟机管理界面点击所属vTop
    Wait Until Element Is Visible    ${vm_sort_vtop}
    Click Element    ${vm_sort_vtop}
    Wait Until Element Is Visible    ${vm_sort_vtop}

click user on vm manage UI for sort
    [Documentation]    在虚拟机管理界面点击所属user
    Wait Until Element Is Visible    ${vm_sort_user}
    Click Element    ${vm_sort_user}
    Wait Until Element Is Visible    ${vm_sort_user}

click status on vm manage UI for sort
    [Documentation]    在虚拟机管理界面点击虚拟机状态
    Wait Until Element Is Visible    ${vm_sort_status}
    Click Element    ${vm_sort_status}
    Wait Until Element Is Visible    ${vm_sort_status}

prepare env for vtop manage sort
    [Documentation]    为vTop管理排序准备环境：1.admin用户等；2.创建位置
    login by admin
    ${len}    Get Length    ${sortTD['name1']}
    : FOR    ${name}    IN    @{sortTD['name2']}
    \    create right location by UI    ${name*3}
    : FOR    ${i}    IN RANGE    ${len}
    \    create right location by UI    ${sortTD['name1'][${i}]*3}
    ...    parent=${sortTD['name2'][${i}]*3}

clear env for vtop manage sort
    [Documentation]    清空vtop管理排序测试环境：1.删除所有位置；2.关闭浏览器
    delete all location by UI
    close browser and kill chrome process
