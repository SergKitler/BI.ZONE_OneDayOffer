*** Settings ***
Library         RequestsLibrary
Library         Collections
Variables       task5_default_variables.py

Suite Teardown  Delete All Sessions


*** Variables ***
${existing_username}            testuser1
${nonexistent_username}         tratata
# ${old_password}               111
${new_password}                 222
${old_auth_token}               bcad50cbdc22a0ee11f27487dab841b709f1dd22b580523912b329ed3c9daf49
${new_auth_token}               8d0242177c68c4019eab432c244dc0a8fac6c941fb96b6709149574e53fa31b7


*** Test Cases ***
# --==Action under users|Modify User==--
# ---------------------------------------
Modify Password Existing User 
    Open Session And Check Status   ${existing_username}    ${old_auth_token}    ${url}  200
    ${data}=    Create Dictionary   username=${existing_username}   password=${new_password} 
    ${resp}=    Patch Request         localhost     ${page}      json=${data}
    Should Be Equal As Strings   ${resp.status_code}        200
    Open Session And Check Status   ${existing_username}    ${new_auth_token}    ${url}  200

Modify Nonexistent User 
    Open Session And Check Status   ${username}    ${auth_token}    ${url}  200
    ${data}=    Create Dictionary   username=${nonexistent_username}   password=${new_password} 
    ${resp}=    Patch Request         localhost     ${page}      json=${data}
    Should Be Equal As Strings   ${resp.status_code}        404
    
    
*** Keywords ***
Open Session And Check Status
    [Arguments]   ${auth username}    ${auth_token}    ${url}    ${expected_status}
    ${headers}=         Create Dictionary         X-Auth-Name=${auth username}    X-Auth-Token=${auth_token} 
    Create Session      alias=localhost     url=${url}      headers=${headers}
    ${resp}=            Get Request         localhost       ${page}    