*** Settings ***
Resource          ../PublicKeywords.robot
Resource          ../../ElementLocators/vTopElementID.robot
Variables         ../../TestData/vTopManage.py

*** Keywords ***
click restart vtop button
    [Documentation]    点击vtop重启按钮
    Click Element    ${vtop_restart_button_ID}

click shutdown vtop button
    [Documentation]    点击vtop关机按钮
    Click Element    ${vtop_shutdown_button_ID}

click start vtop button
    [Documentation]    点击vtop开始按钮
    Click Element    ${vtop_start_button_ID}

click vtop bind user button
    [Documentation]    点击vTop管理中 绑定用户
    Click Element    ${vtop_basic_button_ID}
    Wait Until Element Is Visible    ${vtop_basic_toBind_ID}
    Click Element    ${vtop_basic_toBind_ID}

click vtop change location button
    [Documentation]    点击vTop管理中更换位置按钮
    Click Element    ${vtop_basic_button_ID}
    Wait Until Element Is Visible    ${vtop_basic_change_ID}
    Click Element    ${vtop_basic_change_ID}

click vtop push vhd button
    [Documentation]    点击vtop管理中推送镜像按钮
    Click Element    ${vtop_basic_button_ID}
    Wait Until Element Is Visible    ${vtop_basic_push_ID}
    Click Element    ${vtop_basic_push_ID}

click vtop set gateway button
    [Documentation]    点击vTop管理中设置成网关
    Click Element    ${vtop_basic_button_ID}
    Wait Until Element Is Visible    ${vtop_basic_gateway_ID}
    Click Element    ${vtop_basic_gateway_ID}

click vtop start auto sign-in button
    [Documentation]    点击vTop管理中启用自动登录按钮
    Click Element    ${vtop_basic_button_ID}
    Wait Until Element Is Visible    ${vtop_basic_autoStart_ID}
    Click Element    ${vtop_basic_autoStart_ID}

click vtop stop auto sign-in button
    [Documentation]    点击vTop管理中禁用自动登录按钮
    Click Element    ${vtop_basic_button_ID}
    Wait Until Element Is Visible    ${vtop_basic_autoStop_ID}
    Click Element    ${vtop_basic_autoStop_ID}

click vtop unbind button
    [Documentation]    点击vTop管理中取消绑定
    Click Element    ${vtop_basic_button_ID}
    Wait Until Element Is Visible    ${vtop_basic_cacelBind_ID}
    Click Element    ${vtop_basic_cacelBind_ID}

click vtop upgrade button
    [Documentation]    点击vTop管理中升级按钮
    Click Element    ${vtop_basic_button_ID}
    Wait Until Element Is Visible    ${vtop_basic_upgrade_ID}
    Click Element    ${vtop_basic_upgrade_ID}

into vtop manage UI
    refresh page
    Wait Until Element Is Enabled    ${vtop_manage_ID}
    Click Element    ${vtop_manage_ID}
    Wait Until Element Is Visible    ${vtop_menu_ID}
    Click Element    ${vtop_menu_ID}
    Wait Until Element Is Visible    ${vtop_manage_UI_ID}
    Select Frame    ${vtop_manage_iframe_ID}
    Select Frame    ${vtop_manage_iframe1_ID}
    Wait Until Element Is Visible    ${vtop_start_button_ID}

verify vtop manage UI info
    [Documentation]    验证vTop管理界面table信息
    verify same element text by UI    ${vtop_table_head}    ${EMPTY}    @{vtopUI['tableH1']}
    Click Element    ${vtop_switch_button_ID}
    Sleep    ${clickSleep}
    ${txt}    Get Element Attribute    ${vtop_switch_label_ID}@data-lbl
    ${txt}    Strip String    ${txt}
    Should Be Equal As Strings    ${txt}    ${vtopUI['detail']}        
    verify same element text by UI    ${vtop_table_head}    ${EMPTY}    @{vtopUI['tableH2']}   
    verify element value attribute value    ${vtop_start_button_ID}    ${vtopUI['button1']}
    verify element value attribute value    ${vtop_shutdown_button_ID}    ${vtopUI['button2']}
    verify element value attribute value    ${vtop_restart_button_ID}    ${vtopUI['button3']}
    verify element text    ${vtop_basic_button_ID}    ${vtopUI['button4']}
    Click Element    ${vtop_basic_button_ID}
    Wait Until Element Is Visible    ${vtop_basic_push_ID}
    verify element text    ${vtop_basic_push_ID}    ${vtopUI['button5']}
    verify element text    ${vtop_basic_change_ID}    ${vtopUI['button6']}
    verify element text    ${vtop_basic_autoStart_ID}    ${vtopUI['button7']}
    verify element text    ${vtop_basic_autoStop_ID}    ${vtopUI['button8']}
    verify element text    ${vtop_basic_upgrade_ID}    ${vtopUI['button9']}
    verify element text    ${vtop_basic_toBind_ID}    ${vtopUI['button10']}
    verify element text    ${vtop_basic_cacelBind_ID}    ${vtopUI['button11']}
    verify element text    ${vtop_basic_gateway_ID}    ${vtopUI['button12']}
    verify element title attribute value    ${vtop_basic_push_ID}    ${vtopUI['title6']}
    verify element title attribute value    ${vtop_basic_change_ID}    ${vtopUI['title7']}
    verify element title attribute value    ${vtop_basic_autoStart_ID}    ${vtopUI['title8']}
    verify element title attribute value    ${vtop_basic_autoStop_ID}    ${vtopUI['title9']}
    verify element title attribute value    ${vtop_basic_upgrade_ID}    ${vtopUI['title10']}
    verify element title attribute value    ${vtop_basic_toBind_ID}    ${vtopUI['title11']}
    verify element title attribute value    ${vtop_basic_cacelBind_ID}    ${vtopUI['title12']}
    verify element title attribute value    ${vtop_basic_gateway_ID}    ${vtopUI['title13']}
    open the search UI
    verify element text    ${public_search_label_ID}    ${vtopUI['srcLabel']}
    verify element title attribute value    ${search_button_ID}    ${vtopUI['title14']}
    verify element text    ${public_manage_title_ID}    ${vtopUI['title2']}
    Unselect Frame
    verify element text    ${vtop_tab_ID}    ${vtopUI['title1']}

