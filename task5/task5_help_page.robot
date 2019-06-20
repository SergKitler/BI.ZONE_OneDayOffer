*** Settings ***
Library         RequestsLibrary
Library         Collections
Variables       task5_default_variables.py

Suite Teardown  Delete All Sessions


*** Variables ***
${username_2}           AdmiN
${wrong_username}       Admin22


*** Test Cases ***
# --==Checking to getting help page
# -----------------------------------------------------
GET 200     # with set headers by GET method
    Help Page       ${username}     ${auth_token}         200
    
GET with AdmiN    # with set headers by GET method
    Help Page       ${username_2}     ${auth_token}       403
    
GET with only username      # with set only one X-Auth-Name header by GET method
    Help Page       ${username}     NULL       403
    
GET with only auth token    # with set only one X-Auth-Token header by GET method
    Help Page       NULL    ${auth_token}      403
    
GET without headers     # without headers by GET method
    Help Page       NULL    NULL       403

HGET with wrong username     # with wrong X-Auth-Name header by GET method
    Help Page       ${wrong_username}     ${auth_token}     403

POST        # with set headers by POST method
    ${headers}=         Create Dictionary         X-Auth-Name=${username}    X-Auth-Token=${auth_token} 
    Create Session      alias=localhost     url=${url}      headers=${headers}
    ${resp}=            Post Request         localhost       /    
    Should Be Equal As Strings   ${resp.status_code}        405
    

*** Keywords ***
Help Page
    [Arguments]   ${auth username}    ${auth_token}     ${expected_status}
    ${headers}=         Create Dictionary         X-Auth-Name=${auth username}    X-Auth-Token=${auth_token} 
    Create Session      alias=localhost     url=${url}      headers=${headers}
    ${resp}=            Get Request         localhost       /    
    Should Be Equal As Strings   ${resp.status_code}     ${expected_status}