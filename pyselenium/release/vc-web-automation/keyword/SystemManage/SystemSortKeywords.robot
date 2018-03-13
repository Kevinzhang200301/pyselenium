*** Settings ***
Resource    FirmwareUpgradeKeywords.robot
Resource    PxeManageKeywords.robot
Resource    RankManageKeywords.robot

*** Keywords ***
click name on pxe UI for sort
    [Documentation]    在集中部署界面点击文件名排序
    Wait Until Element Is Visible    ${pxe_sort_name}
    Click Element    ${pxe_sort_name}
    Wait Until Element Is Visible    ${pxe_sort_name}
    
click name on rank UI for sort
    [Documentation]    在分级管理界面点击名称排序
    Wait Until Element Is Visible    ${rank_sort_name}
    Click Element    ${rank_sort_name}
    Wait Until Element Is Visible    ${rank_sort_name}
    
click IP on rank UI for sort
    [Documentation]    在分级管理界面点击vTopCenter地址排序
    Wait Until Element Is Visible    ${rank_sort_ip}
    Click Element    ${rank_sort_ip}
    Wait Until Element Is Visible    ${rank_sort_ip}
    
click name on FirmwareUpgrade UI for sort
    [Documentation]    在固件升级界面点击名称进行排序
    Wait Until Element Is Visible    ${vcup_sort_name}
    Click Element    ${vcup_sort_name}
    Wait Until Element Is Visible    ${vcup_sort_name}
    
prepare env for system sort
    [Documentation]    为测试系统管理排序准备环境：1.admin登录；2.创建下级管理中心；
    ...    3.上传集中部署中升级包；4.上传vTopCenter升级ISO；5.创建镜像
    login by admin
    create right vhd by UI    ${vhdNameP}
    :FOR    ${i}    IN    @{sortTD['name1']}   
    \    create right vc uploade iso by UI    ${i}
    :FOR    ${i}    IN    @{sortTD['name1']}   
    \    create right install patch by UI    ${i}
    :FOR    ${i}    ${j}    IN ZIP   ${sortTD['name1']}    ${sortTD['name2']}   
    \    create right rank by UI    ${i}    ${j}

clear env for system sort
    [Documentation]    清空系统管理排序测试环境：1.删除下级管理中心；2.上传vtop升级包；
    ...    3.删除VC升级包；4.删除镜像；5.关闭浏览器
    delete all vc upgrade package by UI
    delete all rank by UI
    delete all install patch by UI
    delete all vhd by UI
    close browser and kill chrome process
      