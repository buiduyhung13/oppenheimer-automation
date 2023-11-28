*** Settings ***
Resource    ../../resources/browser.robot
Library     RequestsLibrary


*** Variables ***
${natid}        123
${name}         test_name
${gender}       1
${birthday}     01011991
${salary}       2000
${tax}          500
${headers}      Create Dictionary    Content-Type=application/json


*** Test Cases ***
As the Clerk, I should be able to insert a single record of working class hero into database via an API
    ${body}=    Create Dictionary
    ...    natid=${natid}
    ...    name=${name}
    ...    gender=${gender}
    ...    birthday=${birthday}
    ...    salary=${salary}
    ...    tax=${tax}
    ${resp}=    POST    ${SERVER}/calculator/insert    json=${body}
    Status Should Be    Accepted    ${resp}

As the Clerk, I should be able to insert more than one working class hero into database via an API
    ${body}=    Create Dictionary
    ...    natid=${natid}
    ...    name=${name}
    ...    gender=${gender}
    ...    birthday=${birthday}
    ...    salary=${salary}
    ...    tax=${tax}
    ${body_array}=    Create List    ${body}    ${body}
    ${resp}=    POST    ${SERVER}/calculator/insertMultiple    json=${body_array}
    Status Should Be    Accepted    ${resp}
