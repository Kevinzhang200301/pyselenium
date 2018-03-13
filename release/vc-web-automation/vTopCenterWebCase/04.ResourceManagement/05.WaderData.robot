*** Settings ***
Suite Setup       login by admin
Suite Teardown    close browser and kill chrome process
Force Tags    ${wanderTag['default']}
Resource          ../../Keyword/ResourceManage/WanderDataKeywords.robot

*** Test Cases ***
漫游数据界面信息验证
    into wander manage UI
    verify wander manage UI info

清理漫游数据_弹窗信息验证
    into wander manage UI
    click clear wander data button
    verify confirm box info    ${wanderUI['msg1']}

清理漫游数据_取消
    into wander manage UI
    click clear wander data button
    click confirm box cancel button
    verify confirm not exist

清理漫游数据_确定
    into wander manage UI
    click clear wander data button
    click confirm box confirm button
    verify lobibox info    ${resBox['msg6']}
