*** Settings ***
Library         RequestsLibrary
Library         Collections
Variables       task5_default_variables.py

Suite Teardown  Delete All Sessions


*** Test Cases ***
# --==Action under users|User List==--
# ------------------------------------
Action Get Users list   
    ${headers}=         Create Dictionary   X-Auth-Name=${username}    X-Auth-Token=${auth_token} 
    Create Session      alias=localhost     url=${url}      headers=${headers}
    ${resp}=            Get Request         localhost       ${page}    
    Should Be Equal As Strings      ${resp.status_code}     200    
    Dictionary Should Contain Key   ${resp.json()}          users
    