*** Variables ***
${user_manage_menu_ID}    //i[@class='menu-icon fa fa-user']/..    #左侧用户管理菜单按钮

#用户管理
${tuser_tab_ID}    id=tab_tab_936388    #用户标签
${tuser_shortcutbth_ID}    //button[contains(@onclick,'quickClick1')]    #用户快捷按钮
${tuser_menu_ID}    //li[contains(@onclick,'936388')]    # 左侧用户选择栏
${tuser_UI_ID}    id=tab_936388    #用户管理页面
${tuser_iframetab_ID}    id=acetab_ifr_tab_936388    #用户tab标签iframe
${tuser_iframmgr_ID}    id=usermgrView    #用户信息iframe

# 添加用户界面
${tuser_addbth_ID}    //button[contains(@onclick,'add_user')]    #vtop用户添加按钮
${tuser_add_label}    //div[@class='form-group' and not(@style)]/label    #添加用户界面label
${tuser_addname_ID}    id=username    #vtop添加界面用户名输入框
${tuser_username_error_ID}    id=username_error    # 用户名异常信息
${tuser_addrealname_ID}    id=real_name    #vtop用户添加真实姓名输入框
${tuser_realname_error_ID}    id=real_name_error    #vtop用户添加真实姓名错误信息
${tuser_addpwd_ID}    id=password    #vtop用户添加密码输入框
${tuser_addpwd_error_ID}    id=password_error    #vtop用户添加时密码错误信息
${tuser_addemail_ID}    id=email    #vtop用户添加邮箱输入框
${tuser_addemail_error_ID}    id=email_error    #vtop用户添加email错误信息
${tuser_addgrp_ID}    //*[@id="editUsermgrForm"]/div[5]/div/p    #vtop用户添加所属用户输入框
${tuser_addpub_nameattrbute}    usermgr.ispublisher    #vtop用户是否为发布者radio的name属性值
${tuser_addtime_ID}    id=expired_date    #vtop用户添加有效期输入框
${tuser_addtime_select_UI}    //div[@class='datepicker-days']    #用户添加界面时间选择界面
${tuser_addtime_select_D}    //td[@class='active day']    #用户添加界面已选择的天
${tuser_addtime_select_YM}    //div[@class='datepicker-days']//th[@class='datepicker-switch' ]    #用户添加界面已选择的年月
${tuser_addable_nameattrbute}    usermgr.status    #vtop用户是否开通radio的name属性值
${tuser_radio_lable}    //label[@class='radio-inline']    #添加用户界面radio的选择信息
${tuser_diskEcrypt_input}    //form/div[6]/div/p    #编辑用户界面磁盘加密输入框
${tuser_userDir_input}    //form/div[8]/div/p    #编辑用户界面用户目录输入框
${tuser_search_input_ID}    //*[@id="searchName"]    #搜索输入框

# 基础操作
${tuser_basis_button_ID}    //button[@data-toggle='dropdown']    #vtop用户管理界面中“基础操作”按钮
${tuser_basis_policy_ID}    //a[contains(@onclick,'config_policy')]    #基础操作中“用户策略”
${tuser_basis_resetpwd_ID}    //a[contains(@onclick,'reset_pwd')]    #基础操作中“重置密码”
${tuser_basis_openuser_ID}    //a[contains(@onclick,'valid_user')]    #基础操作中“开通用户”
${tuser_basis_stopuser_ID}    //a[contains(@onclick,'stop_user')]    #基础操作中“停用用户”
${tuser_basis_changegroup_ID}    //a[contains(@onclick,'change_group')]    #基础操作中“更换用户组”
${tuser_basis_import_ID}    //a[contains(@onclick,'toImportUser')]    #基础操作中“导入用户”

#分配模板界面
${tuser_assign_template_button}    //button[contains(@onclick,'config_virtual')]    #分配模板按钮
${tuser_assigntmpl_title}    //strong    #分配模板界面第二个title
${tuser_assigntmpl_warn}    //font    #分配模板界面第二个title旁边警告信息
${tuser_assigntmpl_label}    //label[@for='searchName']    #分配模板界面模板名称栏
${tuser_assigntmpl_nameinput}    id=tmpl_name    #分配模板界面模板名称输入框
${tuser_assigntmpl_search_button}    //button[contains(@onclick,'queryTPSubmit')]    #分配模板界面搜索按钮
${tuser_assigntmpl_number_ID}    //a[contains(@onclick,'see_virtual')]    #用户管理界面上用户已分配的模板数量（>=1）

#用户配置用户策略界面
${tuser_policy_title2_ID}    //strong    #配置用户策略第二个title
${tuser_policy_title_userinfo_ID}    //small    #配置用户策略第二个title中用户信息
${tuser_policy_confirm_button_ID}    id=addBut    #配置用户策略界面确定按钮
${tuser_policy_cancel_button_ID}    id=dis1    #配置用户策略界面取消按钮
${tuser_policy_nameattribute}    usermgr.user_policy_id    #配置用户策略界面上策略的radio的name属性
${tuser_policy_default}    //tr[1]/td    # 配置用户策略界面默认策略行

#更换用户组界面
${tuser_group_select_box_ID}    id=citySel    #更换用户组界面用户组选择框
${tuser_group_menu_ID}    id=menuContent    #更换用户组界面点击用户组选择后显示用户组信息
${tuser_group_clear_button_ID}    id=menuBtn    #更换用户组界面清空按钮
${tuser_group_heaher_info_ID}    //h4    #更换用户组界面绿色标题
${tuser_group_error_ID}    id=other_error    #更换用户组界面用户组信息错误

#查看虚拟机界面
${tuser_seevm_iframe}    id=acetab_ifr_tab_usermgr_0009    #用户虚拟机界面iframe
${tuser_seevm_UI}    id=tab_usermgr_0009    #用户虚拟机界面
${tuser_seevm_tab}    id=tab_tab_usermgr_0009    #用户虚拟机界面tab
${tuser_seevm_delet_button_ID}    //button[contains(@onclick,'delete_vm')]    #用户查看虚拟机界面删除按钮
${tuser_seevm_start_button_ID}    //input[contains(@onclick,'turnon_vm')]    #用户查看虚拟机界面开机按钮
${tuser_seevm_shutdown_button_ID}    //input[contains(@onclick,'shutdown_vm')]    #用户查看虚拟机界面关机按钮
${tuser_seevm_restart_button_ID}    //input[contains(@onclick,'restart_vm')]    #用户查看虚拟机界面重启按钮
${tuser_seevm_update_button_ID}    //input[contains(@onclick,'download_vm')]    #用户查看虚拟机界面更新按钮
${tuser_seevm_rollback_button}    //input[contains(@onclick,'rollback_vm')]    #用户查看虚拟机界面还原按钮
${tuser_seevm_table_ID}    css=#virtualTab    #用户查看虚拟机界面table
${tuser_seevm_search_userinput_ID}    name=usermgr.username    #用户查看虚拟机界面搜索用户名输入框
${tuser_seevm_search_vminput_ID}     name=pageInfo.f_vm_name    #用户查看虚拟机界面虚拟机输入框
${tuser_seevm_search_vmStatus}    name=pageInfo.f_loaded_status    #用户虚拟机界面搜索栏中虚拟机状态选择框
${tuser_seevm_search_cityinput_ID}    //input[@id='citySel']    #用户查看虚拟机界面所属位置输入框
${tuser_seevm_search_vtopselect_ID}    id=node_id    #用户查看虚拟机界面vtop选择框
${tuser_seevm_search_clear_button}    //button[contains(@onclick,'removeDate')]    #用户查看虚拟机界面清空按钮
${tuser_seevm_table_vmName}    id=vm_name    #用户查看虚拟机界面table中虚拟机名称
${tuser_seevm_table_tempName}    id=account_tmplate_id    #用户查看虚拟机界面table中模板名称
${tuser_seevm_table_vtop}    id=vtop_id    #用户查看虚拟机界面table中所属vTop
${tuser_seevm_table_user}    id=user_id    #用户查看虚拟机界面table中所有用户
${tuser_seevm_table_status}    id=loaded_status    #用户查看虚拟机界面table中虚拟机状态

#查看模板界面
${tuser_seetmpl_UI}    id=tab_usermgr_0008    # 查看模板界面
${tuser_seetmpl_tab_ID}    id=tab_tab_usermgr_0008    # 查看模板界面标签
${tuser_seetmpl_iframe_ID}    id=acetab_ifr_tab_usermgr_0008    #查看模板界面iframe
${tuser_seetmpl_deletes_button}    //button[contains(@onclick,'del_virtuals')]    #查看模板界面删除按钮
${tuser_seetmpl_cancle_auto_button}    //i[contains(@class,'fa-undo')]/..    #查看模板界面取消开关机联动按钮
${tuser_seetmpl_user&group_info}    //small    #查看模板界面用户组和用户信息栏
${tuser_seetmpl_detail_label}    //div[contains(@class,'profile-info-row')]/div[1]    # 查看模板界面模板详细信息名称栏
${tuser_seetmpl_detail_value}    //div[@class='profile-info-value']    # 查看模板界面模板详细信息值

#用户详情界面
${tuser_userdetail_label}    //div[@class='profile-info-name']    #用户详情界面label栏
${tuser_userdetail_value}    //div[@class='profile-info-value']    #用户详情界面真实姓名栏

#排序相关元素
${tuser_sort_username_ID}    id=username    #排序中用户名
${tuser_sort_realname_ID}    id=real_name    #排序中真实姓名
${tuser_sort_group_ID}    id=group_id    #排序中所属用户组
${tuser_sort_pub_ID}    id=ispublisher    #排序中发布者
${tuser_sort_template_ID}    id=template_number    #排序中模板数量
${tuser_sort_usergroup_name_ID}    id=title_name    #排序中用户组
${tuser_sort_parentgroup_ID}    id=title_parentname    #排序中用户组的所属用户组

#导入用户界面
${tuser_import_label_ID}    //label    #导入用户界面“请选择用户文件”栏
${tuser_import_upload_ID}    id=upload    #导入用户界面浏览文件
${tuser_import_error_ID}    id=other_error    #导入用户界面错误提示信息

# 用户组管理界面
${ugrp_manage_tab_ID}    id=tab_tab_936409    #用户组管理界面tab
${ugrp_manage_UI}    id=tab_936409    # 用户管理界面
${ugrp_manage_menu_ID}    //li[contains(@onclick,'936409')]    #左侧用户组菜单栏
${ugrp_tabiframe_ID}    id=acetab_ifr_tab_936409    #用户组标签iframe
${ugrp_mgriframe_ID}    id=usergroupView    #用户组界面iframe
${ugrp_add_button_ID}    //input[contains(@onclick,'orgAdd')]    #新建用户组按钮
${ugrp_add_iframe_ID}    //iframe[contains(@id,'layui-layer-iframe')]    #新建用户组界面iframe
${ugrp_search_nameinput_ID}    //input[@class='inputtext2']    #用户组管理界面上搜索名称输入框
${ugrp_add_nameinput_ID}    id=name    #新建用户组界面用户组名称输入框
${ugrp_add_name_error_ID}    id=appendStr    #新建用户组界面上用户组名称错误提示信息
${ugrp_add_superior_input_ID}    //p    #新建用户组界面上级用户输入框
${ugrp_add_describe_input_ID}    id=orgdescription    #新建用户组界面用户组描述输入框