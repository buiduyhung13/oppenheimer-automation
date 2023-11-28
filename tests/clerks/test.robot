*** Settings ***
Resource        ../../resources/server.robot
Resource        ../../resources/keywords.robot
Resource        ../../resources/heroes.robot
Library         RequestsLibrary
Library         SeleniumLibrary

Test Setup      Cleanup Database


*** Variables ***
${UPLOAD_FILE_SELECTOR}                     css=input.custom-file-input[type='file']
${BTN_REFRESH_TAX_RELIEF_TABLE_SELECTOR}    css=#contents button.btn-primary[type='button']
${TABLE_RECORDS_SELECTOR}                   css=#contents table tbody tr
${BTN_WIPE_EVERYTHING}                      css=#contents button.btn-danger
${DataFile}                                 ${CURDIR}/sample.csv


*** Test Cases ***
As the Clerk, I should be able to insert a single record of working class hero into database via an API
    ${resp}=    Insert Record Of Working Class Hero
    ...    ${HERO_NATION_ID}
    ...    ${HERO_NAME}
    ...    ${HERO_GENDER}
    ...    ${HERO_BIRTHDAY}
    ...    ${HERO_SALARY}
    ...    ${HERO_TAX}
    Status Should Be    Accepted    ${resp}

As the Clerk, I should be able to insert more than one working class hero into database via an API
    ${body}=    Create Dictionary
    ...    natid=${HERO_NATION_ID}
    ...    name=${HERO_NAME}
    ...    gender=${HERO_GENDER}
    ...    birthday=${HERO_BIRTHDAY}
    ...    salary=${HERO_SALARY}
    ...    tax=${HERO_TAX}
    ${body_array}=    Create List    ${body}    ${body}
    ${resp}=    POST    ${SERVER}/calculator/insertMultiple    json=${body_array}
    Status Should Be    Accepted    ${resp}

As the Clerk, I should be able to upload a csv file to a portal so that I can populate the database from a UI
    Open Browser    ${SERVER}    ${BROWSER}
    Click Refresh Tax Relief Button
    Upload file
    Click Refresh Tax Relief Button
    Check Relief Table Cell Exists by Value 001-$$$$$$$
    Close Browser


*** Keywords ***
Upload file
    Wait Until Page Contains Element    ${UPLOAD_FILE_SELECTOR}    60s
    Scroll Element Into View    ${UPLOAD_FILE_SELECTOR}
    Choose File    ${UPLOAD_FILE_SELECTOR}    ${DataFile}

Click Refresh Tax Relief Button
    Wait Until Element Is Visible    ${BTN_REFRESH_TAX_RELIEF_TABLE_SELECTOR}
    Scroll Element Into View    ${BTN_REFRESH_TAX_RELIEF_TABLE_SELECTOR}
    Click Button    ${BTN_REFRESH_TAX_RELIEF_TABLE_SELECTOR}

Check Relief Table Cell Exists by Value ${VALUE}
    ${SELECTOR}=    Set Variable    //td[contains(text(),'${VALUE}')]
    Wait Until Element Is Visible    ${SELECTOR}
    Element Should Be Visible    ${SELECTOR}
