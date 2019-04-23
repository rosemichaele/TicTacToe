*** Settings ***
Documentation   Tic Tac Toe is a game between two players (`X` and `O`) taking turns writing letters in table cells.
...             In this variant, players can choose the size of the starting board, and then click in the generated
...             boxes to input letters until the game is over.
Resource        Resource.robot
Test Setup      Go To Tic Tac Toe Site
Test Teardown   Close All Browsers
Force Tags      Gameplay

*** Variables ***
${CELL_CONTENT_ERROR}       Unexpected content found in row 1, column 1. Expected O, but found something else.

*** Test Cases ***
Play a Standard Game
    [Documentation]  Verify the standard game board is filled with the expected letters when cells are clicked.
    Start a New Game
    Enter X in Table Cell   row=1    column=1
    Enter O in Table Cell   row=1    column=2
    Enter X in Table Cell   row=1    column=3
    Enter O in Table Cell   row=2    column=1
    Enter X in Table Cell   row=2    column=2
    Enter O in Table Cell   row=2    column=3
    Enter X in Table Cell   row=3    column=1
    Enter O in Table Cell   row=3    column=2
    Enter X in Table Cell   row=3    column=3

Clicking Multiple Times In A Single Cell Should Have No Effect
    [Documentation]     Verify an already occupied table cell cannot be replaced by another letter.
    Start a New Game
    Enter X in Table Cell           row=1    column=1
    Run Keyword And Expect Error    ${CELL_CONTENT_ERROR}   Enter O in Table Cell   row=1    column=1