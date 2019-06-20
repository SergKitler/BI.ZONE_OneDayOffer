*** Settings ***
Library         RequestsLibrary
Library         Collections
Variables       task5_default_variables.py

Suite Teardown  Delete All Sessions


*** Variables ***
${existing_username_for_del}            testuser1
${nonexistent_username_for_del}         tratata


*** Test Cases ***
# --==Action under users|Delete User==--
# ---------------------------------------
Delete Existing User
    ${data}=            Create Dictionary   username=${existing_username_for_del}     
    ${old_dict_of_users}=   Open Session And Get User List    ${username}     ${auth_token}   ${url}     200     
    Check User In DB    ${old_dict_of_users}    ${existing_username_for_del}
    ${new_dict_of_users}=   Open Session And Del User    ${username}     ${auth_token}   ${url}     200     ${existing_username_for_del}
    Check User Not In DB    ${new_dict_of_users}    ${existing_username_for_del}
    
Delete Nonexistent User
    ${data}=            Create Dictionary   username=${nonexistent_username_for_del}     
    ${old_dict_of_users}=   Open Session And Get User List    ${username}     ${auth_token}   ${url}     200     
    Check User Not In DB    ${old_dict_of_users}    ${nonexistent_username_for_del}
    ${new_dict_of_users}=   Open Session And Del User    ${username}     ${auth_token}   ${url}     200     ${nonexistent_username_for_del}
    Dictionaries Should Be Equal    ${old_dict_of_users}   ${new_dict_of_users}
    
Delete User admin
    ${headers}=         Create Dictionary         X-Auth-Name=${username}    X-Auth-Token=${auth_token} 
    Create Session      alias=localhost     url=${url}      headers=${headers}
    ${resp}=            Delete Request         localhost       ${page}/${username}
    Should Be Equal As Strings   ${resp.status_code}     400
    
    
*** Keywords ***
Open Session And Get User List
    [Arguments]   ${auth username}    ${auth_token}    ${url}    ${expected_status}
    ${headers}=         Create Dictionary         X-Auth-Name=${auth username}    X-Auth-Token=${auth_token} 
    Create Session      alias=localhost     url=${url}      headers=${headers}
    ${resp}=            Get Request         localhost       ${page}    
    Should Be Equal As Strings   ${resp.status_code}     ${expected_status}
    [Return]    ${resp.json()}
    
Open Session And Del User
    [Arguments]   ${auth username}    ${auth_token}     ${url}   ${expected_status}      ${username_for_del}
    ${headers}=         Create Dictionary         X-Auth-Name=${auth username}    X-Auth-Token=${auth_token} 
    Create Session      alias=localhost     url=${url}      headers=${headers}
    ${resp}=            Delete Request         localhost       ${page}/${username_for_del}
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