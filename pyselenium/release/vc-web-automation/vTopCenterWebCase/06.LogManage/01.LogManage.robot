*** Settings ***
Suite Setup    login by admin
Suite Teardown    close browser and kill chrome process
Resource    ../../Keyword/LogManageKeywords.robot

*** Test Cases ***
vTop日志管理界面信息验证
    [Tags]    ${logTag['vtop']}
    into vTop log manage UI
    verify vtoplog manage UI info
    
vTop日志删除_未勾选日志
    [Tags]    ${logTag['vtop']}
    into vTop log manage UI
    click vtoplog delete button
    verify lobibox info    ${logBox['msg1']}
    
系统日志管理界面信息验证
    [Tags]    ${logTag['sys']}
    into system log manage UI
    verify system log manage UI info
    
系统日志删除_未勾选日志
    [Tags]    ${logTag['sys']}
    into system log manage UI
    click systemlog delete button
    verify lobibox info    ${logBox['msg1']}
    
系统日志删除_弹窗信息验证
    [Tags]    ${logTag['sys']}
    into system log manage UI
    select system first log
    click systemlog delete button
    verify confirm box info    ${syslogUI['msg1']}    

系统日志删除_取消
    [Tags]    ${logTag['sys']}
    into system log manage UI
    select system first log
    click systemlog delete button
    click confirm box cancel button
    verify confirm not exist
    
系统日志删除_确定
    [Tags]    ${logTag['sys']}
    into system log manage UI
    ${logId}    select system first log
    click systemlog delete button
    click confirm box confirm button
    verify system first log delete success    ${logId}
    
vTop日志_开始时间排序
    [Tags]    ${logTag['sort']}
    into vTop log manage UI
    click start time on vtop log for sort    
    
vTop日志_结束时间排序
    [Tags]    ${logTag['sort']}
    into vTop log manage UI
    click end time on vtop log for sort
    
vTop日志_虚拟机名称排序
    [Tags]    ${logTag['sort']}
    into vTop log manage UI
    click vm name on vtop log for sort
    
vTop日志_虚拟机UUID排序
    [Tags]    ${logTag['sort']}
    into vTop log manage UI
    click uuid on vtop log for sort
    
vTop日志_类型排序
    [Tags]    ${logTag['sort']}
    into vTop log manage UI
    click type on vtop log for sort   
    
vTop日志_状态排序
    [Tags]    ${logTag['sort']}
    into vTop log manage UI
    click status on vtop log for sort

系统日志_操作人员排序
    [Tags]    ${logTag['sort']}
    into system log manage UI
    click creator on system log for sort    
    
系统日志_操作时间排序
    [Tags]    ${logTag['sort']}
    into system log manage UI
    click date on system log for sort 
             
系统日志_操作类型排序
    [Tags]    ${logTag['sort']}
    into system log manage UI
    click type on system log for sort