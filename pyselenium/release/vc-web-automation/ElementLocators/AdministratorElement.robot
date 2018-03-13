*** Variables ***
${authority_menu_ID}    //i[contains(@class,'fa-unlock')]/..    # 左侧权限管理栏

# 管理员管理界面元素
${admin_manage_menu_ID}    //li[contains(@onclick,'21,')]    # 左侧管理员栏
${admin_manage_tab_ID}    //li[@id='tab_tab_21']    # 管理员管理界面标签
${admin_manage_UI}    id=tab_21    # 管理员界面
${admin_manage_iframe_ID}    id=acetab_ifr_tab_21    #管理员管理界面iframe
${admin_create_button_ID}    //input[contains(@onclick,'obj_add')]    #管理员界面新建按钮
${admin_reset_password_button_ID}    //input[contains(@onclick,'edit_user')]    #管理员管理界面重置密码
${admin_set_position_button_ID}    //input[contains(@onclick,'setPos')]    #管理员管理界面设置管理范围
${admin_search_input_ID}    id=searchName    #搜索输入框
${admin_table_admin_td}    //*[@id='tr_42']/td    # 管理员管理界面table中admin

# 新建或者编辑管理员界面元素
${admin_create_widget_title}    //h4    #新建管理员界面信息栏(基本信息,角色权限等)
${admin_create_nameinput_ID}    //*[@id='name']    #新建管理员界面管理员账户输入框
${admin_create_realname_input_ID}    //input[@id='realname']    #新建管理员界面真实姓名输入框
${admin_create_status_radio_name}    user.status    #新建管理员界面状态radio的name属性值
${admin_create_date_input_ID}    //input[@id='accountoverdate']    #新建管理员界面有效期输入栏
${admin_create_date_warn}    //input[@id='accountoverdate']/..    #新建管理员界面有效期提示信息
${admin_create_role_label}    //span[@class='lbl custom-input-middle']    # 新建管理员界面具体角色栏
${admin_create_role_radio_name}    roleIds    #新建管理员界面角色radio的name属性值
${admin_create_range_value}    //*[@id='citySel']    # 新建管理员界面选择管理范围值
${admin_craete_cellphone_input_ID}    id=cellphone    #新建管理员界面手机号码输入框
${admin_create_cellphone_error_ID}    id=cellphonespan    #新建管理员界面手机错误提示信息
${admin_create_officePhone_input_ID}    id=officePhone    #新建管理员界面办公电话输入框
${admin_create_officePhone_error_ID}    id=officePhonespan    #新建管理员界面办公室电话错误信息
${admin_create_mail_input_ID}    id=mail    #新建管理员界面个人邮箱输入框
${admin_create_mail_error_ID}    id=mailspan    #新建管理员界面个人邮箱错误信息
${admin_create_qq_input_ID}    name=user.qqNumber    #新建管理员界面QQ号码输入框
${admin_create_address_input_ID}    name=user.address    #新建管理员界面通讯地址输入框
${admin_create_name_error_ID}    id=appendStr    #管理员账户错误提示信息
${admin_create_realname_error_ID}    id=realnamespan    #管理员真实姓名错误提示信息
${admin_create_role_error_ID}    id=roleErrorSpan    #管理员权限错误提示信息

# 管理员界面排序
${admin_sort_username}    id=title_name    # 管理员管理界面排序用户名
${admin_sort_realname}    id=title_realname    # 管理员管理界面排序真实姓名
${admin_sort_rolename}    id=title_roleNames    # 管理员管理界面排序用户角色
${admin_sort_range}    id=orgName    # 管理员管理界面排序管理范围
${admin_sort_date}    id=title_accountoverdate    # 管理员管理界面排序有效期
${admin_sort_status}    id=title_status    # 管理员管理界面排序用户状态