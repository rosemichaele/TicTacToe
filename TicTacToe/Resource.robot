*** Settings ***
Documentation  Global resource for testing Tic Tac Toe.
Variables      variables.py
Library        TicTacToeSeleniumLibrary.py  WITH NAME   TicTacToe

*** Variables ***
${DRAW_MSG}     Nobody won! On the bright side, nobody lost either. Refresh to play again!

*** Keywords ***
Go To Tic Tac Toe Site
    [Documentation]  Open a browser and navigate to https://codepen.io/jshlfts32/full/bjambP/ to play Tic Tac Toe!
    Open Browser    ${GAME_URL}     browser=${BROWSER}
    # Set Selenium Speed  0.15 seconds
    # Set Window Size     1440    800
    # Set Window Position     2   2
    Select Frame    ${PAGE_FRAME}

Winner Should Be Declared
    [Documentation]     Verify that the correct winner is declared after a game is over.
    [Arguments]  ${expected_winner}
    Wait Until Element Is Visible   ${GAME_RESULT}  error=No result was declared.
    Wait Until Element Contains     ${GAME_RESULT}  Congratulations player ${expected_winner}! You've won. Refresh to play again!

Draw Should Be Declared
    [Documentation]     Verify that a draw is declared after a game is over.
    Wait Until Element Is Visible   ${GAME_RESULT}  error=No result was declared.
    Wait Until Element Contains     ${GAME_RESULT}  ${DRAW_MSG}
