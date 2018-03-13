*** Variables ***
${log_manage_menu_ID}    //a[@class='dropdown-toggle']/i[contains(@class,'fa-file-text')]/..    #左侧树中日志管理
${log_table_head}    //table[@id='sample-table-2']//th    # 日志管理界面table的head

# vTop日志
${vtoplog_menu_ID}    //li[contains(@onclick,'936408')]    #左侧树中vTop日志选项
${vtoplog_tab_ID}    //a[@href='#tab_936408']    #vTop日志标签页
${vtoplog_UI_ID}    id=tab_936408    #vTop日志界面
${vtoplog_manage_iframe_ID}    id=acetab_ifr_tab_936408    #vTop日志管理界面iframe
${vtoplog_delete_button}    //input[contains(@onclick,'deleteChecked')]    #vTop日志管理界面删除按钮
${vtoplog_search_vmName_input}    name=pageInfo.f_vm_name    #vTop日志管理界面搜索栏虚拟机输入框
${vtoplog_search_time_input}    id=id-date-range-picker-1    #vTop日志管理界面搜索栏执行时间选择框
${vtoplog_search_time_label}    //div[@class='range_inputs']//label    #vTop日志界面搜索栏执行时间栏选择时间栏信息
${vtoplog_search_time_button}    //div[@class='range_inputs']//button    #vTop日志界面搜索栏执行时间栏选择时间按钮

# 系统日志
${syslog_menu_ID}    //li[contains(@onclick,'936410')]    #左侧系统日志菜单
${syslog_UI_ID}    id=tab_936410    #系统日志界面
${syslog_tab_ID}    //a[@href='#tab_936410']    #系统日志标签页
${syslog_iframe_ID}    id=acetab_ifr_tab_936410    #系统日志界面iframe
${syslog_delete_button}    //input[contains(@onclick,'deleteChecked')]    #系统日志管理界面删除按钮
${syslog_search_mode_select}    name=pageInfo.f_function    #系统日志界面搜索栏模块选择框
${syslog_search_operator_input}    name=pageInfo.f_creatorName    #系统日志界面搜素栏操作人员输入框
${syslog_search_opeartype_select}    name=pageInfo.f_type    #系统日志界面搜索栏操作类型选择框
${syslog_search_remarks_input}    name=pageInfo.f_message    #系统日志界面搜索栏备注输入框
${syslog_search_time_select}    name=date-range-picker    #系统日志界面搜素栏操作时间选择框
${syslog_search_time_label}    //div[@class='range_inputs']//label    #系统日志界面搜索栏执行时间栏选择时间栏信息
${syslog_search_time_button}    //div[@class='range_inputs']//button    #系统日志界面搜索栏执行时间栏选择时间按钮

# 日志管理界面排序元素
${log_syssort_creator}    //a[contains(@href,'creatorName')]    #系统日志排序--操作人员
${log_syssort_date}    //a[contains(@href,'createDate')]    #系统日志排序--操作时间
${log_syssort_type}    //a[contains(@href,'type')]    #系统日志排序--操作类型
${log_vtopsort_start}    //a[contains(@href,'start_time')]    #vTop日志排序--开始时间
${log_vtopsort_end}    //a[contains(@href,'end_time')]    #vTop日志排序--结束时间
${log_vtopsort_vmname}    //a[contains(@href,'vm_name')]    #vTop日志排序--虚拟机名称
${log_vtopsort_uuid}    //a[contains(@href,'src_vm_uuid')]    #vTop日志排序--虚拟机uuid
${log_vtopsort_type}    //a[contains(@href,'request_type')]    #vTop日志排序--类型
${log_vtopsort_status}    //a[contains(@href,'status')]    #vTop日志排序--状态