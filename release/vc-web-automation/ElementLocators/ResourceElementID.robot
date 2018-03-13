*** Variables ***
${tmpl_add_button_ID}    //input[contains(@onclick,'addTmpl')]    #添加模板按钮
${tmpl_iframetab_ID}    id=acetab_ifr_tab_936424    # 模板管理界面iframe
${tmpl_UI_ID}     id=tab_936424    #模板管理UI
${resource_manage_ID}    //i[@class='menu-icon fa fa-database']/..    # 左侧树中资源管理
${tmpl_iframe_dynamic_ID}    //iframe[contains(@id,'layui-layer-iframe')]    #点击按钮后弹出界面的iframe
${tmpl_menu_ID}    //li[contains(@onclick,'936424')]    # 左侧树中模板
${tmpl_tab_ID}    id=tab_tab_936424    #模板管理界面便签页
${tmpl_add_stepTitle_ID}    //span[@class='title']    #新建模板界面步骤title
#创建模板界面第一步常规界面
${tmpl_add1_step1_ID}    //*[@id='step1']    #添加模板第一步界面
${tmpl_add1_label_ID}    //div[@id='step1']/div/div[not(@style)]/label    # 添加模板常规界面label
${tmpl_add1_name_ID}    id=usertmp_name    # 添加模板界面模板名称输入框
${tmpl_add1_name_error}    id=vmname_error    #添加模板常规界面模板名称错误提示信息
${tmpl_add1_select_vhd_ID}    id=template_id    # 镜像文件选择
${tmpl_add1_selectVhd_input_ID}    //div[@id='step1']//input[@role='textbox']    #添加模板常规界面镜像选择时搜索输入框
${tmpl_add1_vhd_error_ID}    id=choose_iso    #添加模板常规界面镜像选择错误提示信息
${tmpl_add1_select_nameRule_ID}    id=usertmp_name_policy_id    #添加模板常规界面命名规则选择框
${tmpl_add1_custom_input_ID}    id=name_prefix     #添加模板常规界面自定义前缀输入框
${tmpl_add1_custom_error_ID}    id=custom_prefix     #添加模板常规界面自定义前缀错误提示信息
${tmpl_add1_AD_name}    usertmp.domain_id    #创建模板常规界面AD域radio的NAME属性值
${tmpl_add1_ADtable_ID}    css=#JColResizer0    #创建模板常规界面AD域table

#创建模板界面第二步系统界面
${tmpl_add2_step2_ID}    id=step2    #添加模板系统界面
${tmpl_add2_cpu_nameattribute}    usertmp.cpu_number    #添加模板系统界面cpu数量radio的name属性值
${tmpl_add2_label_ID}    //div[@id='step2']/div/div/label    #添加模板系统界面lable
${tmpl_add2_memory_input_ID}    id=mem_quato    #添加模板系统界面内存大小输入框
${tmpl_add2_memory_error_ID}    id=memory_size    #添加模板系统界面内存错误提示信息
${tmpl_add2_disk_input_ID}    id=disk_quato    #添加模板系统界面硬盘输入框
${tmpl_add2_disk_error_ID}    id=disk_size    #添加模板系统界面硬盘错误提示信息
${tmpl_add2_diskencrypt_name}    usertmp.encrypt    #添加模板系统界面磁盘加密radio的name属性值
${tmpl_add2_audit_name}    usertmp.audit_type    #添加模板系统界面审计类型radio的name属性值
${tmpl_add2_stubdom_name}    usertmp.stubdom    #添加模板系统界面串并兼容模式radio的name
${tmpl_add2_stubdom_error}    id=serisizeError    #添加模板系统界面串并兼容模式错误提示
${tmpl_add2_radio_select_ID}    //div[@id='step2']//span[@class='lbl']    #添加模板系统界面radio显示值
${tmpl_add2_stubdom_clear}    //a[contains(@onclick,'serial')]    #添加模板系统界面串并兼容模式清空按钮
${tmpl_add3_stubdom_table}    css=#JColResizer1    #添加模板系统界面串并兼容模式table

#创建模板界面第三步网络界面
${tmpl_add3_step3_ID}    id=step3    #添加模板第三步界面
${tmpl_add3_netCard_tab_ID}    //div[@id='step3']/div/ul/li    #创建模板网络界面网卡标签选项
${tmpl_add3_status1_ID}    //input[@id='status1']    #创建模板网络界面网卡1启用网络
${tmpl_add3_netkey1_ID}    //input[@id='netkey_type_1']    #创建模板网络界面网卡1启用网卡加密
${tmpl_add3_netkey1_error_ID}    id=network_key_1_error    #创建模板网络界面网卡1网卡加密错误提示信息
${tmpl_add3_netkey1_select}    name=tmpcard1.netkey_id    #创建模板网络界面网卡密钥选择框
${tmpl_add3_vlan1_ID}    //input[@id='vlan_type_1']    #创建模板网络界面网卡1启用VLAN
${tmpl_add3_vlan1_select}    name=tmpcard1.vlan_id    #创建模板网络界面VLAN选择框
${tmpl_add3_vlan1_error_ID}    id=vlan_error_1    #创建模板玩了个界面VLAN错误提示信息
${tmpl_add3_connect_name}    tmpcard1.netcard_type     #创建模板网络界面连接方式radio的name
${tmpl_add3_card_select}    name=tmpcard1.phy_eth    #创建模板网络界面物理网卡选择框
${tmpl_add3_network_name}    tmpcard1.network_id    #创建模板网络界面选择网络radio的name
${tmpl_add3_network_table}     css=#JColResizer1    #创建模板网络界面选择网络table

#创建模板界面第四步策略界面
${tmpl_add4_step4_ID}    id=step4    #添加模板策略界面
${tmpl_add4_label_ID}    //div[@id='step4']/div/div[not(@style)]/label    #添加模板策略界面label
${tmpl_add4_policy_name}    device.id    #创建模板策略界面设备策略radio的name
${tmpl_add4_table_ID}    css=#JColResizer6    #创建模板策略界面table
${tmpl_add4_deviceD_info}    //div[@id='step4']//tbody/tr[1]/td    #创建模板策略界面table默认值

#创建模板界面第五步概览界面
${tmpl_add5_step5_ID}    id=step5    #添加模板概览界面
${tmpl_add5_label_ID}    //div[contains(@class,'profile-info-row') and not(@style)]/div[1]    #创建模板界面概览中label
${tmpl_add5_netLable_ID}    //div[not(@style) and contains(@class,'profile-info-row _netcard1_status')]/div[contains(@class,'profile-info-name')]    #创建模板概览中网络label
${tmpl_add5_value_ID}    //div[not(@style)]/div[@class='profile-info-value']    #创建模板界面概览中value
${tmpl_add_nextbtn_ID}    //button[contains(@class,'btn-submit-ok')]    # 添加模板界面“下一步”按钮
${tmpl_add_prevbtn_ID}    //button[contains(@class,'btn-prev')]    # 添加模板界面上一步按钮

# 分配用户
${tmpl_assginUser_button_ID}    //input[contains(@onclick,'configTmpl')]    #模板管理界面分配用户按钮
${tmpl_assignUser_warn_ID}    //font    #分配用户界面第二个title旁边的警告信息
${tmpl_assignUser_userinput_ID}    id=searchName    #分配用户界面用户名输入框
${tmpl_assignUser_userGroup_select}    id=citySel    #分配用户界面用户组选择框
${tmpl_assignUser_clear_button}    id=menuBtn    #分配用户界面清空按钮
${tmpl_assignUser_search_button}    //button[contains(@onclick,'queryAtoStarthSubmit')]    #分配用界面查询按钮

#使用情况
${tmpl_use_iframe_ID}    id=acetab_ifr_tab_tmpl_0004    #使用情况界面iframe
${tmpl_use_UI_ID}    id=tab_tmpl_0004    #使用情况界面
${tmpl_use_tab_ID}    id=tab_tab_tmpl_0004    #使用情况界面tab
${tmpl_use_delete_button}    id=addBut    #使用情况界面删除按钮
${tmpl_use_setAuto_button}    id=dis1    #使用情况界面设置开关机联动按钮
${tmpl_use_celAuto_button}    id=dis2    #使用情况界面取消开关机联动按钮
${tmpl_use_button_ID}    //input[contains(@onclick,'seeTmplUser')]    #创建模板管理界面使用情况按钮
${tmpl_search_input_ID}    name=pageInfo.f_name    #创建模板界面搜索输入框

#vlan管理界面
${vlan_menu_ID}    //li[contains(@onclick,'VLAN')]    #左侧树中VLAN选项
${vlan_tab_ID}    //a[@href='#tab_936423']    #vlan标签页
${vlan_UI_ID}    id=tab_936423    #vlan界面
${vlan_manage_iframe_ID}    id=acetab_ifr_tab_936423    #vlan管理界面iframe
${vlan_create_button_ID}    //input[contains(@onclick,'addVlan')]    #vlan管理界面新建VLAN按钮
${vlan_create_label_ID}    //label    #新建VLAN界面label
${vlan_create_name_input_ID}    id=key_name    #新建VLAN界面名称输入框
${vlan_create_name_error_ID}    id=key_name_error    #新建VLAN界面名称错误提示
${vlan_create_key_input_ID}    id=key_value    #新建VLAN界面值输入框
${vlan_create_key_error_ID}    id=key_value_error    #新建VLAN界面值错误提示
${vlan_search_label_ID}    //span[@class='input-group-addon']    #vlan管理界面搜索label
${vlan_search_input_ID}    name=pageInfo.f_key_name    #vlan管理界面搜索输入框
${vlan_manage_table_head}    //thead//td    # vlan管理界面table的head

#升级包管理界面
${up_menu_ID}    //li[contains(@onclick,'936392')]    #左侧树中升级包栏
${up_tab_ID}    //a[@href='#tab_936392']    #升级包标签页
${up_UI_ID}    id=tab_936392    #升级包界面
${up_package_iframe_ID}    id=acetab_ifr_tab_936392    #升级包界面iframe
${up_upPackage_button_ID}    //input[contains(@onclick,'addPatch')]    #升级包管理界面上传升级包按钮
${up_package_label_ID}    //div[@class='form-group' and not(@style='display:none')]//label    #上传升级包界面label
${up_package_choose_ID}    id=fileupload    #上传升级包界面选择文件
${up_package_upButton_ID}    //span[@id='upload']/button    #上传升级包界面上传按钮
${up_package_name_input_ID}    id=name    #上传升级包界面升级包名称输入框
${up_package_version_input_ID}    id=vtop_version    #上传升级包界面版本输入框
${up_package_des_input_ID}    id=release_note    #上传升级包界面说明输入框
${up_package_name_err_ID}    id=name_error    #上传升级包界面名称错误
${up_package_version_err_ID}    id=vtop_version_error    #上传升级包界面版本错误
${up_package_upshow_ID}    id=upshow    #上传升级包界面上传过程中文件名

#AD域
${ad_menu_ID}    //li[contains(@onclick,'936419')]    #左侧树中AD选择栏
${ad_tab_ID}    //a[@href='#tab_936419']    #ad域的tab
${ad_manage_UI_ID}    id=tab_936419    #ad域管理界面
${ad_manage_iframe_ID}    id=acetab_ifr_tab_936419    #ad管理界面iframe
${ad_create_button_ID}    //input[contains(@onclick,'addDomain')]    #ad管理界面新建ad域按钮
${ad_create_label_ID}    //label    #新建AD域界面label
${ad_create_name_input_ID}    id=domainName    #新建AD域界面名称输入框
${ad_create_name_error_ID}    id=domainName_error    #新建AD域界面名称错误提示信息
${ad_create_ip_input_ID}    id=dnsServer    #新建AD域界面服务器地址输入框
${ad_create_ip_error_ID}    id=dnsServer_error    #新建AD域界面服务器地址错误提示信息
${ad_create_user_input_ID}    id=domainUserName    #新建AD域界面用户名
${ad_create_user_error_ID}    id=domainUserName_error    #新建AD域界面用户名错误提示信息
${ad_create_pwd_input_ID}    id=domainPassWord    #新建AD域界面密码
${ad_create_pwd_error_ID}    id=domainPassWord_error    #新建AD域界面密码错误提示信息
${ad_create_des_input_ID}    id=description    #新建AD域界面说明
${ad_search_label_ID}    //span[@class='input-group-addon']    #AD域管理界面搜索栏信息
${ad_search_input_ID}    name=pageInfo.f_domainName    #AD域管理界面搜索输入框
#设备管理
${device_menu_ID}   //li[contains(@onclick,'936396')]   #左侧树中设备
${device_tab_ID}    //a[@href='#tab_936396']    #设备管理tab
${device_manage_UI_ID}  id=tab_936396   #设备管理界面
${device_manage_iframe_ID}  id=acetab_ifr_tab_936396    #设备管理界面iframe
${device_create_button_ID}  //input[contains(@onclick,'addDevice')]    #设备管理界面新建设备按钮
${device_create_name_input_ID}    id=device_name  #新建设备界面设备名称输入框
${device_create_name_error_ID}  id=device_name_span    #新建设备界面设备名称错误提示信息
${device_create_tag_input_ID}    id=device_tag   #新建设备界面设备标签输入框
${device_create_type_input_ID}    id=device_type  #新建设备界面设备类型选择框
${device_create_vid_input_ID}    id=usb_vid   #新建设备界面厂商ID输入框
${device_create_vid_error_ID}   id=usb_vid_span    #新建设备界面厂商ID错误提示信息
${device_create_pid_input_ID}    id=usb_pid  #新建设备界面产品ID输入框
${device_create_pid_error_ID}   id=usb_pid_span    #新建设备界面设备产品ID错误提示信息
${device_create_des_ID}    id=description  #新建设备界面描述输入框
${device_search_label_ID}    //span[@class='input-group-addon']    #设备管理界面搜索栏信息
${device_search_input_ID}    name=pageInfo.f_device_name    #设备管理界面搜索输入框
#网络管理
${net_menu_ID}    //li[contains(@onclick,'936415')]    #左侧树中网络
${net_tab_ID}    //a[@href='#tab_936415']    #网络管理tab
${net_manage_UI_ID}    id=tab_936415    #网络管理界面
${net_manage_iframe_ID}    id=acetab_ifr_tab_936415    #网络管理界面iframe
${net_create_button_ID}    //input[contains(@onclick,'addNetwork')]    #网络管理界面新建网络按钮
${net_create_label_ID}    //label    #新建网络界面label
${net_create_name_input_ID}    id=network_name    #新建网络界面网络名称输入框
${net_create_name_error_ID}    id=network_name_error    #新建网络界面网络名称错误提示信息
${net_create_ipStart_input_ID}    id=ip_start    #新建网络界面开始地址输入框
${net_create_ipStart_error_ID}    id=ip_start_error    #新建网络界面开始地址错误提示信息
${net_create_ipEnd_input_ID}    id=ip_end    #新建网络界面结束地址输入框
${net_create_ipEnd_error_ID}    id=ip_end_error    #新建网络界面结束地址错误提示信息
${net_create_mask_input_ID}    id=mask    #新建网络界面子网掩码输入框
${net_create_mask_error_ID}    id=mask_error    #新建网络界面子网掩码错误提示信息
${net_create_gateway_input_ID}    id=gateway    #新建网络界面网关输入框
${net_create_gateway_error_ID}    id=gateway_error    #新建网络界面网关错误提示信息
${net_create_dns1_input_ID}    id=dns_first    #新建网络界面DNS服务器输入框
${net_create_dns1_error_ID}    id=dns_first_error    #新建网络界面DNS服务器错误提示信息
${net_create_dns2_input_ID}    id=dns_second    #新建网络界面备用DNS输入框
${net_create_dns2_error_ID}    id=dns_second_error    #新建网络界面备用DNS错误提示信息
${net_create_des_ID}    id=description    #新建网络界面说明输入框
${net_search_label_ID}    //span[@class='input-group-addon']    #网络管理界面搜索栏信息
${net_search_input_ID}    name=pageInfo.f_network_name    #网络管理界面搜索输入框
#漫游数据
${wander_menu_ID}    //li[contains(@onclick,'936420')]    #左侧树中漫游数据
${wander_tab_ID}    //a[@href='#tab_936420']    #漫游数据tab
${wander_manage_UI_ID}    id=tab_936420    #漫游数据管理界面
${wander_manage_iframe_ID}    id=acetab_ifr_tab_936420    #漫游数据管理界面iframe
${wander_clearSpace_button_ID}    //input[contains(@onclick,'clearWanderSpare')]    #清空漫游数据
${wander_search_Label_ID}    //span[@class='input-group-addon']    #漫游管理界面搜索栏
${wander_search_userInput_ID}    name=pageInfo.f_created_name    #漫游数据管理界面用户名输入框
${wander_search_select_ID}    id=state    #漫游数据管理界面数据类型选择框
#镜像
${vhd_menu_ID}    //li[contains(@onclick,'936397')]    #左侧树中镜像
${vhd_tab_ID}    //a[@href='#tab_936397']    #镜像tab
${vhd_manage_UI_ID}    id=tab_936397    #镜像管理界面
${vhd_manage_iframe_ID}    id=acetab_ifr_tab_936397    #镜像管理界面iframe
${vhd_create_button_ID}    //input[contains(@onclick,'addPatch')]    #镜像管理界面创建镜像按钮
${vhd_merge_button_ID}    //input[contains(@onclick,'mergePatch')]    #镜像管理界面合并镜像按钮
${vhd_desktop_button_ID}    //input[contains(@onclick,'setDesktop')]    #镜像管理界面设备桌面按钮
${vhd_clear_button_ID}    //input[contains(@onclick,'cleanTemplates')]    #镜像管理界面清理镜像按钮
${vhd_getVC_button_ID}    //input[contains(@onclick,'getTopVC')]    #镜像管理界面获取镜像列表按钮
${vhd_local_table_head}    //*[@id='localvc']//th    # 镜像管理界面本地镜像table的head
${vhd_topvc_table_head}    //*[@id='topvc']//th
${vhd_create_label}    //div[@class='form-group' and not(@style='display:none')]//label    #创建镜像界面label
${vhd_create_fileErr_ID}    id=other_error    #创建镜像界面镜像文件错误提示信息
${vhd_create_name_input_ID}    id=name    #创建镜像界面镜像名称
${vhd_create_name_error_ID}    id=name_error    #创建镜像界面镜像名称错误提示信息
${vhd_create_version_input_ID}    id=template_version    #创建镜像界面版本输入框
${vhd_create_version_error_ID}    id=template_version_error    #创建镜像界面版本错误提示信息
${vhd_create_description_ID}    id=release_note    #创建镜像界面说明输入框
${vhd_create_selectFile_ID}    id=fileupload    #创建镜像界面浏览文件
${vhd_create_upButton_ID}    id=uploadbtn    #创建镜像界面上传文件按钮
${vhd_create_upFileName_ID}    id=upshow    #创建镜像界面上传文件名显示
${vhd_create_upProgress_ID}    //div[@id='progress']/div    #创建镜像界面上传文件进度条
${vhd_create_up100%_ID}    //div[@class='progress-bar progress-bar-success' and @style='width:100%;']/..    #创建镜像界面上传文件上传到100%
${vhd_search_label_ID}    //span[@class='input-group-addon']    #镜像管理界面搜索栏
${vhd_search_input_ID}    name=pageInfo.f_name    #镜像管理界面搜索输入框
${vhd_local_table_ID}    css=#localvc    #镜像管理界面本地镜像table
${vhd_topvc_table_ID}    css=#topvc    #镜像管理界面上级镜像table
${vhd_desktop_UI_ID}    id=radio_wrap    #设置桌面界面
${vhd_local_radio_name}    orderId    #镜像管理界面本地镜像中radio
${vhd_desktop_imgs_ID}    //li/label/img    #设置桌面界面未勾选的桌面图片
${vhd_desktop_error_ID}    id=other_error    #设置桌面界面错误提示信息
${vhd_prompt_info_ID}    //div[@class='alert alert-block alert-success']    #镜像管理界面警告提示信息
${vhd_detail_name}    //div[@class='profile-info-name']    # 镜像详细信息界面name栏
${vhd_detail_value}    //div[@class='profile-info-value']    # 镜像详细信息界面value栏

# 排序元素
${tmpl_sort_name}    //a[contains(@href,'name')]    # 模板管理界面--模板名称排序
${tmpl_sort_vhd}    //a[contains(@href,'template_id')]    # 模板管理界面--镜像名称排序
${tmpl_sort_encrypt}    //a[contains(@href,'encrypt')]    # 模板管理界面--磁盘是否加密排序
${tmpl_sort_cpu}    //a[contains(@href,'cpu_number')]    # 模板管理界面--cpu数量排序
${tmpl_sort_disk}    //a[contains(@href,'disk_quato')]    # 模板管理界面--磁盘大小排序
${tmpl_sort_memory}    //a[contains(@href,'mem_quato')]    # 模板管理界面--内存大小排序
${vhd_sort_local_name}    //*[@id='localvc']//a[contains(@href,'name')]    # 镜像管理界面--本地镜像名称排序
${vhd_sort_topvc_name}    //*[@id='topvc']//a[contains(@href,'name')]    #镜像管理界面--上级镜像名称
${wander_sort_user}    //a[contains(@href,'created_name')]    #漫游数据界面--用户名排序
${wander_sort_type}    //a[contains(@href,'type')]    #漫游数据界面--数据类型排序
${wander_sort_date}    //a[contains(@href,'created_date')]    #漫游数据界面--时间排序
${device_sort_name}    //a[contains(@href,'device_name')]    # 设备管理界面--设备名称排序
${device_sort_type}    //a[contains(@href,'device_type')]    # 设备管理界面--设备类型排序
${ad_sort_name}    //a[contains(@href,'domainName')]    #AD域界面--名称排序
${vlan_sort_name}    //a[contains(@href,'key_name')]    #VLAN界面--名称排序
${up_patch_sort_name}    //a[contains(@href,'name')]    #升级包界面--名称排序