*** Variables ***
${vtop_manage_ID}    //i[contains(@class,'fa-desktop')]/..    #左侧vtop管理菜单栏

#位置管理
${local_menu_ID}    //li[contains(@onclick,'936391')]    #左侧位置菜单栏
${local_tab_ID}    //a[@href='#tab_936391']    #位置管理标签页
${local_manage_UI_ID}    id=tab_936391    #位置管理界面
${local_tab_iframe_ID}    id=acetab_ifr_tab_936391    #位置标签页的iframe
${local_manage_iframe_ID}    id=nodegroupView    #位置管理界面的iframe
${local_create_button_ID}    //button[contains(@onclick,'orgAdd')]    #位置管理界面上新建位置按钮
${local_create_label_ID}    //label    #新建位置界面上label
${local_create_name_input_ID}    id=name    #新建位置界面上位置输入框
${local_create_name_error_ID}    id=appendStr    #新建位置界面上位置名称错误提示信息
${local_create_mark_ID}    id=groupmark    #新建位置界面上前缀输入框
${local_create_mark_error_ID}    id=append_groupmark    #新建位置界面前缀错误提示信息
${local_create_network_table_ID}   css=#JColResizer0    #新建位置界面上选择网络table
${local_create_Location_ID}    //p    #新建位置界面上所属位置显示信息框
${local_create_description_ID}    id=orgdescription    #新建位置界面上描述
${local_search_label_ID}    //span[@class='input-group-addon']    #位置管理界面搜索栏
${local_search_input_ID}    name=pageInfo.f_name    #位置管理界面输入框
${lcoal_network_radio_name}    org.network_id    #新建位置界面选择网络radio的name

#虚拟机管理
${vm_menu_ID}    //li[contains(@onclick,'936411')]    #左侧树中虚拟机
${vm_tab_ID}    //a[@href='#tab_936411']    #虚拟机管理标签页
${vm_manage_UI_ID}    id=tab_936411    #虚拟机管理界面
${vm_manage_iframe_ID}    id=acetab_ifr_tab_936411    #虚拟机管理界面iframe
${vm_manage_table_ID}    css=#virtualTab    #虚拟机管理界面table
${vm_delete_button_ID}    //button[contains(@onclick,'delete_vm')]    #虚拟机管理界面删除按钮
${vm_rollBack_button}    //input[contains(@onclick,'rollback_vm')]     # 虚拟机管理界面还原按钮
${vm_start_button_ID}    //input[contains(@onclick,'turnon_vm')]    #虚拟机管理界面开机按钮
${vm_shutdown_button_ID}    //input[contains(@onclick,'shutdown_vm')]    #虚拟机管理界面关机按钮
${vm_reboot_button_ID}    //input[contains(@onclick,'restart_vm')]    #虚拟机管理界面重启按钮
${vm_update_buuton_ID}    //input[contains(@onclick,'download_vm')]    #虚拟机管理界面更新按钮
${vm_search_clearbtn_ID}    //button[contains(@onclick,'removeDate')]    #虚拟机管理界面搜索中清空按钮
${vm_srcUser_input_ID}    id=user_id    #虚拟机管理界面搜索中用户名输入框
${vm_srcVM_input_ID}    name=pageInfo.f_vm_name    #虚拟机管理界面搜索中虚拟机名称
${vm_srcLocal_input_ID}    id=citySel    #虚拟机管理界面搜索中所属位置
${vm_srcTop_input_ID}    id=node_id    #虚拟机管理界面搜索中所属vTop

#vTop管理
${vtop_menu_ID}    //li[contains(@onclick,'936390')]    #左侧树中vTop
${vtop_tab_ID}    //a[@href='#tab_936390']    #vTop管理标签页
${vtop_manage_UI_ID}    id=tab_936390    #vTop管理界面
${vtop_manage_iframe_ID}    id=acetab_ifr_tab_936390    #vTop管理界面iframe
${vtop_manage_iframe1_ID}    id=nodeView    #vTop管理界面第二个iframe
${vtop_manage_table_ID}    css=#vtopTab    #vTop管理界面table
${vtop_start_button_ID}    //input[contains(@onclick,'startup_vtop')]    #vTop管理界面开机按钮
${vtop_shutdown_button_ID}    //input[contains(@onclick,'shutdown_vtop')]    #vTop管理界面关机按钮
${vtop_restart_button_ID}    //input[contains(@onclick,'restart_vtop')]    #vTop管理界面重启按钮
${vtop_basic_button_ID}    //div[@class='btn-group']/button    #vTop管理界面基础操作
${vtop_basic_push_ID}    //a[contains(@onclick,'pushto_vtop')]    #推送镜像按钮
${vtop_basic_change_ID}    //a[contains(@onclick,'change_group')]    #更换位置按钮
${vtop_basic_autoStart_ID}    //a[contains(@onclick,'toAutoStart')]    #启用自动登录按钮
${vtop_basic_autoStop_ID}    //a[contains(@onclick,'stopAnonymous')]    #禁用自动登录按钮
${vtop_basic_upgrade_ID}    //a[contains(@onclick,'upgrade_vtop')]    #升级按钮
${vtop_basic_toBind_ID}    //a[contains(@onclick,'toBinding')]    #绑定用户按钮
${vtop_basic_cacelBind_ID}    //a[contains(@onclick,'cacelBinding')]    #取消绑定按钮
${vtop_basic_gateway_ID}    //a[contains(@onclick,'setGateway')]    #设置成网关按钮
${vtop_switch_button_ID}    name=switch-field-1    #vTop管理table中操作旁边选择按钮
${vtop_switch_label_ID}    //span[@class='lbl']    #vTop管理table中操作旁边选择详细信息
${vtop_table_head}    //th[not(contains(@style,'none'))]    #vTop管理table中head

# 排序元素
${vtop_sort_name}    //a[contains(@href,'host_name')]    # vtop管理界面排序--主机名
${vtop_sort_group}    //a[contains(@href,'group_id')]    # vtop管理界面排序--所在位置
${vtop_sort_mark}    //a[contains(@href,'vtop_mark')]    #vtop管理界面排序--编号
${vtop_sort_ip}    //a[contains(@href,'ip_address')]    # vtop管理界面排序--IP地址
${vtop_sort_bindUser}    //a[contains(@href,'binding_id')]    # vtop管理界面排序--绑定用户
${vtop_sort_anonymous_login}    //a[contains(@href,'anonymous_login')]    # vtop管理界面排序--自动登录
${vtop_sort_wsstate}    //a[contains(@href,'wsstate')]    # vtop管理界面排序--虚拟机状态
${vm_sort_name}    //a[contains(@href,'vm_name')]    # 虚拟机管理界面排序--虚拟机名称
${vm_sort_tmplate}    //a[contains(@href,'account_tmplate_id')]    # 虚拟机管理界面排序--镜像名称
${vm_sort_vtop}    //a[contains(@href,'vtop_id')]    # 虚拟机管理界面排序--所属vTop
${vm_sort_user}    //a[contains(@href,'user_id')]    # 虚拟机管理界面排序--所属用户
${vm_sort_status}    //a[contains(@href,'loaded_status')]    # 虚拟机管理界面排序--虚拟机状态
${local_sort_name}    //a[contains(@href,'name')]    # 位置管理界面排序--位置
${local_sort_parentname}    //a[contains(@href,'parentname')]    # 位置管理界面排序--所属位置