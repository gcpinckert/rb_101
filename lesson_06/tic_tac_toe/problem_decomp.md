# Tic Tac Toe Problem Decomposition

## Decomposing the Problem

**Game Description**
Tic Tac Toe is a 2 player game played on a 3x3 board. Each player takes a turn and
marks a square on the board. First player to reach 3 squares in a row, including diagonals, wins. If all 9 squares are marked and no player has 3 squares in a row, then the game is a tie.

**Game Play**

1. Display the initial empty 3x3 board.
2. Ask the user to mark a square
3. Computer marks a square
4. Display the updated board state.
5. If winner, display winner
6. If board is full, display tie.
7. If neither winner nr board is full, go back to #2
8. Ask user if they want to play again?
9. If yes, go back to #1
10. Good bye message

Outer loop game play -> #1 - #9
Inner loop each turn -> #2 - #7

## Program Outline

1. Start
    - Display welcome message
2. Display Board
    - Create nested array to represent board `[[_|_|_], [_|_|_], [_|_|_]]
    - Output to the screen
    - Create array of available moves
3. User Marks Square
    - Display prompt to user
    - Get user input
    - Validate user input
    - Mutate nested board array with player's move
    - Remove player's move from available moved
    - Display board with user's move
4. Computer Marks Square
    - Randomly select move from array of available moves
    - Remove computer move from available moves
    - Change nested board array
    - Display board array
5. Winner?
    - Winning conditions include:

    ```ruby
    # horizontal win:
    board[0][0] == board[0][1] == board[0][2] ||
    board[1][0] == board[1][1] == board[1][2] ||
    board[2][0] == board[2][1] == board[2][2]

    # vertical win:
    board[0][0] == board[1][0] == board[2][0] ||
    board[0][1] == board[1][1] == board[2][1] ||
    board[0][2] == board[1][2] == board[2][2]

    # diagonal win:
    board[0][0] == board[1][1] == board[2][2] ||
    board[0][2] == board[1][1] == board[2][0]
    ```

    - If no, check if board is full
    - If yes, display winner
    - Winner depends on whether char is `x` or `o`
6. Board full?
    - String at all elements of inner arrays contain either `x` or `o`?
    - If board is full, display a tie
    - If board is not full, back to #3 (no winner is implied by board full check)
7. Play Again?
    - Display prompt asking user if they want to play again?
    - Get input
    - Validate input
    - If yes, back to #2
    - If no, display goodbye message