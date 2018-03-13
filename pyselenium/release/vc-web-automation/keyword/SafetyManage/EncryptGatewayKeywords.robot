*** Settings ***
Resource          ../../ElementLocators/SafetyManageElementID.robot
Resource          ../PublicKeywords.robot
Variables         ../../TestData/SafetyManage.py

*** Keywords ***
into encrypt gateway manage UI
    refresh page
    Wait Until Element Is Enabled    ${safety_manage_menu_ID}
    Click Element    ${safety_manage_menu_ID}
    Wait Until Element Is Visible    ${erygw_menu_ID}
    Click Element    ${erygw_menu_ID}
    Wait Until Element Is Visible    ${erygw_manage_UI_ID}
    Select Frame    ${erygw_manage_iframe_ID}
    Wait Until Element Is Visible    ${erygw_start_button_ID}

verify encrypt gateway manage UI info
    [Documentation]    验证加密网关界面信息
    verify same element text by UI    ${erygw_table_head}    @{erygwUI['tableH']}
    Element Should Be Visible    //input[@value='${erygwUI['button1']}']
    Element Should Be Visible    //input[@value='${erygwUI['button2']}']
    Element Should Be Visible    //input[@value='${erygwUI['button3']}']
    Element Should Be Visible    //input[@title='${erygwUI['title2']}']
    Element Should Be Visible    //input[@title='${erygwUI['title3']}']
    Element Should Be Visible    //input[@title='${erygwUI['title4']}']
    verify element text    ${public_manage_title_ID}    ${erygwUI['title1']}
    Unselect Frame
    verify element text    ${erygw_tab_ID}    ${erygwUI['title1']}
