*** Settings ***
Documentation       Hero data which use in all test cases

Library             DateTime
Library             ../library/Library.py


*** Variables ***
${HERO_NATION_ID}       001-0000000
${HERO_NAME}            IronMan
${HERO_GENDER}          ${1}
${HERO_BIRTHDAY}        01011991
${HERO_SALARY}          ${2000}
${HERO_TAX}             ${500}
