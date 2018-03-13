*** Settings ***
Resource          ../PublicKeywords.robot
Resource          ../../ElementLocators/vTopElementID.robot
Variables         ../../TestData/vTopManage.py

*** Keywords ***
click delete vm button
    [Documentation]    点击删除VM按钮
    Click Element    ${vm_delete_button_ID}

click rollback button
    [Documentation]    点击还原VM按钮
    Click Element    ${vm_rollBack_button}

click restart vm button
    [Documentation]    点击VM重启按钮
    Click Element    ${vm_reboot_button_ID}

click search clear button
    [Documentation]    点击搜索中的清空按钮
    Wait Until Element Is Visible    ${vm_search_clearbtn_ID}
    Click Element    ${vm_search_clearbtn_ID}

click shutdown vm button
    [Documentation]    点击vm关机按钮
    Click Element    ${vm_shutdown_button_ID}

click start vm button
    [Documentation]    点击vm开机按钮
    Click Element    ${vm_start_button_ID}

click update vm button
    [Documentation]    点击vm更新按钮
    Click Element    ${vm_update_buuton_ID}

into VM manage UI
    [Documentation]    进入到虚拟机管理界面
    refresh page
    Wait Until Element Is Enabled    ${vtop_manage_ID}
    Click Element    ${vtop_manage_ID}
    Wait Until Element Is Visible    ${vm_menu_ID}
    Click Element    ${vm_menu_ID}
    Wait Until Element Is Visible    ${vm_manage_UI_ID}
    Select Frame    ${vm_manage_iframe_ID}
    Wait Until Element Is Visible    ${vm_delete_button_ID}

verify vm manage UI info
    [Documentation]    验证虚拟机管理界面table信息
    verify same element text by UI    ${public_table_head}    ${EMPTY}    @{vmUI['tableH']}
    verify element title attribute value    ${vm_delete_button_ID}    ${vmUI['title2']}
    verify element title attribute value    ${vm_reboot_button_ID}    ${vmUI['title5']}
    verify element title attribute value    ${vm_shutdown_button_ID}    ${vmUI['title4']}
    verify element title attribute value    ${vm_start_button_ID}    ${vmUI['title3']}
    verify element title attribute value    ${vm_update_buuton_ID}    ${vmUI['title6']}
    verify element title attribute value    ${vm_rollBack_button}    ${vmUI['title7']}
    verify element text    ${vm_delete_button_ID}    ${vmUI['button1']}
    verify element value attribute value    ${vm_reboot_button_ID}    ${vmUI['button4']}
    verify element value attribute value    ${vm_shutdown_button_ID}    ${vmUI['button2']}
    verify element value attribute value    ${vm_start_button_ID}    ${vmUI['button3']}
    verify element value attribute value    ${vm_update_buuton_ID}    ${vmUI['button5']}
    verify element value attribute value    ${vm_rollBack_button}    ${vmUI['button7']}
    open the search UI
    verify same element text by UI    ${public_search_label_ID}    @{vmUI['srcLabel']}
    verify element text    ${vm_search_clearbtn_ID}    ${vmUI['button6']}
    verify element text    ${public_manage_title_ID}    ${vmUI['title1']}
    Unselect Frame
    verify element text    ${vm_tab_ID}    ${vmUI['title1']}