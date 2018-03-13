*** Settings ***
Suite Setup    login by admin
Suite Teardown    close browser and kill chrome process
Force Tags    ${storageTag['default']}
Resource    ../../Keyword/SystemManage/StorageManageKeywords.robot

*** Test Cases ***
存储管理界面信息验证
    into storage manage UI
    verify storage manage UI table info
    verify storage manage UI other info