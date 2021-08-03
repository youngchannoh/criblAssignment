*** Settings ***
Library   DataDriver   file=./testData/testCases.csv  delimiter=';'  encoding=UTF-8
Library     ./utility.py

#delete existing events.log
Suite Setup     deleteTargetLogFiles
#Suite Teardown  teardown
Test Template  criblTestTemplate

#Test Setup   sleep  10
#delete existing events.log
Test Teardown   deleteTargetLogFiles

*** Variables ***
${fileOnTarget}              events.log
${fileDirOnTarget_1}         target_1
${fileDirOnTarget_2}         target_2

*** Test Cases ***

#This test name can be any name.
criblDataDriverTest
    [Tags]    include



*** Keywords ***

criblTestTemplate
    [Arguments]  ${fileBase}

    changeAgent_InputJson  ${fileBase}

    startNodeAgent

    ${passOrFail_1}  ${reason_1}  compare2LogFiles   ${fileBase}   ${fileOnTarget}  ${fileDirOnTarget_1}
    ${passOrFail_2}  ${reason_2}  compare2LogFiles   ${fileBase}   ${fileOnTarget}  ${fileDirOnTarget_2}

    checkResultForPassOrFail  ${fileDirOnTarget_1}  ${passOrFail_1}  ${reason_1}   ${fileDirOnTarget_2}  ${passOrFail_2}  ${reason_2}


checkResultForPassOrFail
    [Arguments]  ${fileDirOnTarget_1}  ${passOrFail_1}  ${reason_1}   ${fileDirOnTarget_2}  ${passOrFail_2}  ${reason_2}
    ${passOrFail}  ${reason}  fail_if_stringContains_FAIL_None   ${fileDirOnTarget_1}  ${passOrFail_1}  ${reason_1}   ${fileDirOnTarget_2}  ${passOrFail_2}  ${reason_2}
    run keyword unless  '${passOrFail}' == 'PASS'   fail   ${reason}