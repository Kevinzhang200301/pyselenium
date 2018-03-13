*** Settings ***
Suite Setup    prepare env for resouce manage sort
Suite Teardown    clear env for resouce manage sort
Resource    ../../Keyword/ResourceManage/SortKeywords.robot

*** Test Cases ***
模板管理界面_模板名称排序
    [Tags]    ${templateTag['sort']}
    into template manage UI
    ${list1}    get table column text on UI    2
    click name on template UI for sort
    ${list2}    get table column text on UI   2
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}
 
模板管理界面_镜像名称排序
    [Tags]    ${templateTag['sort']}
    into template manage UI
    ${list1}    get table column text on UI    3
    click vhd on template UI for sort
    ${list2}    get table column text on UI   3
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}  

模板管理界面_磁盘加密排序
    [Tags]    ${templateTag['sort']}
    into template manage UI
    ${list1}    get table column text on UI    4
    click encrypt on template UI for sort
    ${list2}    get table column text on UI   4
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2} 
    
模板管理界面_CPU数量排序
    [Tags]    ${templateTag['sort']}
    into template manage UI
    ${list1}    get table column text on UI    5
    click cpu on template UI for sort
    ${list2}    get table column text on UI   5
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2} 
    
模板管理界面_磁盘大小排序
    [Tags]    ${templateTag['sort']}
    into template manage UI
    ${list1}    get table column text on UI    6
    click disk on template UI for sort
    ${list2}    get table column text on UI   6
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}
    
模板管理界面_内存大小排序
    [Tags]    ${templateTag['sort']}
    into template manage UI
    ${list1}    get table column text on UI    7
    click memory on template UI for sort
    ${list2}    get table column text on UI   7
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}     
        
镜像管理界面_本地镜像名称排序
    [Tags]    ${vhdTag['sort']}
    into vhd manage UI
    ${list1}    get table column text on UI    2    ${vhd_local_table_ID}
    click local name on vhd UI for sort
    ${list2}    get table column text on UI   2    ${vhd_local_table_ID}
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}
    
镜像管理界面_同步镜像名称排序
    [Tags]    ${vhdTag['sort']}
    into vhd manage UI
    ${list1}    get table column text on UI    1    ${vhd_topvc_table_ID}
    click local name on vhd UI for sort
    ${list2}    get table column text on UI   1    ${vhd_topvc_table_ID}
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}
    
数据漫游界面_用户名排序
    [Tags]    ${wanderTag['sort']}
    into wander manage UI
    click user on wander UI for sort
    
数据漫游界面_数据类型排序
    [Tags]    ${wanderTag['sort']}
    into wander manage UI
    click type on wander UI for sort
    
数据漫游界面_时间排序
    [Tags]    ${wanderTag['sort']}
    into wander manage UI
    click date on wander UI for sort    

设备管理界面_设备名称排序
    [Tags]    ${deviceTag['sort']}
    into device manage UI
    ${list1}    get table column text on UI    1
    click name on device UI for sort
    ${list2}    get table column text on UI   1
    ${listD1}    Copy List    ${list1[-3:]}
    ${listD2}    Copy List    ${list1[:-3]} 
    Sort List    ${listD1}
    Sort List    ${listD2}
    ${listNew}    Combine Lists    ${listD2}    ${listD1}
    Lists Should Be Equal    ${listNew}    ${list2}   

设备管理界面_设备类型排序
    [Tags]    ${deviceTag['sort']}
    into device manage UI
    ${list1}    get table column text on UI    2
    click type on device UI for sort
    ${list2}    get table column text on UI   2
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}
    
AD域管理界面_名称排序
    [Tags]    ${adTag['sort']}
    into ad manage UI
    ${list1}    get table column text on UI    1
    click name on AD UI for sort
    ${list2}    get table column text on UI   1
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}   

VLAN管理界面_名称排序
    [Tags]    ${vlanTag['sort']}
    into vlan manage UI
    ${list1}    get table column text on UI    1
    click name on VLAN UI for sort
    ${list2}    get table column text on UI   1
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}
    
升级包管理界面_名称排序
    [Tags]    ${patchTag['sort']}
    into patch manage UI
    ${list1}    get table column text on UI    1
    click name on upPatch UI for sort
    ${list2}    get table column text on UI   1
    Sort List    ${list1}
    Lists Should Be Equal    ${list1}    ${list2}
       