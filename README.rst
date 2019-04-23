Calendly Tic Tac Toe Test Suite
===============================
Thank you for the opportunity to demonstrate my skills in and passion for software testing, and for the chance to work
at a great, Atlanta-based technology company in Calendly! This document provides a description of the automated end-to-end 
test suite that I created for the `Tic Tac Toe game <https://codepen.io/jshlfts32/full/bjambP/>`_ described in the
assignment. Below, you will also find a write-up of my feedback from testing the game and recommendations for improving
the overall quality. Finally, please visit `YouTube <http://www.example.com/>`_ (this is not yet done) for a screencast
of the tests in action.

I have included my response for Question #2 in the assignment in the `Creating a new automated regression suite for Calendly`_
section.

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

    1. Python 3.3 or later must be installed.
    2. The Python package manager pip must be installed (usually included with the standard installation).
    3. A WebDriver that meets W3C specifications and that is supported by SeleniumLibrary must be installed and on the
       system PATH (any major browser). The matching browser's name should be defined in the variables_ file if Safari
       is not chosen.

.. _variables: TicTacToe/variables.py

After the above prerequisites have been installed. Clone or copy this project to a directory on your computer, then run
the below command in the project's root directory. Usually this should be done in a virtual environment. Properly setting
up a virtual environment is a matter of personal preference and outside the scope of this project::

    > pip install requirements.txt

That's all - now you are ready to run the tests. Run all of the tests in the TicTacToe directory (12 in total) and write
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
The following table breaks down each issue identified during testing. Review each row to understand how to reproduce
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
| Placeholder text and instructions| 1. Try to read the placeholder text in the | - Include playing instructions   |
| are poor / lacking               |    input field.                            | - Make sure placeholder text is  |
|                                  | 2. Try to determine how to play or start   |   is visible                     |
|                                  |    the game without trial and error.       | - Display a 3x3 board by default |
+----------------------------------+--------------------------------------------+----------------------------------+
| Only way to play again is to     | 1. Play a game until it won / drawn.       | - Add a "Play Again" button      |
| refresh the page                 | 2. You must refresh to play again.         | - Create the settings for the    |
|                                  |                                            |   new game in a modal            |
+----------------------------------+--------------------------------------------+----------------------------------+
| The layout is plain and          | 1. Play a game and try to enjoy it.        | - Add custom letters / themes    |
| uninteresting                    | 2. It is hard!                             | - Add animations                 |
|                                  |                                            | - Add sounds                     |
+----------------------------------+--------------------------------------------+----------------------------------+

Creating a new automated regression suite for Calendly
------------------------------------------------------
It is always a challenge to retroactively implement automated regression tests for a production application. Doing so
requires careful planning to ensure new feature work and bug fixes are supported while also adding **valuable** automated
test coverage. To develop a plan, the following steps should be completed to begin with:

    1. Gather and document existing test cases. We need not only test steps and expected results, but also required time
       to complete the test manually and how critical the test is to the application.
    2. Evaluate each manual test to estimate the time investment required to automate it, and whether or not the test
       is a good candidate for automation at all.
    3. Prioritize tests for automation based on factors in #1 and #2. Tests that can be quickly automated, that are executed
       often manually, and are critical to the functionality of the system should be first. Tests that are difficult to
       automate, that are not executed often manually or are not critical tests should be automated later or not at all.
    4. Finally, we would want to ensure that tests are written in a maintainable and reproducible manner. Selenium-based
       tests are notorious for being fragile and can often break with minor changes to the front-end of the application.
       Therefore, automated tests need to be designed with that in mind, so that existing test cases can be quickly updated
       and new ones can be quickly written.

In terms of the technology and tools to use, there are several considerations:

    - End-to-end web tests typically require Selenium, though newer tools like Puppeteer_ exist for Chromium browser-based
      automated tests. If many browsers, browser versions and operating systems are supported, third-party platforms like
      Sauce Labs and Browser Stack can be valuable.
    - Mobile testing involves many of the same considerations as web testing, though platforms and browser versions are
      more numerous. Appium is the standard tool for mobile test automation.
    - All automated tests should be individually executable and independent of other tests, expected external states, or
      data that is not created during the test.  This allows tests to be run in parallel and across environments when the time comes.
    - The technology stack of the system under test is important to consider.  Automated tests are most valuable when they
      are executed as early in the development process as possible. Ideally, this means allowing developers to easily execute
      tests in local or integrated development environments. If automated tests have the same dependencies as the system
      being tested, developers can execute and understand them more easily.

Lastly, and most importantly, teamwork and communication are key factors in the success of a project like this. All plans
should be clearly communicated and documented. Progress should be shared. Opinions should be heard. We want to avoid
quietly developing an automated test tool only to find that it is not useful down the road. In the same way that we would
not complete feature work without user input, we should not create automated test features without input from product
and development teams.

.. _Puppeteer: https://github.com/GoogleChrome/puppeteer
