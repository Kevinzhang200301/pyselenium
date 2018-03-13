*** Settings ***
Resource    TemplateKeywords.robot
Resource    UpgradePackageKeywords.robot
Resource    WanderDataKeywords.robot

*** Keywords ***
click name on template UI for sort
    [Documentation]    点击模板管理界上模板名称进行排序
    Wait Until Element Is Visible    ${tmpl_sort_name}
    Click Element    ${tmpl_sort_name}
    Wait Until Element Is Visible    ${tmpl_sort_name}
    
click vhd on template UI for sort
    [Documentation]    点击模板管理界上镜像名称进行排序
    Wait Until Element Is Visible    ${tmpl_sort_vhd}
    Click Element    ${tmpl_sort_vhd}
    Wait Until Element Is Visible    ${tmpl_sort_vhd}
    
click encrypt on template UI for sort
    [Documentation]    点击模板管理界上磁盘是否加密进行排序
    Wait Until Element Is Visible    ${tmpl_sort_encrypt}
    Click Element    ${tmpl_sort_encrypt}
    Wait Until Element Is Visible    ${tmpl_sort_encrypt}
    
click cpu on template UI for sort
    [Documentation]    点击模板管理界上CPU数量进行排序
    Wait Until Element Is Visible    ${tmpl_sort_cpu}
    Click Element    ${tmpl_sort_cpu}
    Wait Until Element Is Visible    ${tmpl_sort_cpu}
    
    
click disk on template UI for sort
    [Documentation]    点击模板管理界上磁盘大小进行排序
    Wait Until Element Is Visible    ${tmpl_sort_disk}
    Click Element    ${tmpl_sort_disk}
    Wait Until Element Is Visible    ${tmpl_sort_disk}
      
click memory on template UI for sort
    [Documentation]    点击模板管理界上内存大小进行排序
    Wait Until Element Is Visible    ${tmpl_sort_memory}
    Click Element    ${tmpl_sort_memory}
    Wait Until Element Is Visible    ${tmpl_sort_memory}

click local name on vhd UI for sort
    [Documentation]    点击镜像管理界面本地镜像名称进行排序
    Wait Until Element Is Visible    ${vhd_sort_local_name}
    Click Element    ${vhd_sort_local_name}
    Wait Until Element Is Visible    ${vhd_sort_local_name}
    
click topvc name on vhd UI for sort
    [Documentation]    点击镜像管理界面上级同步镜像名称进行排序
    Wait Until Element Is Visible    ${vhd_sort_topvc_name}
    Click Element    ${vhd_sort_topvc_name}
    Wait Until Element Is Visible    ${vhd_sort_topvc_name}
    
click user on wander UI for sort
    [Documentation]    点击数据漫游界面用户名进行排序    
    Wait Until Element Is Visible    ${wander_sort_user}
    Click Element    ${wander_sort_user}
    Wait Until Element Is Visible    ${wander_sort_user}
    
click type on wander UI for sort
    [Documentation]    点击数据漫游界面数据类型进行排序    
    Wait Until Element Is Visible    ${wander_sort_type}
    Click Element    ${wander_sort_type}
    Wait Until Element Is Visible    ${wander_sort_type}    
    
click date on wander UI for sort
    [Documentation]    点击数据漫游界面时间进行排序    
    Wait Until Element Is Visible    ${wander_sort_date}
    Click Element    ${wander_sort_date}
    Wait Until Element Is Visible    ${wander_sort_date}
    
click name on device UI for sort
    [Documentation]    点击设备管理界面设备名称进行排序
    Wait Until Element Is Visible    ${device_sort_name}
    Click Element    ${device_sort_name}
    Wait Until Element Is Visible    ${device_sort_name}        

click type on device UI for sort
    [Documentation]    点击设备管理界面设备类型进行排序
    Wait Until Element Is Visible    ${device_sort_type}
    Click Element    ${device_sort_type}
    Wait Until Element Is Visible    ${device_sort_type}
    
click name on AD UI for sort
    [Documentation]    点击AD域管理界面名称进行排序
    Wait Until Element Is Visible    ${ad_sort_name}
    Click Element    ${ad_sort_name}
    Wait Until Element Is Visible    ${ad_sort_name}
    
click name on VLAN UI for sort
    [Documentation]    点击VLAN管理界面名称进行排序
    Wait Until Element Is Visible    ${vlan_sort_name}
    Click Element    ${vlan_sort_name}
    Wait Until Element Is Visible    ${vlan_sort_name}
    
click name on upPatch UI for sort
    [Documentation]    点击升级包管理界面名称进行排序
    Wait Until Element Is Visible    ${up_patch_sort_name}
    Click Element    ${up_patch_sort_name}
    Wait Until Element Is Visible    ${up_patch_sort_name}

prepare env for resouce manage sort
    [Documentation]    为资源管理排序准备环境：1.admin用户登录；2.创建镜像；
    ...    3.创建设备；4.创建AD域；5.创建VLAN；6.创建升级包;7.创建模板
    login by admin
    :FOR    ${i}    IN    @{sortTD['name1']}
    \    create right vhd by UI    ${i}
    \    create right device by UI    ${i}
    \    create right ad    ${i}
    \    create right vlan by UI    ${i}    
    \    up right patch by UI    ${i}
    ${len1}    Get Length    ${sortTD['name2']}
    :FOR    ${a}    IN RANGE    ${len1}
    \    ${num}    Generate Random String    1    ${sortTD['randomNum']}
    \    ${b}    Evaluate    ${a}%2
    \    ${ery}    Set Variable If    '${b}'=='0'    ${tempUI['diskEncry'][1]}
    ...    '${b}'=='1'    ${tempUI['diskEncry'][0]}        
    \    create right template by UI    ${sortTD['name2'][${a}]}
    ...    vhdName=${sortTD['name1'][${a}]}    diskEncrypt=${ery}
    ...    cpu=${num}    diskS=${num}0    memory=${num}50
    
clear env for resouce manage sort
    [Documentation]    清空资源管理排序环境：1.删除模板；2.删除镜像；3.删除设备
    ...    4.删除AD域；5.删除VLAN；6.删除升级包；7.关闭浏览器
    delete all template by UI
    delete all vhd by UI
    delete all device by UI
    delete all ad by UI
    delete all vlan by UI
    delete all patch by UI
    close browser and kill chrome process     