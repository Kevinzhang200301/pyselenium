*** Settings ***
Resource          ../PublicKeywords.robot
Resource          ../../ElementLocators/ResourceElementID.robot
Variables         ../../TestData/ResourceTestData.py

*** Keywords ***
click clear wander data button
    [Documentation]    点击清理漫游数据按钮
    Click Element    ${wander_clearSpace_button_ID}

input search wander user
    [Arguments]    ${name}
    [Documentation]    在数据漫游界面输入要搜索的用户名
    ...    参数：用户名
    Clear Element Text    ${wander_search_userInput_ID}
    Input Text    ${wander_search_userInput_ID}    ${name}
    Sleep    ${inputSleep}    

into wander manage UI
    [Documentation]    进入到漫游数据管理界面
    refresh page
    Wait Until Element Is Enabled    ${resource_manage_ID}
    Click Element    ${resource_manage_ID}
    Wait Until Element Is Visible    ${wander_menu_ID}
    Click Element    ${wander_menu_ID}
    Wait Until Element Is Visible    ${wander_manage_UI_ID}
    Select Frame    ${wander_manage_iframe_ID}
    Wait Until Element Is Visible    ${wander_clearSpace_button_ID}

select search wander type
    [Arguments]    ${type}
    [Documentation]    选择要搜索的数据类型
    ...    参数：漫游类型
    Select From List By Label    ${type}
    Sleep    ${selectSleep}
    List Selection Should Be    ${type}

verify wander manage UI info
    [Documentation]    验证漫游数据界面其他信息
    verify same element text by UI    ${public_table_head}    @{wanderUI['tableH']}
    verify element value attribute value    ${wander_clearSpace_button_ID}    ${wanderUI['button']}
    verify element title attribute value    ${wander_clearSpace_button_ID}    ${wanderUI['title2']}
    open the search UI
    verify same element text by UI    ${public_search_label_ID}    @{wanderUI['srcLabel']}
    ${typelist}    Get List Items    ${wander_search_select_ID}
    Lists Should Be Equal    ${typelist}    ${wanderUI['typeList']}
    verify element text    ${public_manage_title_ID}    ${wanderUI['title1']}
    Unselect Frame
    verify element text    ${wander_tab_ID}    ${wanderUI['title1']}    