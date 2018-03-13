*** Variables ***
${system_manage_menu_ID}    //i[contains(@class,'fa-gears')]/..    #左侧树中系统管理

#参数设置
${para_menu_ID}    //li[contains(@onclick,'fa-cog')]    #左侧树中参数设置栏
${para_tab_ID}    //a[@href='#tab_1']    #参数设置标签页
${para_manage_UI_ID}    id=tab_1    #参数设置管理界面
${para_manage_iframe_ID}    id=acetab_ifr_tab_1    #参数设置管理界面iframe
${para_poolEdit_button}    //a[contains(@onclick,'230')]    #参数设置管理中编辑存储池位置按钮
${para_superIpEdit_button}    //a[contains(@onclick,'235')]    #参数设置管理界面中编辑上级vTop Center地址按钮
${para_gradeIpEdit_button}    //a[contains(@onclick,'236')]    #参数设置管理界面中编辑分级管理地址按钮
${para_gradeKeyEdit_button}    //a[contains(@onclick,'237')]    #参数设置管理界面中编辑分级管理密钥按钮
${para_DNSIpEdit_button}    //a[contains(@onclick,'238')]    #参数设置管理界面中编辑域名服务器IP按钮
${para_registEdit_button}    //a[contains(@onclick,'239')]    #参数设置管理界面中编辑注册密码按钮
${para_pool%Edit_button}    //a[contains(@onclick,'241')]    #参数设置管理界面中编辑存储池使用百分比告警阈值按钮
${para_poolSizeEdit_button}    //a[contains(@onclick,'242')]    #参数设置管理界面中编辑存储池剩余大小告警阈值按钮
${para_disk%Edit_button}    //a[contains(@onclick,'244')]    #参数设置管理界面中编辑主机硬盘使用百分比告警阈值按钮
${para_diskSizeEdit_button}    //a[contains(@onclick,'245')]    #参数设置管理界面中编辑主机硬盘剩余大小告警阈值按钮
${para_editUI_name_input_ID}    id=enumeration.description    #编辑参数界面上名称输入框
${para_editUI_value_input_ID}    id=enumeration.enName    #编辑参数界面参数值输入框
${para_parameterName_ID}    //tr/td[1]    #参数设置管理界面上参数名称
${para_parameterValue_ID}    //tr/td[2]    #参数设置管理界面上参数值
${para_parameterValue_error_ID}    id=ckeck_name    #参数设置界面参数值错误提示信息

#分级管理
${rank_menu_ID}    //li[contains(@onclick,'936418')]    #左侧树中分级管理栏
${rank_tab_ID}    //a[@href='#tab_936418']    #分级管理标签页
${rank_manage_UI_ID}    id=tab_936418    #分级管理界面
${rank_manage_iframe_ID}    id=acetab_ifr_tab_936418    #分级管理界面iframe
${rank_create_button_ID}    //input[contains(@onclick,'addRank')]    #分级管理界面新建按钮
${rank_search_name_input_ID}    name=pageInfo.f_rank_name    #分级管理界面搜索用户名输入框
${rank_search_IP_input_ID}    name=pageInfo.f_ip_address    #分级管理界面搜索IP输入框
${rank_create_name_input_ID}    id=rank_name    #新建下级VC界面名称输入框
${rank_create_name_error_ID}    id=rank_name_span    #新建下级VC界面名称错误提示信息
${rank_create_ip_input_ID}    id=ip_address    #新建下级VC界面下级管理中心输入框
${rank_create_ip_error_ID}    id=ip_address_span    #新建下级VC界面下级管理中心输入框错误提示信息
${rank_create_key_input_ID}    id=token    #新建下级VC界面密钥输入框
${rank_create_key_error_ID}    id=token_span    #新建下级VC界面密钥错误提示信息
${rank_create_people_input_ID}    id=contacts    #新建下级VC界面联系人输入框
${rank_create_mobile_input_ID}    id=mobile    #新建下级VC界面联系电话
${rank_create_table_ID}    css=#JColResizer0    #新建下级VC界面选择镜像table
${rank_create_vhd_error_ID}    id=resource_ids_error    #新建下级VC界面镜像错误提示信息

#集中部署
${pxe_menu_ID}    //li[contains(@onclick,'936422')]    #左侧树中集中部署栏
${pxe_tab_ID}    //a[@href='#tab_936422']    #集中部署标签页
${pxe_manage_UI_ID}    id=tab_936422    #集中部署界面
${pxe_manage_iframe_ID}    id=acetab_ifr_tab_936422    #集中部署界面iframe
${pxe_addPatch_button_ID}    //input[contains(@onclick,'addPxe')]    #集中部署界面添加安装包按钮
${pxe_dhcp_button_ID}    //a[contains(@onclick,'configPxe')]    #集中部署界面配置DHCP按钮
${pxe_start_button_ID}    //a[contains(@onclick,'startPxe')]    #集中部署界面启动按钮
${pxe_shutdown_button_ID}    //a[contains(@onclick,'shutdownPxe')]    #集中部署界面关闭按钮
${pxe_restart_button_ID}    //a[contains(@onclick,'restartPxe')]    #集中部署界面重启按钮
${pxe_patch_name_input_ID}    id=name    #集中部署添加安装包界面名称输入框
${pxe_patch_name_error_ID}    id=name_error    #集中部署添加安装包界面名称错误提示信息
${pxe_patch_file_error_ID}    id=other_error    #集中部署添加安装包界面上传文件错误提示信息
${pxe_patch_choose_ID}    id=fileupload    #集中部署添加安装包界面文件选择
${pxe_patch_upload_button_ID}    id=upload    #集中部署添加安装包界面选择文件后上传按钮
${pxe_patch_upFileName_ID}    id=upshow    #集中部署添加安装包界面上传文件名显示
${pxe_patch_upProgress_ID}    //div[@id='progress']/div    #集中部署添加安装包界面上传文件进度条
${pxe_patch_up100%_ID}    //div[@class='progress-bar progress-bar-success' and @style='width:100%;']/..    #集中部署添加安装包界面上传文件上传到100%
${pxe_dhcp_startIp_input_ID}    id=rangestart    #集中部署配置DHCP界面开始地址输入框
${pxe_dhcp_startIp_error_ID}    id=rangestart_error    #集中部署配置DHCP界面开始地址错误提示信息
${pxe_dhcp_endIp_input_ID}    id=rangeend    #集中部署配置DHCP界面结束地址输入框
${pxe_dhcp_endIp_error_ID}    id=rangeend_error    #集中部署配置DHCP界面结束地址错误提示信息
${pxe_dhcp_subnet_input_ID}    id=subnet    #集中部署配置DHCP界面子网地址输入框
${pxe_dhcp_subnet_error_ID}    id=subnet_error    #集中部署配置DHCP界面子网地址错误提示信息、
${pxe_dhcp_maskIp_input_ID}    id=netmask    #集中部署配置DHCP界面子网掩码输入框
${pxe_dhcp_maskIp_error_ID}    id=netmask_error    #集中部署配置DHCP界面子网掩码错误提示信息
${pxe_dhcp_gwIp_input_ID}    id=routers    #集中部署配置DHCP界面网关输入框
${pxe_dhcp_gwIp_error_ID}    id=routers_error    #集中部署配置DHCP界面网关错误提示信息
${pxe_dhcp_dnsIp_input_ID}    id=dns    #集中部署配置DHCP界面域名服务器输入框
${pxe_dhcp_dnsIp_error_ID}    id=dns_error    #集中部署配置DHCP界面域名服务器错误提示信息
${pxe_dhcp_tftpIp_input_ID}    id=nextserver    #集中部署配置DHCP界面TFTP服务器输入框
${pxe_dhcp_tftpIp_error_ID}    id=nextserver_error    #集中部署配置DHCP界面TFTP服务器错误提示信息
${pxe_search_name_input_ID}    name=pageInfo.f_name    #集中部署界面搜索名称输入框
${pxe_dhcpStatus_ID}    id=dbcpstatus    #集中部署界面DHCP配置状态信息
${pxe_dhcpStatus_label_ID}    //label[@id='dbcpstatus']/../..    #集中部署界面服务状态栏
${pxe_mount_pwd_input_ID}    id=password    #挂载安装包界面中vTop密码输入框
${pxe_mount_mode_name}    pxe.installmode    #挂载安装包界面安装方式radio的name属性
${pxe_mount_pwd_error_ID}    id=password_error    #挂载安装包界面vTop密码错误提示信息
${pxe_mount_modeLabel_ID}    //span[@class='lbl']    #挂载安装包界面安装方式栏信息
${pxe_mount_mountbtn_ID}    id=addBut    #挂载安装包界面挂载按钮
${pxe_mount_cancelbtn_ID}    id=dis1    #挂载安装包界面取消按钮

#固件升级
${vcup_menu_ID}    //li[contains(@onclick,'936425')]    #左侧树中固件升级栏
${vcup_tab_ID}    //a[@href='#tab_936425']    #固件升级标签页
${vcup_manage_UI_ID}    id=tab_936425    #固件升级界面
${vcup_manage_iframe_ID}    id=acetab_ifr_tab_936425    #固件升级界面iframe
${vcup_table_head}    //*[@id='sample-table-2']//th    #固件升级界面table的head
${vcup_upPatch_button_ID}    //input[contains(@onclick,'addVC')]    #固件升级管理界面上传升级包按钮
${vcup_upgrade_button_ID}    //input[contains(@onclick,'toVcupdate')]    #固件升级管理界面升级按钮
${vcup_restart_button_ID}    //input[contains(@onclick,'restartVC')]    #固件升级管理界面重启按钮
${vcup_shutdown_button_ID}    //input[contains(@onclick,'shutdownVC')]    #固件升级管理界面关机按钮
${vcup_setDate_button_ID}    //input[contains(@onclick,'setVCDate')]    #固件升级管理界面设置时间按钮
${vcup_search_input_ID}    name=pageInfo.f_name    #固件升级管理界面搜索输入框
${vcup_patch_name_input_ID}    id=name    #固件升级管理上传升级包界面升级包名称输入框
${vcup_patch_name_error_ID}    id=name_error    #固件升级管理添加安装包界面名称错误提示信息
${vcup_patch_file_error_ID}    id=other_error    #固件升级管理上传升级包界面上传文件错误提示信息
${vcup_patch_choose_ID}    id=fileupload    #固件升级管理上传升级包界面文件选择
${vcup_patch_upload_button_ID}    id=upload    #固件升级管理上传升级包界面选择文件后上传按钮
${vcup_patch_upFileName_ID}    id=upshow    #固件升级管理上传升级包界面上传文件名显示
${vcup_patch_upProgress_ID}    //div[@id='progress']/div    #固件升级管理上传升级包界面上传文件进度条
${vcup_patch_up100%_ID}    //div[@class='progress-bar progress-bar-success' and @style='width:100%;']/..    #固件升级管理上传升级包界面上传文件上传到100%
${vcup_upgrade_patchName_ID}    //font    #升级界面固件名称
${vcup_setDate_title_ID}    //h5    #设置时间界面title
${vcup_setDate_confirm_button}    //input[contains(@onclick,'modify_date')]    #设置时间界面确定按钮
${vcup_setDate_cancel_button}    //input[contains(@onclick,'closeDialog')]    #设置时间界面取消按钮

# 存储管理界面
${storage_menu_ID}    //li[contains(@onclick,'936428')]    #左侧树中存储管理栏
${storage_tab_ID}    //a[@href='#tab_936428']    #存储管理标签页
${storage_manage_UI_ID}    id=tab_936428    #存储管理界面
${storage_manage_iframe_ID}    id=acetab_ifr_tab_936428    #存储管理界面iframe
${storage_danger_ID}    //div[contains(@class,'alert-danger')]    #存储管理界面警告信息
${storage_table_ID}    css=#localvc    #存储管理界面table
${storage_noDisk_ID}    //td[@colspan='4']    #空闲磁盘table中提示信息

#网络管理界面
${ifcfg_menu_ID}    //li[contains(@onclick,'936429')]    #左侧树中网络管理栏
${ifcfg_tab_ID}    //a[@href='#tab_936429']    #网络管理标签页
${ifcfg_manage_UI_ID}    id=tab_936429    #网络管理界面
${ifcfg_manage_iframe_ID}    id=acetab_ifr_tab_936429    #网络管理界面iframe
${ifcfg_add_button_ID}    //input[contains(@onclick,'addIfcfg')]    #网络管理界面添加网卡按钮
${ifcfg_add_name_input_ID}    id=DEVICE    #添加网卡界面名称输入框
${ifcfg_add_vlanNum_input_ID}    id=VLAN_ID    #添加网卡界面VLAN号输入框
${ifcfg_add_card_select_ID}    id=PHYSDEV    #添加网卡界面物理网卡选择框
${ifcfg_add_noboot_select_ID}    id=ONBOOT     #添加网卡界面ONBOOT选择框
${ifcfg_add_ip_input_ID}    id=IPADDR    #添加网卡界面ip地址输入框
${ifcfg_add_mask_select_ID}    id=PREFIX    #添加网卡界面子网掩码选择框
${ifcfg_add_gw_input_ID}    id=GATEWAY    #添加网卡界面网关输入框
${ifcfg_add_label_ID}    //div[not(@style='display:none')]/label    #添加网卡界面label

# 排序相关元素
${rank_sort_name}    //a[contains(@href,'rank_name')]    #分级管理界面--名称排序
${rank_sort_ip}    //a[contains(@href,'ip_address')]    #分级管理界面--vTopCenter地址排序
${pxe_sort_name}    //a[contains(@href,'name')]    #集中部署界面--名称排序
${vcup_sort_name}    //a[contains(@href,'name')]    #固件升级界面--名称排序