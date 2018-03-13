*** Settings ***
Resource          ../../ElementLocators/SafetyManageElementID.robot
Resource          ../PublicKeywords.robot
Variables         ../../TestData/SafetyManage.py

*** Keywords ***
into audit manage UI
    [Documentation]    进入到审计管理界面
    refresh page
    Wait Until Element Is Enabled    ${safety_manage_menu_ID}
    Click Element    ${safety_manage_menu_ID}
    Wait Until Element Is Visible    ${audit_menu_ID}
    Click Element    ${audit_menu_ID}
    Wait Until Element Is Visible    ${audit_manage_UI_ID}
    Select Frame    ${audit_manage_iframe_ID}
    Wait Until Element Is Visible    ${audit_pass_button_ID}

verify audit manage UI info
    [Documentation]    验证审计管理界面信息
    verify same element text by UI    ${public_table_head}    ${EMPTY}    @{auditUI['tableH']}   
    Element Should Be Visible    //button[@title='${auditUI['title2']}']
    Element Should Be Visible    //button[@title='${auditUI['title3']}']
    verify element text    ${audit_batchDel_button_ID}    ${auditUI['button1']}
    verify element text    ${audit_pass_button_ID}    ${auditUI['button2']}
   verify element text    ${audit_refuse_button_ID}    ${auditUI['button3']}
    open the search UI
    Element Should Be Visible    //button[@title='${auditUI['title4']}']
    verify same element text by UI    ${public_search_label_ID}    @{auditUI['srcLabel']}
    ${selectL1}    Get List Items    ${audit_search_type_select_ID}
    ${selectL2}    Get List Items    ${audit_search_state_select_ID}
    Lists Should Be Equal    ${selectL1}    ${auditUI['selectL1']}
    Lists Should Be Equal    ${selectL2}    ${auditUI['selectL2']}
    verify element text    ${public_manage_title_ID}    ${auditUI['title1']}
    Unselect Frame
    verify element text    ${audit_tab_ID}    ${auditUI['title1']}