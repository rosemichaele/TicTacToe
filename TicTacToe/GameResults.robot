*** Settings ***
Documentation   The game is won when a player fills a full table row, column, or diagonal with their letter or no table
...             cells are left before this result is reached (a draw). Start a new game by refreshing the web page.
Resource        Resource.robot
Test Setup      Go To Tic Tac Toe Site
Test Teardown   Close All Browsers
Force Tags      Game Results

*** Variables ***
${GAME_OVER_ERROR}       Unexpected content found in row 3, column 3. Expected O, but found something else.

*** Test Cases ***
Win with X in a Row
    [Documentation]  If *X* fills a row, then player `X` should be declared the winner.
    Start a New Game    size=3
    Enter X in Table Cell       row=1    column=1
    Enter O in Table Cell       row=2    column=1
    Enter X in Table Cell       row=1    column=2
    Enter O in Table Cell       row=2    column=2
    Enter X in Table Cell       row=1    column=3
    Winner Should Be Declared   X

Win with X in a Column
    [Documentation]  If *X* fills a column, then player `X` should be declared the winner.
    Start a New Game    size=2
    Enter X in Table Cell       row=1    column=1
    Enter O in Table Cell       row=1    column=2
    Enter X in Table Cell       row=2    column=1
    Winner Should Be Declared   X

Win with O in a Diagonal
    [Documentation]  If *O* fills a diagonal, then player `O` should be declared the winner.
    Start a New Game    size=4
    Enter X in Table Cell       row=1    column=2
    Enter O in Table Cell       row=1    column=1
    Enter X in Table Cell       row=1    column=3
    Enter O in Table Cell       row=2    column=2
    Enter X in Table Cell       row=1    column=4
    Enter O in Table Cell       row=3    column=3
    Enter X in Table Cell       row=2    column=4
    Enter O in Table Cell       row=4    column=4
    Winner Should Be Declared   O

Game Should Be Drawn if No Winner
    [Documentation]  If a full row, column or diagonal does not contain a single letter, the game should be drawn.
    Start a New Game
    Fill The 3x3 Board So There Is No Winner
    Draw Should Be Declared

No Input Should Be Possible After Game Has Ended
    [Documentation]  After a winner or a draw is declared, no further gameplay should be allowed.
    Start a New Game
    Enter X in Table Cell       row=1    column=1
    Enter O in Table Cell       row=1    column=2
    Enter X in Table Cell       row=2    column=1
    Enter O in Table Cell       row=1    column=3
    Enter X in Table Cell       row=3    column=1
    Run Keyword And Expect Error    ${GAME_OVER_ERROR}  Enter O in Table Cell       row=3    column=3

*** Keywords ***
Fill The 3x3 Board So There Is No Winner
    [Documentation]  No rows, columns, or diagonals will be occupied by a a single letter.
    Enter X in Table Cell   row=1    column=1
    Enter O in Table Cell   row=1    column=2
    Enter X in Table Cell   row=1    column=3
    Enter O in Table Cell   row=2    column=2
    Enter X in Table Cell   row=2    column=1
    Enter O in Table Cell   row=2    column=3
    Enter X in Table Cell   row=3    column=2
    Enter O in Table Cell   row=3    column=1
    Enter X in Table Cell   row=3    column=3
