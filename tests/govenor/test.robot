*** Settings ***
Resource        ../../resources/server.robot
Resource        ../../resources/keywords.robot
Resource        ../../resources/heroes.robot
Library         RequestsLibrary
Library         SeleniumLibrary
Library         JSONLibrary
Library         Collections
Library         String

Test Setup      Cleanup Database


*** Variables ***
${BTN_DISPENSE_SELECTOR}    css=.btn-block.btn-danger[href='dispense']
${LB_CASH_DISPENSE}         css=body div.font-weight-bold


*** Test Cases ***
As the Governor, I should be able to see a button on the screen so that I can dispense tax relief for my working class heroes
    Open Browser    ${SERVER}    ${BROWSER}
    Wait Until Element Is Visible    ${BTN_DISPENSE_SELECTOR}
    Scroll Element Into View    ${BTN_DISPENSE_SELECTOR}
    Element Attribute Value Should Be    ${BTN_DISPENSE_SELECTOR}    class    btn btn-danger btn-block
    Element Text Should Be    ${BTN_DISPENSE_SELECTOR}    Dispense Now
    Click Element    ${BTN_DISPENSE_SELECTOR}

    Wait Until Element Is Visible    ${LB_CASH_DISPENSE}
    Scroll Element Into View    ${LB_CASH_DISPENSE}
    Element Text Should Be    ${LB_CASH_DISPENSE}    Cash dispensed
    Close Browser
