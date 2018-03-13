*** Settings ***
Suite Setup       prepare env for test
Metadata          Execute At    %{COMPUTERNAME}
Metadata          Test User    %{USERNAME}
Metadata          Operating System    %{OS}
Metadata          Processor    %{PROCESSOR_LEVEL}
Metadata          Test Framework    Robot Framework Python
Library           SSHLibrary
Library           String
Variables         ../TestData/PublicData.py

*** Keywords ***
prepare env for test
    Open Connection    ${vc_ip}    port=${vc_ssh_port}
    Login    ${vc_ssh_user}    ${vc_ssh_pwd}
    Write    su
    Read Until    Password:
    Write    ${vc_root_pwd}
    Read Until    [root@localhost rescue-user]#
    Write    cat /data/build_tag
    ${vc_version}    Read    delay=2
    ${vc_version}    Split String    ${vc_version}    ${\n}
    ${vc_version}    Set Variable    ${vc_version[0]}
    Set Global Variable    ${vc_version}
    Write    ${open_mysql_port_cmd}
    Set Client Configuration    prompt=#
    ${output}    Read Until Prompt
    ${status}    Run Keyword And Return Status    Should Contain    ${output}    success
    Run Keyword If    '${status}'=='False'    Should Contain    ${output}    Warning: ALREADY_ENABLED
    Write    mysql
    Read Until Regexp    .*MariaDB.*
    Write    GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '${vc_mysql_pwd}' WITH GRANT OPTION;
    Read Until Regexp    .*Query OK, 0 rows affected*.
    Write    FLUSH PRIVILEGES;
    Read Until Regexp    .*Query OK, 0 rows affected*.
    Close Connection
