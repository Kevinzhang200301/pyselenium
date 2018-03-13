*** Settings ***
Resource    ../../ElementLocators/SystemManageElementID.robot
Resource    ../PublicKeywords.robot
Variables    ../../TestData/SystemManage.py

*** Keywords ***
into storage manage UI
    [Documentation]    进入到存储管理界面
    refresh page
    Wait Until Element Is Enabled    ${system_manage_menu_ID}
    Click Element    ${system_manage_menu_ID}
    Wait Until Element Is Visible    ${storage_menu_ID}
    Click Element    ${storage_menu_ID}
    Wait Until Element Is Visible    ${storage_manage_UI_ID}
    Select Frame    ${storage_manage_iframe_ID}
    Wait Until Element Is Visible    ${storage_table_ID}
    
verify storage manage UI table info
    [Documentation]    验证存储管理界面table信息
    ${elements}    Get Webelements    ${storage_table_ID}
    :FOR    ${txt1}    IN    @{storageUI['tableH1']}
    \    Run Keyword And Continue On Failure    Table Header Should Contain    ${storage_table_ID}    ${txt1}
    :FOR    ${txt2}    IN    @{storageUI['tableH2']}
    \    Run Keyword And Continue On Failure    Table Header Should Contain    ${storage_table_ID}    ${txt2}
    
verify storage manage UI other info
    [Documentation]    验证存储管理界面其他信息
    verify same element text by UI    ${public_manage_title_ID}    @{storageUI['titleL']}
    Unselect Frame
    verify element text    ${storage_tab_ID}    ${storageUI['title1']}                                  