from robot.api import logger
from robot.libraries.BuiltIn import BuiltIn
from SeleniumLibrary import SeleniumLibrary
from SeleniumLibrary.base import keyword


class TicTacToeSeleniumLibrary(SeleniumLibrary):
    """
    An extension of Robot Framework SeleniumLibrary for the Tic Tac Toe game. Custom keywords are listed below. The rest
    are provided by SeleniumLibrary.
    - `Enter O In Table Cell`
    - `Enter X In Table Cell`
    - `Game Board Should Be Displayed`
    - `Game Board Should Be Empty`
    - `Start A New Game`
    """
    turn = None

    @keyword
    def start_a_new_game(self, size=3):
        """Start a new game of Tic Tac Toe on the site. Default board ``size`` is 3x3."""
        logger.info("Starting a new game of Tic Tac Toe on a {x}x{y} board.".format(x=size, y=size))
        board_size_input = BuiltIn().get_variable_value("${BOARD_SIZE_INPUT}")
        self.wait_until_element_is_visible(board_size_input)
        self.input_text(board_size_input, size)
        self.click_button("Play")
        self.turn = "X"

    @keyword(name="Enter X in Table Cell")
    def enter_x_in_table_cell(self, row, column):
        """
        Click in the displayed Tic Tac Toe board to enter an X into the desired cell, defined by the ``row``
        index and ``column`` index (1-based). If the space is already occupied, this will cause an error.
        """
        self._enter_letter_in_table_cell("X", row, column)

    @keyword(name="Enter O in Table Cell")
    def enter_o_in_table_cell(self, row, column):
        """
        Click in the displayed Tic Tac Toe board to enter an X into the desired cell, defined by the ``row``
        index and ``column`` index (1-based).
        """
        self._enter_letter_in_table_cell("O", row, column)

    def _enter_letter_in_table_cell(self, letter, row, column):
        """Play Tic Tac Toe by putting letters in the table!"""

        if self.turn != letter:
            raise GameplayError("Tried to play an {letter}, but it is {turn}'s turn! "
                                "Make sure to start a new game if you didn't do that.".format(letter=letter,
                                                                                              turn=self.turn))
        loc = self._get_cell_locator(row, column)
        self.wait_until_element_is_visible(loc,
                                           error="Cell with row index {row} and column index "
                                                 "{column} not found.".format(row=row,
                                                                              column=column))
        logger.info("Clicking row {row}, column {col} to place an {letter} in the cell.".format(row=row,
                                                                                                col=column,
                                                                                                letter=letter))
        self.click_element(loc)
        self.wait_until_element_contains(loc,
                                         self.turn,
                                         error="Unexpected content found in row {row}, column {column}. Expected "
                                               "{turn}, but found something else.".format(row=row,
                                                                                          column=column,
                                                                                          turn=self.turn))
        if letter == "O":
            self.turn = "X"
        else:
            self.turn = "O"

    @staticmethod
    def _get_cell_locator(row, column):
        row = int(row) - 1
        column = int(column) - 1
        cell_xpath = "xpath://td[@data-row='{row}' and @data-column={col}]".format(row=row,
                                                                                   col=column)
        logger.info(cell_xpath)
        return cell_xpath

    @keyword
    def game_board_should_be_displayed(self, size):
        """Verify that the Tic Tac Toe board has the expected ``size`` in the format *NxN*."""
        try:
            rows, columns = size.split("x")
            rows = int(rows)
            columns = int(columns)
        except ValueError:
            raise AssertionError("Size should be in the format NxN (e.g. 3x3), but was not.")
        table_rows = self.get_webelements("xpath://tr[ancestor::table[@id='table']]")
        if rows != len(table_rows):
            BuiltIn().fail("Unexpected number of rows in the game board.")
        for r in table_rows:
            if len(r.find_elements_by_tag_name("td")) != columns:
                BuiltIn().fail("Unexpected number of columns in one of the rows on the game board.")

    @keyword
    def game_board_should_be_empty(self):
        """Verify that all table cells are empty on the game board."""
        table_cells = self.get_webelements("xpath://td[ancestor::table[@id='table']]")
        assert all(map(lambda e: e.text == "",
                       table_cells)), "Board should have been empty, but was not."


class TicTacToeError(Exception):
    """Base class for Tic Tac Toe errors."""

    def __init__(self, message='', details=''):
        Exception.__init__(self, message)
        self.details = details


class GameplayError(TicTacToeError):
    """Should be used to indicate and prevent attempts to violate Tic Tac Toe game rules."""
    pass
