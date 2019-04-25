*** Settings ***
Documentation   Start a Tic Tac Toe game by entering a number in the input box, then click `Play`.
Resource        Resource.robot
Test Setup      Go To Tic Tac Toe Site
Test Teardown   Close All Browsers
Force Tags      New Game

*** Test Cases ***
Start a New Standard Game
    [Documentation]  Input '3' then click *Play* to generate a standard 3x3 Tic Tac Toe board to play on. All cells
    ...              should be empty to begin with.
    Start a New Game
    Game Board Should Be Displayed  3x3
    Game Board Should Be Empty

Start a New Non-Standard Game
    [Documentation]  Input '6' then click *Play* to generate a non-standard 6x6 Tic Tac Toe board to play on. All cells
    ...              should be empty to begin with.
    Start a New Game        size=6
    Game Board Should Be Displayed  6x6
    Game Board Should Be Empty

Clicking Play Multiple Times Should Not Affect The Board
    [Documentation]  Once a new game is started in the session, clicking the *Play* button should not affect the board.
    Start A New Game
    Click Button        Play
    Game Board Should Be Displayed  3x3
    Game Board Should Be Empty

No Board Should Be Displayed By Default
    [Documentation]  Upon first arriving at the Tic Tac Toe site or refreshing page, the game board should not be displayed.
    Game Board Should Be Displayed  0x0

No Board Should Be Displayed When Non-Numeric Input
    [Documentation]  Invalid input to start the game should have no effect.
    Start a New Game                size=invalid
    Game Board Should Be Displayed  0x0
