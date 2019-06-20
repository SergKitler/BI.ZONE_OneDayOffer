*** Settings ***
Library         RequestsLibrary
Library         Collections
Variables       task5_default_variables.py

Suite Teardown  Delete All Sessions


*** Variables ***
${existing_username}                testuser1
${existing_username_upper_case}     TESTUSER1
${nonexistent_username}             tratata


*** Test Cases ***
# --==Action under users|Check User==--
# ---------------------------------------
Check Existing User
    ${data}=            Create Dictionary   username=${existing_username}     
    ${old_dict_of_users}=   Open Session And Get User List    ${username}     ${auth_token}   ${url}     200     
    Check User In DB    ${old_dict_of_users}    ${existing_username}
    Open Session And Check User    ${username}     ${auth_token}   ${url}     200     ${existing_username}

Check Existing User with upper case name
    ${data}=            Create Dictionary   username=${existing_username_upper_case}     
    ${old_dict_of_users}=   Open Session And Get User List    ${username}     ${auth_token}   ${url}     200     
    Check User Not In DB    ${old_dict_of_users}   ${existing_username_upper_case}
    Open Session And Check User    ${username}     ${auth_token}   ${url}     404     ${existing_username_upper_case}

Check Nonexistent User
    ${data}=            Create Dictionary   username=${nonexistent_username}     
    ${old_dict_of_users}=   Open Session And Get User List    ${username}     ${auth_token}   ${url}     200     
    Check User Not In DB    ${old_dict_of_users}   ${nonexistent_username}
    Open Session And Check User    ${username}     ${auth_token}   ${url}     404     ${nonexistent_username}
    
    
*** Keywords ***
Open Session And Get User List
    [Arguments]   ${auth username}    ${auth_token}    ${url}    ${expected_status}
    ${headers}=         Create Dictionary         X-Auth-Name=${auth username}    X-Auth-Token=${auth_token} 
    Create Session      alias=localhost     url=${url}      headers=${headers}
    ${resp}=            Get Request         localhost       ${page}    
    Should Be Equal As Strings   ${resp.status_code}     ${expected_status}
    [Return]    ${resp.json()}
    
Open Session And Check User
    [Arguments]   ${auth username}    ${auth_token}     ${url}   ${expected_status}      ${existing_username}
    ${headers}=         Create Dictionary         X-Auth-Name=${auth username}    X-Auth-Token=${auth_token} 
    Create Session      alias=localhost     url=${url}      headers=${headers}
    ${resp}=            Head Request         localhost       ${page}/${existing_username}
    Should Be Equal As Strings   ${resp.status_code}     ${expected_status}
    
Check User In DB    
    [Arguments]   ${username dictionary}    ${new_username}  
    ${server_dict_new}=     Get From Dictionary     ${username dictionary}   users
    Dictionary Should Contain Key    ${server_dict_new}    ${new_username}
    
Check User Not In DB    
    [Arguments]   ${username dictionary}    ${new_username}  
    ${server_dict_new}=     Get From Dictionary     ${username dictionary}   users
    Dictionary Should Not Contain Key    ${server_dict_new}    ${new_username}
