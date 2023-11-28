*** Settings ***
Resource    ../../resources/browser.robot
Library     RequestsLibrary
Library     SeleniumLibrary


*** Variables ***
${natid}                                    123
${name}                                     test_name
${gender}                                   1
${birthday}                                 01011991
${salary}                                   2000
${tax}                                      500
${headers}                                  Create Dictionary    Content-Type=application/json

${UPLOAD_FILE_SELECTOR}                     css=input.custom-file-input[type='file']
${BTN_REFRESH_TAX_RELIEF_TABLE_SELECTOR}    css=#contents button.btn-primary[type='button']
${TABLE_RECORDS_SELECTOR}                   css=#contents table tbody tr
${BTN_WIPE_EVERYTHING}                      css=#contents button.btn-danger
${DataFile}                                 ${CURDIR}/sample.csv


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

As the Clerk, I should be able to upload a csv file to a portal so that I can populate the database from a UI
    Open Browser    ${SERVER}    ${BROWSER}
    Cleanup Database
    Click Refresh Tax Relief Button
    Upload file
    Click Refresh Tax Relief Button
    Check Relief Table Cell Exists by Value 001-$$$$$$$


*** Keywords ***
Upload file
    Wait Until Page Contains Element    ${UPLOAD_FILE_SELECTOR}    60s
    Scroll Element Into View    ${UPLOAD_FILE_SELECTOR}
    Choose File    ${UPLOAD_FILE_SELECTOR}    ${DataFile}

Click Refresh Tax Relief Button
    Wait Until Element Is Visible    ${BTN_REFRESH_TAX_RELIEF_TABLE_SELECTOR}
    Scroll Element Into View    ${BTN_REFRESH_TAX_RELIEF_TABLE_SELECTOR}
    Click Button    ${BTN_REFRESH_TAX_RELIEF_TABLE_SELECTOR}

Cleanup Database
    POST    ${SERVER}/calculator/rakeDatabase

Check Relief Table Cell Exists by Value ${VALUE}
    ${SELECTOR}=    Set Variable    //td[contains(text(),'${VALUE}')]
    Wait Until Element Is Visible    ${SELECTOR}
    Element Should Be Visible    ${SELECTOR}
