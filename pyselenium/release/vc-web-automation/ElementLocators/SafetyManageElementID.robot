*** Variables ***
${safety_manage_menu_ID}    //a[@class='dropdown-toggle']/i[contains(@class,'fa-id-card')]/..    #左侧树中安全管理

#网络密钥
${netKey_menu_ID}    //li[contains(@onclick,'936421')]    #左侧树中网络密钥栏
${netKey_tab_ID}    //a[@href='#tab_936421']    #网络密钥标签页
${netKey_manage_UI_ID}    id=tab_936421    #网络密钥管理界面
${netKey_manage_iframe_ID}    id=acetab_ifr_tab_936421    #网络密钥管理界面iframe
${netKey_create_button_ID}    //input[contains(@onclick,'addNetkey')]    #网络密钥管理界面新建网络密钥按钮
${netKey_create_name_input_ID}    id=key_name    #新建网络密钥界面名称输入框
${netKey_create_name_error_ID}    id=key_name_error    #新建网络密钥界面名称错误提示信息
${netKey_create_key_input_ID}    id=key_value    #新建网络密钥界面值输入框
${netKey_create_key_error_ID}    id=key_value_error    #新建网络密钥界面值错误提示信息
${netKey_search_input_ID}    name=pageInfo.f_key_name    #网络密钥管理界面搜索输入框
${netKey_table_head}    //thead//td    #网络密钥管理界面table的head

#加密网关
${erygw_menu_ID}    //li[contains(@onclick,'936430')]    #左侧树中加密网关
${erygw_tab_ID}    //a[@href='#tab_936430']    #加密网关标签页
${erygw_manage_UI_ID}    id=tab_936430    #加密网关管理界面
${erygw_manage_iframe_ID}    id=acetab_ifr_tab_936430    #加密网关管理界面iframe
${erygw_start_button_ID}    //input[contains(@onclick,'startup_vtop')]    #加密网关管理界面开机按钮
${erygw_shutdown_button_ID}    //input[contains(@onclick,'shutdown_vtop')]    #加密网关管理界面关机按钮
${erygw_restart_button_ID}    //input[contains(@onclick,'restart_vtop')]    #加密网关管理界面重启按钮
${erygw_table_head}    //thead//td    # 加密网关界面table的head

#审计管理
${audit_menu_ID}    //li[contains(@onclick,'936393')]    #左侧树中审计管理
${audit_tab_ID}    //a[@href='#tab_936393']    #审计管理标签页
${audit_manage_UI_ID}    id=tab_936393    #审计管理界面
${audit_manage_iframe_ID}    id=acetab_ifr_tab_936393    #审计管理界面iframe
${audit_batchDel_button_ID}    //button[contains(@onclick,'deleteAudit')]    #审计管理界面批量删除
${audit_pass_button_ID}    //button[contains(@onclick,'passAudit')]    #审计管理界面通过按钮
${audit_refuse_button_ID}    //button[contains(@onclick,'refuseAudit')]    #审计管理界面驳回按钮
${audit_search_name_input_ID}    name=pageInfo.f_username    #审计管理界面搜索用户输入框
${audit_search_vm_input_ID}    name=pageInfo.f_srcvm_name    #审计管理界面搜索源虚拟机输入框
${audit_search_type_select_ID}    id=req_type    #审计管理界面搜索请求类型选择框
${audit_search_state_select_ID}    id=state    #审计管理界面搜索当前状态选择框

# 排序相关元素
${netKey_sort_name}    //a[contains(@href,'key_name')]    # 网络密钥管理界面--名称排序
${erygw_sort_name}    //a[contains(@href,'host_name')]    #加密网络界面--网关名称排序
${audit_sort_time}    //a[contains(@href,'req_timestamp')]    #审计管理界面--请求时间排序
${audit_sort_username}    //a[contains(@href,'username')]    #审计管理界面--用户排序
${audit_sort_host}    //a[contains(@href,'host_uuid')]    #审计管理界面--主机排序
${audit_sort_srcvm}    //a[contains(@href,'srcvm_name')]    #审计管理界面--源虚拟机排序
${audit_sort_dstvm}    //a[contains(@href,'dstvm_name')]    #审计管理界面--目的虚拟机排序
${audit_sort_type}    //a[contains(@href,'req_type')]    #审计管理界面--请求类型排序
${audit_sort_state}    //a[contains(@href,'state')]    #审计管理界面--审核状态排序
${audit_sort_result}    //a[contains(@href,'op_result')]    #审计管理界面--传输结果排序