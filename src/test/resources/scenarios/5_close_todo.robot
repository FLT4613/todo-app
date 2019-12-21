#4 ユーザとして、TODOの内容を編集することができること。
*** Settings ***
Library           SeleniumLibrary
Library           OperatingSystem
Test Setup        Run Keywords  Open Application Page  AND  Remove DataFile  AND  Create DataFile
Test Teardown     Run Keywords  Close Application Page
Suite teardown    Run Keywords  Close all browsers

*** Variables ***
${BROWSER}     HeadlessChrome
${HOST}        localhost:8080

*** Test Cases ***
Change the status "TODO" to "CLOSE"
    Given task with a status of "TODO" is registered            # ステータスが"TODO"のタスクが登録されている「とする」
    When there is a something to change the status   # 「もし」ステータスを変更するためのボタンかプルダウンがあり、
    And user change the status "TODO" to "CLOSE"              # 「かつ」ステータス"TODO"を"CLOSE"に変更した
    Then status updated to "CLOSE"                             # 「ならば」ステータスがCLOSEに更新される

*** Keywords ***
Task is already registered
    Input Text    id=title    HOGEHOGE
    Click Button  css=input[value=ADD]
    Wait Until Page Contains Element  css=body

Modify the task
    Input Text  css=tr:last-child > td:nth-child(2) > input  FUGAFUGA

Click the update button
    Click Button  css=tr:last-child > td:nth-child(4) > input

Contents of the task are updated
    Wait Until Page Contains Element  css=body
    ${n}=  Get Value    css= tr:last-child > td:nth-child(2) > input
    Should Be Equal  ${n}  FUGAFUGA

Open Application Page
    Open Browser    http://${HOST}/index.jsp    ${BROWSER}

Close Application Page
    Close Browser

Create DataFile
    Touch	./ToDo.csv

Remove DataFile
    Remove File		./ToDo.csv