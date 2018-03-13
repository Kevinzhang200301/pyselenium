*** Settings ***
Resource          UserKeywords.robot
Resource          ../ResourceManage/TemplateKeywords.robot

*** Keywords ***
clear env for user and usergroup sort
    [Documentation]    清空用户和用户组排序环境:1.删除用户；2.删除模板；3.删除镜像
    ...    4.删除用户组
    delete all user by UI
    delete all template by UI
    delete all vhd by UI
    delete all usergroup by UI
    close browser and kill chrome process

prepare env for user and usergroup sort
    [Documentation]    测试用户和用户组排序准备环境：1.admin用户登录vTopCenter；2.新建镜像；3.新建模板；
    ...    4.新建用户组；5.新建用户(包括分配模板)
    login by admin
    create right vhd by UI    ${vhdNameP}
    :FOR    ${temp}    IN    @{sortTD['name1']}
    \    create right template by UI    ${temp}    vhdName=${vhdNameP}
    :FOR    ${group1}    IN    @{sortTD['name1']}
    \    create right usergroup by UI    ${group1}    
    ${len1}    Get Length    ${sortTD['name1']}    
    :FOR    ${i}    IN RANGE    ${len1}
    \    create right usergroup by UI    ${sortTD['name2'][${i}]}    ${sortTD['name1'][${i}]}
    \    create right user by UI    ${sortTD['name2'][${i}]}    realName=${sortTD['name1'][${i}]}    group=${sortTD['name1'][${i}]}
    \    into user management UI
    \    select user on the user manage UI    ${sortTD['name2'][${i}]}
    \    click assign template button
    \    ${tempNum}    Generate Random String    1    ${sortTD['randomNum']}    
    \    select table checkbox on UI    ${tempNum}
    \    click save button    True
    \    verify lobibox info       
       
click name on usergroup UI for sort
    [Documentation]    点击用户组管理界面上用户组进行排序
    Wait Until Element Is Visible    ${tuser_sort_usergroup_name_ID}    error=用户组管理界面table中“用户组”不可见
    Click Element    ${tuser_sort_usergroup_name_ID}
    Wait Until Element Is Visible    ${tuser_sort_usergroup_name_ID}    error=点击用户组排序后“用户组”不可见

click parent group on usergroup UI for sort
    [Documentation]    点击用户组界面上所属用户组进行排序
    Wait Until Element Is Visible    ${tuser_sort_parentgroup_ID}    error=用户组管理界面table中“所属用户组”不可见
    Click Element    ${tuser_sort_parentgroup_ID}
    Wait Until Element Is Visible    ${tuser_sort_parentgroup_ID}    error=点击所属用户组排序后“所属用户组”不可见

click parent group on user UI for sort
    [Documentation]    点击用户管理界面所属用户组进行排序
    Wait Until Element Is Visible    ${tuser_sort_group_ID}    error=用户管理界面table中“所属用户组”不可见    
    Click Element    ${tuser_sort_group_ID}
    Wait Until Element Is Visible    ${tuser_sort_group_ID}    error=点击所属用户组排序后“所属用户组”不可见

click publish on user UI for sort
    [Documentation]    点击用户管理界面发布者进行排序
    Wait Until Element Is Visible    ${tuser_sort_pub_ID}    error=用户管理界面table中“发布者”不可见
    Click Element    ${tuser_sort_pub_ID}
    Wait Until Element Is Visible    ${tuser_sort_pub_ID}    error=点击发布者排序后“发布者”不可见

click realname on user UI for sort
    [Documentation]    点击用户管理界面真实姓名进行排序
    Wait Until Element Is Visible    ${tuser_sort_realname_ID}    error=用户管理界面table中“真实姓名”不可见
    Click Element    ${tuser_sort_realname_ID}
    Wait Until Element Is Visible    ${tuser_sort_realname_ID}    error=点击真实姓名排序后“真实姓名”不可见

click template number on user UI for sort
    [Documentation]    点击用户管理界面模板数量进行排序
    Wait Until Element Is Visible    ${tuser_sort_template_ID}    error=用户管理界面table中“模板数量”不可见
    Click Element    ${tuser_sort_template_ID}
    Wait Until Element Is Visible    ${tuser_sort_template_ID}    error=点击模板数量排序后“模板数量”不可见

click username on user UI for sort
    [Documentation]    点击用户管理界面用户名进行排序
    Wait Until Element Is Visible    ${tuser_sort_username_ID}    error=用户管理界面table中“用户名”不可见
    Click Element    ${tuser_sort_username_ID}
    Wait Until Element Is Visible    ${tuser_sort_username_ID}    error=点击用户名排序后“用户名”不可见
    