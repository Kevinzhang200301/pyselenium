*** Variables ***
${menu_ul_ID}     id=menulist    #左侧菜单栏
${short_button_ID}    id=sidebar-shortcuts-large    #快捷图标栏
${popup_box_text_ID}    //div[contains(@id,'jconfirm-box')]    # 弹窗信息
${confirm_div_ID}    //div[@class='jconfirm jconfirm-light']    #弹窗div
${popup_confirm_ID}    //button[contains(@class,'btn btn-success ')]    # 弹窗确定按钮
${popup_cancel_ID}    //button[contains(@class,'btn btn-default')]    #弹窗取消按钮
${popup_title_ID}    //span[contains(@class,'jconfirm-title')]    # 弹窗title
${lobibox_title_ID}    //div[@class='lobibox-notify-title']    # 操作后右下角弹窗title
${lobibox_msg_ID}    //div[@class='lobibox-notify-msg']    # 操作后右下角弹窗信息
${lobibox_body_ID}    //div[@class='lobibox-notify-body']    #lobibox的body
${lobibox_success}    //div[contains(@class,'lobibox-notify-success')]    #lobibox操作成功弹窗
${lobibox_info}    //div[contains(@class,'lobibox-notify-info')]    # lobibox友情提示弹窗
${loading_img_ID}    //div[contains(@class,'layui-layer-shade')]    #加载中界面
${loading_img2_ID}    //*[@id="layui-layer1"]/div    #加载中图片
# layUI
${layui_iframe_ID}    //iframe[contains(@id,'layui-layer-iframe')]    #lay界面iframe
${layui_save_button_ID}    //a[@class='layui-layer-btn0']    #lay界面保存按钮
${layui_cancel_button_ID}    //a[@class='layui-layer-btn1']    #lay界面取消按钮
${layui_x_button_ID}    //a[contains(@class,'layui-layer-close')]    #lay界面上“x”按钮
${layui_title_ID}    //div[@class='layui-layer-title']    #lay界面title
${layui_title2_ID}    //h1    #lay界面第二个title
${layui_label_ID}    //label    #lay界面label
${layui_group_select}    id=citySel    #layer界面上用户组选择框
# 公用元素ID
${public_table_ID}    css=#sample-table-2    #公用的table定位器
${public_manage_title_ID}    //strong    #公用的管理界面title
${public_selectall_ID}    name=chkall    #所有CheckBox
${public_firstTree_switch}    id=treeDemo_1_switch    # 树形中第一级选择
${public_table_head}    //th    # table中每栏标题
# 主页
${home_iframe_ID}    id=acetab_ifr_tab_home_0001    #主页iframe
${homepage_tab_ID}    //*[@id="tab_tab_home_0001"]    #我的主页
${home_user_ID}    id=user    #主页界面用户信息
${home_userSelect_ID}    id=userselect    #主页界面用户选择框
${home_colour_label}    //h4    #主页界面选择信息title
${home_select_lable}    //label    # 我的主页界面选择栏
# 翻页
${pagesize_select_ID}    //select[@name='pageSize']    #翻页中每页显示数量select
${pagesize_all_recordnumber_ID}    //select[@name='pageSize']/../../../li[3]/a    #翻页中显示条数
${pagesize_label_ID}    //select[@name='pageSize']/../../..    #翻页栏
${pagesize_first_button_ID}    link=首页    #翻页中首页按钮
${pagesize_last_button_ID}    link=尾页    #翻页中尾页按钮
${pagesize_prev_button_ID}    link=<<    #翻页中上一页按钮
${pagesize_next_button_ID}    link=>>    #翻页中下一页按钮
${pagesize_inputorder_ID}    id=pageOrder    #翻页中输入第几页输入框
${pagesize_jump_button_ID}    //a[contains(@onclick,'checkThenSubmit')]    #翻页中跳转按钮
${pagesize_select_number_ID}    //li[@class='active']    #选中的当前页码
# 搜索栏
${public_search_label_ID}    //span[@class='input-group-addon']    #公用搜索栏
${search_icon_ID}    id=ace-settings-btn    # 搜索图标
${search_button_ID}    id=searchBtn    # 搜索按钮
# 登录后界面其他信息比如授权，关于我们等
${main_logout_button}    id=loginOut    #退出登录按钮
${main_welcome_button}    //li[contains(@class,'light-orange')]    # “欢迎,XXX”按钮
${main_welcome_sublist}    ${main_welcome_button}/ul//a    #“欢迎,XXX”菜单下子功能
${main_welcome_info}    //span[@class='user-info']    # “欢迎,XXX”按钮信息
${main_power_button}    //li[contains(@class,'light-blue')]    #电源按钮
${main_power_sublist}    ${main_power_button}/ul//a    #电源按钮下子功能
${main_chgpwd_button}    //*[@id="editpass"]    # VC用户修改密码按钮
${main_menulist_ID}    //span[@class='menu-text']    # 左侧树中功能菜单栏
${main_menu_sublist}    //ul[@id='menulist']//li/ul//a    #左侧树中子功能菜单栏
${main_companyCN_ID}    //span[@class='blue footer-font-size']    # 中文公司名称
${main_companyEN_ID}    //span[@class='blue bolder']    # 英文公司名称
${main_authorization_ID}    //a[@onclick='authVC()']    # 授权文件
${main_aboutMe_ID}    //a[contains(@onclick,'aboutMe')]    # 关于我们
${main_auth_chooseFile_ID}    id=upload    #授权界面文件选择
${main_auth_file_error_ID}    id=other_error    # 授权界面文件错误
${main_auth_title_ID}    //h4    # 授权界面title
${main_auth_info_name}    //div[@class='profile-info-name']    #授权界面详细信息名称栏
${main_auth_info_value}    //div[@class='profile-info-value']    #授权界面详细信息值栏
${main_auth_company_value}    //div[contains(@class,'profile-user-info')]/div[3]/div[2]    #授权界面公司值
${main_auth_blue_label}    //h4    #授权界面蓝色栏
# 登录界面元素信息
${login_bth_ID}    id=butt    #登录按钮
${login_errMSG_ID}    id=errormessage    #登录失败信息
${login_title_ID}    //*[@id="login-box"]/div/div/div[2]/h1/img    #登录框Title
${login_name_ID}    id=j_username    #登录用户名填写框
${login_pwd_ID}    id=j_password    #登录密码填写框
${login_vtopimg_ID}    //img    #vtop图片
${login_company_link}    //*[@id='id-company-text']    #@红山世纪链接
# vTopCenter用户修改密码元素信息
${chgpwd_name_input}    //p/span    # 修改密码界面用户输入框
${chgpwd_oldpwd_input}    id=oldpassword    # 修改密码界面输入原密码框
${chgpwd_newpwd_input}    id=newpassword    # 修改密码界面输入新密码框
${chgpwd_confirmpwd_input}    id=newpassword2    # 修改密码界面确认输入新密码框
${chgpwd_oldpwd_error}    id=oldpasStr    #原密码错误信息
${chgpwd_newpwd_error}    id=newpasStr1    #新密码错误信息
${chgpwd_confirmpwd_error}    id=newpasStr    #确认密码错误信息
# 上传文件
${public_upFile_progress}    //div[@id='progress']/div    #上传文件界面进度条
${public_upFile_100%}    //div[@class='progress-bar progress-bar-success' and @style='width:100%;']/..    #上传文件界面进度条100%
${public_upFile_prompt}    id=other_error    #上传升级界面提示信息（标题旁边）
