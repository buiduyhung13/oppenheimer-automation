*** Settings ***
Documentation       A resource file with reusable keywords and variables.

Resource            server.robot
Resource            heroes.robot
Library             RequestsLibrary
Library             Collections


*** Variables ***
&{headers}      Content-Type=application/json


*** Keywords ***
Insert Record Of Working Class Hero
    [Arguments]    ${natid}    ${name}    ${gender}    ${birthday}    ${salary}    ${tax}
    ${body}=    Create Dictionary
    ...    natid=${natid}
    ...    name=${name}
    ...    gender=${gender}
    ...    birthday=${birthday}
    ...    salary=${salary}
    ...    tax=${tax}
    ${resp}=    POST    ${SERVER}/calculator/insert    json=${body}
    RETURN    ${resp}

Insert Test Record Of Working Class Hero
    Insert Record Of Working Class Hero
    ...    ${HERO_NATION_ID}
    ...    ${HERO_NAME}
    ...    ${HERO_GENDER}
    ...    ${HERO_BIRTHDAY}
    ...    ${HERO_SALARY}
    ...    ${HERO_TAX}

Cleanup Database
    POST    ${SERVER}/calculator/rakeDatabase
