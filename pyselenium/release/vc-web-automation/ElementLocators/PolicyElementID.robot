*** Variables ***
${policy_manage_button_ID}    //i[@class='menu-icon fa fa-code-fork']/..    #左侧树中策略管理

#用户策略
${uply_tab_ID}    id=tab_tab_936399    #用户策略标签页
${uply_manage_button_ID}    //li[contains(@onclick,'936399')]    #左侧树中用户策略
${uply_manage_iframe_ID}    id=acetab_ifr_tab_936399    #用户策略管理界面iframe
${uply_search_input_ID}    name=pageInfo.f_policy_name    #用户策略界面搜索输入框
${uply_add_button_ID}    //input[contains(@onclick,'addUserdata')]    #用户策略界面新建策略按钮
${uply_add_policyname_ID}    //*[@id='policy_name']    #新建用户策略界面策略名字输入框
${uply_add_select_ID}    id=pre-selected-options    #新建用户策略中策略select
${uply_add_mso_ID}    //div[@class='ms-selectable']/ul/li[@title='mso']    #多点同时登陆策略
${uply_add_name_error_ID}    id=policy_name_error    #新建用户策略界面名称错误信息
${uply_add_rule_error_ID}    //*[@id='resource_ids_error']    #新建用户策略界面用户规则错误提示信息
${uply_add_policy_info_ID}    //div[@class='ms-selectable']/ul    #新建用户策略界面策略信息
${uply_add_desc_input_ID}    //*[@id="description"]    #新建用户策略界面说明输入框
${uply_add_no_select_policy}    //li[@class='ms-elem-selectable']    #新建用户策略界面未选择的用户规则
${uply_add_selected_policy}    //li[@class='ms-elem-selection ms-selected']    # 新建用户策略界面已选择的用户规则
${uply_add_selectRule_label}    //div[@class='custom-header']    #新建用户策略界面规则选择栏信息
${uply_manage_table_rule}    id=resource_names    # 用户策略管理界面table中用户规则

#设备策略
${dply_menu_ID}    //li[contains(@onclick,'936401')]    #左侧设备策略菜单
${dply_manage_tab_ID}    //a[@href="#tab_936401"]    #设备策略管理界面标签
${dply_manage_UI_ID}    id=acetab_ifr_tab_936401    #设备策略管理界面
${dply_manage_iframe_ID}    id=acetab_ifr_tab_936401    #设备策略管理界面iframe
${dply_create_button_ID}    //input[contains(@onclick,'addPolicy')]    #设备策略管理界面新建策略按钮
${dply_search_input_ID}    //input[@name="pageInfo.f_policy_name"]    #设备管理界面搜索输入框
${dply_create_table_ID}    css=#JColResizer0    #新建设备策略中table
${dply_create_name_input_ID}    id=policy_name    #新建设备策略中策略名称输入框
${dply_create_select_ID}   id=policy_type    #新建设备策略中策略类型选择框
${dply_create_desc_ID}    id=description    #新建设备策略中说明输入框
${dply_create_name_error_ID}    id=policy_name_error    #新建设备策略中策略名称错误信息提示
${dply_create_device_error_ID}    id=resource_ids_error    #新建设备策略中设备选择错误信息提示
${dply_manage_device_ID}    id=resource_names    #设备策略管理上table中设备

# 排序元素
${policy_sort_name}    //a[contains(@href,'policy_name')]    # 策略管理界面排序--策略名称
${policy_sort_type}    //a[contains(@href,'policy_type')]    # 策略管理界面排序--策略类型
${policy_sort_number}    //a[contains(@href,'policy_number')]    # 策略管理界面排序--设备或者规则数量