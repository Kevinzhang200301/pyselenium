*** Settings ***
Resource    DevicePolicyKeywords.robot
Resource    UserPolicyKeywords.robot

*** Keywords ***
click policy name for sort
    [Documentation]    点击策略名称排序
    Wait Until Element Is Visible    ${policy_sort_name}
    Click Element    ${policy_sort_name}
    Wait Until Element Is Visible    ${policy_sort_name}
    
click policy type for sort
    [Documentation]    点击类型 排序   
    Wait Until Element Is Visible    ${policy_sort_type}
    Click Element    ${policy_sort_type}
    Wait Until Element Is Visible    ${policy_sort_type}
    
click policy number for sort
    [Documentation]    点击数量进行排序
    Wait Until Element Is Visible    ${policy_sort_number}
    Click Element    ${policy_sort_number}
    Wait Until Element Is Visible    ${policy_sort_number}
    
prepare env for policy sort
    [Documentation]    为测试策略管理排序准备环境：1.admin用户登录；2.创建用户策略
    ...    3.创建设备策略
    login by admin
    :FOR    ${name1}    IN    @{sortTD['name1']}
    \    ${num1}    Generate Random String    1    ${sortTD['randomNum']}678
    \    create right user policy by UI    ${name1}    ${num1}    
    :FOR    ${name2}    IN    @{sortTD['name2']}    
    \    ${num2}    Generate Random String    1    123
    \    ${a}    Evaluate    ${num2}%2
    \    ${type}    Set Variable If    '${a}'=='0'    ${policyUI['Dtype'][1]}
    ...    '${a}'=='1'    black    
    \    create right device policy    ${name2}    ${type}    ${num2}    
        
clear env for policy sort
    [Documentation]    清空策略管理排序环境：1.删除设备策略；2.删除用户策略；3.关闭浏览器
    delete all device policy by UI
    delete all userpolicy by UI
    close browser and kill chrome process   