*** Settings ***
Suite Setup    login by admin
Suite Teardown    close browser and kill chrome process
Test Setup    refresh page
Resource    ../../Keyword/PublicKeywords.robot

*** Test Cases ***
主界面上信息验证
    verify main UI info
    
授权界面信息验证
    Click Element    ${main_authorization_ID}
    Unselect Frame
    Wait Until Element Is Visible    ${layui_title_ID}
    Select Frame    ${layui_iframe_ID}
    Wait Until Element Is Visible    ${main_auth_chooseFile_ID}
    verify auth UI info
    
关于我们界面信息验证
    Click Element    ${main_aboutMe_ID}
    verify about me UI info        
    
我的主页界面信息验证
    Unselect Frame
    Select Frame    ${home_iframe_ID}
    verify home page UI info
        