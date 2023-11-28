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
&{headers}      accept=*/*


*** Test Cases ***
As the Bookkeeper, I should be able to query the amount of tax relief for each person in the database so that I can report the figures to my Bookkeeping Manager
    Insert Test Record Of Working Class Hero

    ${resp}=    GET    ${SERVER}/calculator/taxRelief    headers=${headers}
    Status Should Be    OK    ${resp}
    ${response_json}=    Set Variable    ${resp.json()}

    FOR    ${record}    IN    @{response_json}
        Dictionary Should Contain Key    ${record}    natid
        Dictionary Should Contain Key    ${record}    name
        Dictionary Should Contain Key    ${record}    relief

        ${res_natid}=    Get From Dictionary    ${record}    natid
        ${res_tax_relief}=    Get From Dictionary    ${record}    relief

        Check If Nation Id Is Masked    ${res_natid}    ${5}
        ${tax_relief}=    Calculate Tax Relief    ${HERO_BIRTHDAY}    ${HERO_SALARY}    ${HERO_TAX}    ${HERO_GENDER}
        Should Be Equal As Numbers    ${tax_relief}    ${res_tax_relief}
    END


*** Keywords ***
Check If Nation Id Is Masked
    [Arguments]    ${res_natid}    ${from_index}
    ${character_index}=    Set Variable    ${0}
    ${list_of_nation_id}=    Split String To Characters    ${res_natid}

    FOR    ${character}    IN    @{list_of_nation_id}
        IF    $character_index >= ${from_index}
            Should Be Equal As Strings    ${character}    $
        END
        ${character_index}=    Set Variable    ${character_index+1}
    END
