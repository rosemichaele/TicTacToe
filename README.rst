Calendly Tic Tac Toe Test Suite
===============================
Thank you for the opportunity to demonstrate my skills in and passion for software testing, and for the chance to work
at a great, Atlanta-based technology company in Calendly! This document provides a description of the automated end-to-
end test suite that I created for the `Tic Tac Toe game <https://codepen.io/jshlfts32/full/bjambP/>`_ described in the
assignment. Below, you will also find a write-up of my feedback from testing the game and recommendations for improving
the overall quality. Finally, please visit `YouTube <http://www.example.com/>`_ for a screencast of the tests in action.

Automated tests
---------------
I have extensive experience using the keyword-driven acceptance testing tool `Robot Framework <https://robotframework.org>`_.
Robot Framework is an extremely powerful utility and it supports software development using the proven methodologies of
Specification by Example, or SbE. Test suites are written in **.robot** files, and each test suite contains several
sections that define and document the test cases within it.

Test cases are made up of **keywords**, with commonly used keywords built-in_ to the framework and many third-party
libraries, or collections of keywords, available as free and open-source software. Included in this category is
`SeleniumLibrary <http://robotframework.org/SeleniumLibrary/SeleniumLibrary.html>`_, which I have extended in this
project for creating clearly defined test scenarios for the web-based Tic Tac Toe game. I started by writing
documentation for each test and test suite in the TicTacToe_ folder.  Once I understood what should be tested, I wrote
code to automate the test steps using my extension of SeleniumLibrary, TicTacToeSeleniumLibrary_. In addition to code,
I wrote keywords directly in the Resource.robot_ file to illustrate another property of Robot Framework: the
ability to build new keywords made up of existing ones directly in the supported plain text format.

.. _built-in: http://robotframework.org/robotframework/#standard-libraries
.. _TicTacToe: TicTacToe/
.. _TicTacToeSeleniumLibrary: TicTacToe/TicTacToeSeleniumLibrary.py
.. _Resource.robot: TicTacToe/Resource.robot

You can learn about these keywords and how to use them by checking out the docs_ folder, which contains HTML files
generated using the Libdoc_ tool.

.. _docs: docs/
.. _Libdoc: http://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#libdoc

There are several options for running these tests with Robot Framework. I will discuss only a few. Before you begin,
the following software requirements must be met on the machine running the tests:

    1. Python 3.3 or late must be installed.
    2. The Python package manager pip must be installed (usually included with the standard installation).
    3. A WebDriver that meets W3C specifications and that is supported by Selenium must be installed and on the system
       PATH. The matching browser's name should be defined in the variables_ file if Safari is not chosen.

.. _variables: TicTacToe/variables.py

After the above prerequisites have been installed. Clone or copy this project to a directory on your computer, then run
the following command in the project's root directory::

    > pip install requirements.txt

That's all - now you are ready to run the tests. Run all of the tests in the TicTacToe directory (12 total) and write
output files to any desired directory::

    > robot --outputdir output/ TicTacToe/

Run a single test suite in one of the following ways::

    > robot --outputdir output/ TicTacToe/NewGame.robot
    > robot --outputdir output/ --suite "New Game" TicTacToe/

Run one or more individual tests::

    > robot --outputdir output/ --test "Game Should Be Drawn if No Winner" --test "Win with X in a Row" TicTacToe/GameResults.robot

Open the created **report.html** file for a detailed report of the test results.  I have included a sample of the results
in the output_ folder for convenience.  You can see that SeleniumLibrary automatically captures screenshots when web
tests fail.

.. _output: output/

Feedback from testing
---------------------
The following table breaks down each issue identified during testing . Review each row to understand how to reproduce
the issue and my recommendation to improve or correct it.

+----------------------------------+--------------------------------------------+----------------------------------+
| Issue                            | Steps to reproduce                         | Recommendations                  |
+==================================+============================================+==================================+
| Incorrect winner declared        | 1. Win the game with either letter.        | - Declare the correct winner     |
|                                  | 2. The opposite letter is declared winner. |                                  |
|                                  |                                            |                                  |
+----------------------------------+--------------------------------------------+----------------------------------+
| Draws are not declared           | 1. Play a game to a drawn result.          | - Declare the draw so the result |
|                                  | 2. Nothing happens when the game is over.  |   is clear                       |
|                                  |                                            |                                  |
+----------------------------------+--------------------------------------------+----------------------------------+
| You can continue playing after   | 1. Win the game with either letter.        | - Don't allow this               |
| a game has been won              | 2. Click in an unoccupied square behind    |                                  |
|                                  |    the banner to continue playing.         |                                  |
+----------------------------------+--------------------------------------------+----------------------------------+
| Clicking Play multiple times     | 1. Enter 3, then click Play.               | - Disable / remove the button    |
| after numeric input duplicates   | 2. Click Play again.                       |   after the game is started      |
| the game board                   | 3. Another 3x3 board is generated          |                                  |
+----------------------------------+--------------------------------------------+----------------------------------+

Creating a new automated regression suite for Calendly
------------------------------------------------------
Considerations: web, mobile, what tests to automate / not automate, where it fits in current process. unit, acceptance, end-to-end tests.