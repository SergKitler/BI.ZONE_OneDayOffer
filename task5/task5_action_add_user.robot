*** Settings ***
Library         RequestsLibrary
Library         Collections
Variables       task5_default_variables.py

Suite Teardown  Delete All Sessions


*** Variables ***
${new_username}         testuser1
${new_username_spec}    "/\[]:;|=,+*?<> 
${new_username_upper}   TESTUSER
${new_username_rus}     тестовый
${new_username_space}   \ \
${new_username_empty}   \

@{username_for_pass}   testuser21    testuser22   testuser23   testuser24
@{username_for_desc}   testuser31    testuser32   testuser33   testuser34
@{username_for_wrong_key}   testuser41    testuser42   testuser43 

${password}             testuser1
${password_spec}        "/\[]:;|=,+*?<> 
${password_rus}         пароль
${password_space}       \ \
${password_empty}       \

${description}          new description
${description_spec}      "/\[]:;|=,+*?<> 
${description_rus}      новое описание
${description_space}     \ \
${description_empty}     \


*** Test Cases ***
# --==Action under users|Add New User==--
# ---------------------------------------
# --==username==--
Action Add New User in lower case Status OK
    ${data}=            Create User Dictionary   ${new_username}   ${password}    ${description}
    ${old_dict_of_users}=   Open Session And Get User List    ${username}     ${auth_token}   ${url}     200     
    Check User Not In DB    ${old_dict_of_users}    ${new_username}
    ${new_dict_of_users}=   Open Session And Add User And Get Body    ${username}     ${auth_token}   ${url}     200     ${data}
    Check User In DB    ${new_dict_of_users}    ${new_username}
    
Action Add New User with special simbols in name
    ${data}=            Create User Dictionary   ${new_username_spec}   ${password}    ${description}
    ${old_dict_of_users}=   Open Session And Get User List    ${username}     ${auth_token}   ${url}     200     
    Check User Not In DB    ${old_dict_of_users}    ${new_username_spec}
    ${new_dict_of_users}=   Open Session And Add User And Get Body    ${username}     ${auth_token}   ${url}     200     ${data}
    Check User In DB        ${new_dict_of_users}    ${new_username_spec}
    
Action Add New User with upper case name
    ${data}=            Create User Dictionary   ${new_username_upper}   ${password}    ${description}
    ${old_dict_of_users}=   Open Session And Get User List    ${username}     ${auth_token}   ${url}     200     
    Check User Not In DB    ${old_dict_of_users}    ${new_username_upper}
    ${new_dict_of_users}=   Open Session And Add User And Get Body    ${username}     ${auth_token}   ${url}     200     ${data}
    Check User In DB        ${new_dict_of_users}    ${new_username_upper}

Action Add New User with rus name
    ${data}=            Create User Dictionary   ${new_username_rus}   ${password}    ${description}
    ${old_dict_of_users}=   Open Session And Get User List    ${username}     ${auth_token}   ${url}     200     
    Check User Not In DB    ${old_dict_of_users}    ${new_username_rus}
    ${new_dict_of_users}=   Open Session And Add User And Get Body    ${username}     ${auth_token}   ${url}     200     ${data}
    Check User In DB        ${new_dict_of_users}    ${new_username_rus}

Action Add New User with space name
    ${data}=            Create User Dictionary   ${new_username_space}   ${password}    ${description}
    ${old_dict_of_users}=   Open Session And Get User List    ${username}     ${auth_token}   ${url}     200     
    Check User Not In DB    ${old_dict_of_users}    ${new_username_space}
    ${new_dict_of_users}=   Open Session And Add User And Get Body    ${username}     ${auth_token}   ${url}     200     ${data}
    Check User In DB        ${new_dict_of_users}    ${new_username_space}

Action Add New User with empty name
    ${data}=            Create User Dictionary   ${new_username_empty}   ${password}    ${description}
    ${old_dict_of_users}=   Open Session And Get User List    ${username}     ${auth_token}   ${url}     200     
    Check User Not In DB    ${old_dict_of_users}    ${new_username_empty}
    ${new_dict_of_users}=   Open Session And Add User And Get Body    ${username}     ${auth_token}   ${url}     400     ${data}
    Check User Not In DB    ${new_dict_of_users}    ${new_username_empty}

# --==password==--
Action Add New User with password_spec
    ${data}=            Create User Dictionary   @{username_for_pass}[0]   ${password_spec}    ${description}
    ${old_dict_of_users}=   Open Session And Get User List    ${username}     ${auth_token}   ${url}     200     
    Check User Not In DB    ${old_dict_of_users}    @{username_for_pass}[0] 
    ${new_dict_of_users}=   Open Session And Add User And Get Body    ${username}     ${auth_token}   ${url}     200     ${data}
    Check User In DB    ${new_dict_of_users}    @{username_for_pass}[0] 
    
Action Add New User with password_rus
    ${data}=            Create User Dictionary   @{username_for_pass}[1]   ${password_rus}    ${description}
    ${old_dict_of_users}=   Open Session And Get User List    ${username}     ${auth_token}   ${url}     200     
    Check User Not In DB    ${old_dict_of_users}    @{username_for_pass}[1] 
    ${new_dict_of_users}=   Open Session And Add User And Get Body    ${username}     ${auth_token}   ${url}     200     ${data}
    Check User In DB    ${new_dict_of_users}    @{username_for_pass}[1] 

Action Add New User with password_space
    ${data}=            Create User Dictionary   @{username_for_pass}[2]   ${password_space}    ${description}
    ${old_dict_of_users}=   Open Session And Get User List    ${username}     ${auth_token}   ${url}     200     
    Check User Not In DB    ${old_dict_of_users}    @{username_for_pass}[2] 
    ${new_dict_of_users}=   Open Session And Add User And Get Body    ${username}     ${auth_token}   ${url}     200     ${data}
    Check User In DB    ${new_dict_of_users}    @{username_for_pass}[2] 
    
Action Add New User with password_empty
    ${data}=            Create User Dictionary   @{username_for_pass}[3]   ${password_empty}    ${description}
    ${old_dict_of_users}=   Open Session And Get User List    ${username}     ${auth_token}   ${url}     200     
    Check User Not In DB    ${old_dict_of_users}    @{username_for_pass}[3] 
    ${new_dict_of_users}=   Open Session And Add User And Get Body    ${username}     ${auth_token}   ${url}     200     ${data}
    Check User In DB    ${new_dict_of_users}    @{username_for_pass}[3] 

# --==description==--
Action Add New User with description_spec
    ${data}=            Create User Dictionary   @{username_for_desc}[0]   ${password}    ${description_spec}
    ${old_dict_of_users}=   Open Session And Get User List    ${username}     ${auth_token}   ${url}     200     
    Check User Not In DB    ${old_dict_of_users}    @{username_for_desc}[0] 
    ${new_dict_of_users}=   Open Session And Add User And Get Body    ${username}     ${auth_token}   ${url}     200     ${data}
    Check User In DB    ${new_dict_of_users}    @{username_for_desc}[0] 
    
Action Add New User with description_rus
    ${data}=            Create User Dictionary   @{username_for_desc}[1]   ${password}    ${description_rus}
    ${old_dict_of_users}=   Open Session And Get User List    ${username}     ${auth_token}   ${url}     200     
    Check User Not In DB    ${old_dict_of_users}    @{username_for_desc}[1] 
    ${new_dict_of_users}=   Open Session And Add User And Get Body    ${username}     ${auth_token}   ${url}     200     ${data}
    Check User In DB    ${new_dict_of_users}    @{username_for_desc}[1] 

Action Add New User with description_space
    ${data}=            Create User Dictionary   @{username_for_desc}[2]   ${password}    ${description_space}
    ${old_dict_of_users}=   Open Session And Get User List    ${username}     ${auth_token}   ${url}     200     
    Check User Not In DB    ${old_dict_of_users}    @{username_for_desc}[2] 
    ${new_dict_of_users}=   Open Session And Add User And Get Body    ${username}     ${auth_token}   ${url}     200     ${data}
    Check User In DB    ${new_dict_of_users}    @{username_for_desc}[2] 
    
Action Add New User with description_empty
    ${data}=            Create User Dictionary   @{username_for_desc}[3]   ${password}    ${description_empty}
    ${old_dict_of_users}=   Open Session And Get User List    ${username}     ${auth_token}   ${url}     200     
    Check User Not In DB    ${old_dict_of_users}    @{username_for_desc}[3] 
    ${new_dict_of_users}=   Open Session And Add User And Get Body    ${username}     ${auth_token}   ${url}     200     ${data}
    Check User In DB    ${new_dict_of_users}    @{username_for_desc}[3] 
    
# --==with wrong key in body==--
Action Add New User with wrong key username2
    ${data}=            Create Dictionary   username2=@{username_for_wrong_key}[0]   password=${password}    description=${description}
    ${headers}=         Create Dictionary   X-Auth-Name=${username}    X-Auth-Token=${auth_token} 
    Create Session      alias=localhost     url=${url}      headers=${headers}
    ${resp}=            Post Request        localhost       ${page}      json=${data}
    Should Be Equal As Strings   ${resp.status_code}     400

Action Add New User with wrong key password2
    ${data}=            Create Dictionary   username=@{username_for_wrong_key}[1]   password2=${password}    description=${description}
    ${headers}=         Create Dictionary   X-Auth-Name=${username}    X-Auth-Token=${auth_token} 
    Create Session      alias=localhost     url=${url}      headers=${headers}
    ${resp}=            Post Request        localhost       ${page}      json=${data}
    Should Be Equal As Strings   ${resp.status_code}     400

Action Add New User with wrong key description2
    ${data}=            Create Dictionary   username=@{username_for_wrong_key}[2]   password=${password}    description2=${description}
    ${headers}=         Create Dictionary   X-Auth-Name=${username}    X-Auth-Token=${auth_token} 
    Create Session      alias=localhost     url=${url}      headers=${headers}
    ${resp}=            Post Request        localhost       ${page}      json=${data}
    Should Be Equal As Strings   ${resp.status_code}     400

Action Add New User with empty body
    ${headers}=         Create Dictionary   X-Auth-Name=${username}    X-Auth-Token=${auth_token} 
    Create Session      alias=localhost     url=${url}      headers=${headers}
    ${resp}=            Post Request        localhost       ${page}      
    Should Be Equal As Strings   ${resp.status_code}     400
    
    
*** Keywords ***
Create User Dictionary 
    [Arguments]   ${username}    ${password}     ${description}
    ${dictionary}=      Create Dictionary   username=${username}   password=${password}    description=${description}
    [Return]    ${dictionary}

Open Session And Get User List
    [Arguments]   ${auth username}    ${auth_token}    ${url}    ${expected_status}
    ${headers}=         Create Dictionary         X-Auth-Name=${auth username}    X-Auth-Token=${auth_token} 
    Create Session      alias=localhost     url=${url}      headers=${headers}
    ${resp}=            Get Request         localhost       ${page}    
    Should Be Equal As Strings   ${resp.status_code}     ${expected_status}
    [Return]    ${resp.json()}
    
Open Session And Add User And Get Body
    [Arguments]   ${auth username}    ${auth_token}     ${url}   ${expected_status}      ${data}
    ${headers}=         Create Dictionary         X-Auth-Name=${auth username}    X-Auth-Token=${auth_token} 
    Create Session      alias=localhost     url=${url}      headers=${headers}
    ${resp}=            Post Request         localhost       ${page}      json=${data}
    Should Be Equal As Strings   ${resp.status_code}     ${expected_status}
    ${resp2}=           Get Request          localhost       ${page}  
    [Return]    ${resp2.json()}
    
Check User In DB    
    [Arguments]   ${username dictionary}    ${new_username}  
    ${server_dict_new}=     Get From Dictionary     ${username dictionary}   users
    Dictionary Should Contain Key    ${server_dict_new}    ${new_username}
    
Check User Not In DB    
    [Arguments]   ${username dictionary}    ${new_username}  
    ${server_dict_new}=     Get From Dictionary     ${username dictionary}   users
    Dictionary Should Not Contain Key    ${server_dict_new}    ${new_username}