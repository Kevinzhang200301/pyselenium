*** Settings ***
Suite Setup       login by admin
Suite Teardown    close browser and kill chrome process
Force Tags    ${pxeTag['default']}
Resource          ../../Keyword/SystemManage/PxeManageKeywords.robot

*** Test Cases ***
集中部署界面信息验证
    [Tags]    ${pxeTag['info']}
    [Setup]    create right install patch by UI    ${pxeTD['nameD']}
    into pxe manage UI
    verify pxe manage UI table info
    verify pxe manage UI other info
    [Teardown]    delete all install patch by UI

添加安装包界面信息验证
    [Tags]    ${pxeTag['info']}
    into pxe manage UI
    click add patch button
    verify install patch UI form info
    verify lay UI title info    ${pxeUI['title7']}

配置DHCP界面信息验证
    [Tags]    ${pxeTag['info']}
    into pxe manage UI
    click config DHCP button
    verify lay UI title info    ${pxeUI['title8']}
    verify DHCP UI form info

添加安装包_未选择文件
    [Tags]    ${pxeTag['create']}
    into pxe manage UI
    click add patch button
    click save button
    verify install patch file error info    ${pxeUI['err3']}

添加安装包_文件格式错误
    [Tags]    ${pxeTag['create']}
    into pxe manage UI
    click add patch button
    : FOR    ${file}    IN    @{pxeTD['fileE']}
    \    choose install patch    ${file}
    \    verify install patch file error info    ${pxeUI['err4']}

添加安装包_文件正确
    [Tags]    ${pxeTag['create']}    smokeCase
    into pxe manage UI
    click add patch button
    choose install patch    ${pxeTD['fileR']}
    click install patch upload button
    wait until file upload down
    input install patch name    ${pxeTD['nameD']}
    click save button    True
    verify lobibox info
    verify install patch on the UI    ${pxeTD['nameD']}
    [Teardown]    delete all install patch by UI

添加安装包_名称为空
    [Tags]    ${pxeTag['create']}
    into pxe manage UI
    click add patch button
    choose install patch    ${pxeTD['fileR']}
    click install patch upload button
    wait until file upload down
    input install patch name    ${EMPTY}
    click save button
    verify install patch name error info    ${pxeUI['err1']}

添加安装包_名称正确
    [Tags]    ${pxeTag['create']}    smokeCase
    into pxe manage UI
    click add patch button
    choose install patch    ${pxeTD['fileR']}
    click install patch upload button
    wait until file upload down
    input install patch name    ${pxeTD['nameR']}
    click save button    True
    verify lobibox info
    verify install patch on the UI    ${pxeTD['nameR']}
    [Teardown]    delete all install patch by UI

添加安装包_名称重复
    [Tags]    ${pxeTag['create']}
    [Setup]    create right install patch by UI    ${defaultNameTD}3    
    into pxe manage UI
    click add patch button
    choose install patch    ${pxeTD['fileR']}
    click install patch upload button
    wait until file upload down
    input install patch name    ${defaultNameTD}3
    click save button
    verify install patch name error info    ${pxeUI['err18']}
    [Teardown]    delete all install patch by UI

添加安装包_名称忽略大小写
    [Tags]    ${pxeTag['create']}
    [Setup]    create right install patch by UI    ${defaultNameTD}5   
    into pxe manage UI
    click add patch button
    choose install patch    ${pxeTD['fileR']}
    click install patch upload button
    wait until file upload down
    ${upper}    Convert To Uppercase    ${defaultNameTD}5
    input install patch name    ${upper}
    click save button
    verify install patch name error info    ${pxeUI['err18']}
    [Teardown]    delete all install patch by UI

配置DHCP_开始地址为空
    [Tags]    ${pxeTag['dhcp']}
    into pxe manage UI
    click config DHCP button
    input dhcp start ip    ${EMPTY}
    click save button
    verify dhcp startIp error info    ${pxeUI['err5']}

配置DHCP_开始地址格式错误
    [Tags]    ${pxeTag['dhcp']}
    into pxe manage UI
    click config DHCP button
    : FOR    ${ip}    IN    @{pxeTD['ipE']}
    \    input dhcp start ip    ${ip}
    \    click save button
    \    Run Keyword And Continue On Failure    verify dhcp startIp error info    ${pxeUI['err6']}

配置DHCP_结束地址为空
    [Tags]    ${pxeTag['dhcp']}
    into pxe manage UI
    click config DHCP button
    input dhcp start ip    ${pxeTD['startIpR']}
    input dhcp end ip    ${EMPTY}
    click save button
    verify dhcp endIp error info    ${pxeUI['err7']}

配置DHCP_结束地址格式错误
    [Tags]    ${pxeTag['dhcp']}
    into pxe manage UI
    click config DHCP button
    input dhcp start ip    ${pxeTD['startIpR']}
    : FOR    ${ip}    IN    @{pxeTD['ipE']}
    \    input dhcp end ip    ${ip}
    \    click save button
    \    Run Keyword And Continue On Failure    verify dhcp endIp error info    ${pxeUI['err6']}

配置DHCP_子网地址为空
    [Tags]    ${pxeTag['dhcp']}
    into pxe manage UI
    click config DHCP button
    input dhcp start ip    ${pxeTD['startIpR']}
    input dhcp end ip    ${pxeTD['endIpR']}
    input dhcp subnet ip    ${EMPTY}
    click save button
    verify dhcp subnetIp error info    ${pxeUI['err8']}

配置DHCP_子网地址格式错误
    [Tags]    ${pxeTag['dhcp']}
    into pxe manage UI
    click config DHCP button
    input dhcp start ip    ${pxeTD['startIpR']}
    input dhcp end ip    ${pxeTD['endIpR']}
    : FOR    ${ip}    IN    @{pxeTD['ipE']}
    \    input dhcp subnet ip    ${ip}
    \    click save button
    \    Run Keyword And Continue On Failure    verify dhcp subnetIp error info    ${pxeUI['err6']}

配置DHCP_子网掩码为空
    [Tags]    ${pxeTag['dhcp']}
    into pxe manage UI
    click config DHCP button
    input dhcp start ip    ${pxeTD['startIpR']}
    input dhcp end ip    ${pxeTD['endIpR']}
    input dhcp subnet ip    ${pxeTD['subnetR']}
    input dhcp netmask    ${EMPTY}
    click save button
    verify dhcp netmask error info    ${pxeUI['err9']}

配置DHCP_子网掩码格式错误
    [Tags]    ${pxeTag['dhcp']}
    into pxe manage UI
    click config DHCP button
    input dhcp start ip    ${pxeTD['startIpR']}
    input dhcp end ip    ${pxeTD['endIpR']}
    input dhcp subnet ip    ${pxeTD['subnetR']}
    : FOR    ${ip}    IN    @{pxeTD['ipE']}
    \    input dhcp netmask    ${ip}
    \    click save button
    \    Run Keyword And Continue On Failure    verify dhcp netmask error info    ${pxeUI['err10']}

配置DHCP_网关为空
    [Tags]    ${pxeTag['dhcp']}
    into pxe manage UI
    click config DHCP button
    input dhcp start ip    ${pxeTD['startIpR']}
    input dhcp end ip    ${pxeTD['endIpR']}
    input dhcp subnet ip    ${pxeTD['subnetR']}
    input dhcp netmask    ${pxeTD['maskR']}
    input dhcp gateway    ${EMPTY}
    click save button
    verify dhcp gateway error info    ${pxeUI['err11']}

配置DHCP_网关格式错误
    [Tags]    ${pxeTag['dhcp']}
    into pxe manage UI
    click config DHCP button
    input dhcp start ip    ${pxeTD['startIpR']}
    input dhcp end ip    ${pxeTD['endIpR']}
    input dhcp subnet ip    ${pxeTD['subnetR']}
    input dhcp netmask    ${pxeTD['maskR']}
    : FOR    ${ip}    IN    @{pxeTD['ipE']}
    \    input dhcp gateway    ${ip}
    \    click save button
    \    Run Keyword And Continue On Failure    verify dhcp gateway error info    ${pxeUI['err6']}

配置DHCP_域名服务器为空
    [Tags]    ${pxeTag['dhcp']}
    into pxe manage UI
    click config DHCP button
    input dhcp start ip    ${pxeTD['startIpR']}
    input dhcp end ip    ${pxeTD['endIpR']}
    input dhcp subnet ip    ${pxeTD['subnetR']}
    input dhcp netmask    ${pxeTD['maskR']}
    input dhcp gateway    ${pxeTD['gwR']}
    input dhcp dns    ${EMPTY}
    click save button
    verify dhcp DNS error info    ${pxeUI['err12']}

配置DHCP_域名服务器格式错误
    [Tags]    ${pxeTag['dhcp']}
    into pxe manage UI
    click config DHCP button
    input dhcp start ip    ${pxeTD['startIpR']}
    input dhcp end ip    ${pxeTD['endIpR']}
    input dhcp subnet ip    ${pxeTD['subnetR']}
    input dhcp netmask    ${pxeTD['maskR']}
    input dhcp gateway    ${pxeTD['gwR']}
    : FOR    ${ip}    IN    @{pxeTD['ipE']}
    \    input dhcp dns    ${ip}
    \    click save button
    \    Run Keyword And Continue On Failure    verify dhcp DNS error info    ${pxeUI['err6']}

配置DHCP_TFTP服务器为空
    [Tags]    ${pxeTag['dhcp']}
    into pxe manage UI
    click config DHCP button
    input dhcp start ip    ${pxeTD['startIpR']}
    input dhcp end ip    ${pxeTD['endIpR']}
    input dhcp subnet ip    ${pxeTD['subnetR']}
    input dhcp netmask    ${pxeTD['maskR']}
    input dhcp gateway    ${pxeTD['gwR']}
    input dhcp dns    ${pxeTD['dnsR']}
    input dhcp tftp    ${EMPTY}
    click save button
    verify dhcp TFTP error info    ${pxeUI['err13']}

配置DHCP_TFTP服务器格式错误
    [Tags]    ${pxeTag['dhcp']}
    into pxe manage UI
    click config DHCP button
    input dhcp start ip    ${pxeTD['startIpR']}
    input dhcp end ip    ${pxeTD['endIpR']}
    input dhcp subnet ip    ${pxeTD['subnetR']}
    input dhcp netmask    ${pxeTD['maskR']}
    input dhcp gateway    ${pxeTD['gwR']}
    input dhcp dns    ${pxeTD['dnsR']}
    : FOR    ${ip}    IN    @{pxeTD['ipE']}
    \    input dhcp tftp    ${ip}
    \    click save button
    \    Run Keyword And Continue On Failure    verify dhcp TFTP error info    ${pxeUI['err6']}

配置DHCP_所有配置正确
    [Tags]    ${pxeTag['dhcp']}    smokeCase
    into pxe manage UI
    click config DHCP button
    input dhcp start ip    ${pxeTD['startIpR']}
    input dhcp end ip    ${pxeTD['endIpR']}
    input dhcp subnet ip    ${pxeTD['subnetR']}
    input dhcp netmask    ${pxeTD['maskR']}
    input dhcp gateway    ${pxeTD['gwR']}
    input dhcp dns    ${pxeTD['dnsR']}
    input dhcp tftp    ${pxeTD['tftpR']}
    click save button    True
    verify lobibox info
