*** Settings ***
Suite Setup       login by admin
Suite Teardown    close browser and kill chrome process
Test Setup        into system log manage UI
Force Tags      trunPageCase
Resource          ../../Keyword/PageTurningKeywords.robot

*** Test Cases ***
翻页栏信息验证_每页10条
    select number of each page record    10
    scroll to the bottom
    Select Frame    ${syslog_iframe_ID}
    verify current page record number in vclog UI    10
    verify page turning label info    10

翻页栏信息验证_每页50条
    select number of each page record    50
    scroll to the bottom
    Select Frame    ${syslog_iframe_ID}
    verify current page record number in vclog UI    50
    verify page turning label info    50

翻页栏信息验证_每页100条
    select number of each page record    100
    scroll to the bottom
    Select Frame    ${syslog_iframe_ID}
    verify current page record number in vclog UI    100
    verify page turning label info    100

翻页栏信息验证_每页500条
    select number of each page record    500
    scroll to the bottom
    Select Frame    ${syslog_iframe_ID}
    verify current page record number in vclog UI    500
    verify page turning label info    500

翻页栏信息验证_每页1000条
    select number of each page record    1000
    scroll to the bottom
    Select Frame    ${syslog_iframe_ID}
    verify current page record number in vclog UI    1000
    verify page turning label info    1000

点击尾页_每页100条
    select number of each page record    100
    scroll to the bottom
    Select Frame    ${syslog_iframe_ID}
    click last page button
    verify jumpto last page info by UI    100

点击下一页_每页10条
    scroll to the bottom
    Select Frame    ${syslog_iframe_ID}
    click next page button
    verify jumpto one page info by UI    2    10

点击首页_每页10条
    scroll to the bottom
    Select Frame    ${syslog_iframe_ID}
    click last page button
    Sleep    ${clickSleep}
    click first page button
    verify jumpto one page info by UI    1    10

点击上一页_每页10条
    scroll to the bottom
    Select Frame    ${syslog_iframe_ID}
    click next page button
    Sleep    ${clickSleep}
    click prev page button
    verify jumpto one page info by UI    1    10

点击页数跳转_每页10条
    scroll to the bottom
    Select Frame    ${syslog_iframe_ID}
    jump to page by page number    10    10
    verify jumpto one page info by UI    10    10

点击跳转按钮跳转_每页10条
    scroll to the bottom
    Select Frame    ${syslog_iframe_ID}
    jump to page by jump button    10
    verify jumpto one page info by UI    10    10

点击跳转按钮_输入的值过大_每页100条
    select number of each page record    100
    scroll to the bottom
    Select Frame    ${syslog_iframe_ID}
    jump to page by jump button    10000000000
    verify jumpto last page info by UI    100
