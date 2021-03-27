# Tic Tac Toe Problem Decomposition

## Decomposing the Problem

### Game Description

Tic Tac Toe is a 2 player game played on a 3x3 board. Each player takes a turn and
marks a square on the board. First player to reach 3 squares in a row, including diagonals, wins. If all 9 squares are marked and no player has 3 squares in a row, then the game is a tie.

### Game Play

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
    - Make sure this is reset on each game play through
    - Create hash to represent state of board `{1 => ' ', 2 => ' ', ...}`
      - Each number key in the hash represents a square on the board
      - Each value represents what is displayed within that square (X, O , or space)
    - Output the board to the screen
3. User Marks Square
    - Display prompt to user
    - Get user input
    - Validate user input
      - Make sure only blank squares are available to the user
    - Update board with player's move (permanent modification)
    - Display board with user's move
4. Computer Marks Square
    - Randomly select move from array of available moves (`board.keys.select{ |num| brd[num] == INITIAL_MARKER}`)
    - Update Board (permanent modification)
    - Display board array
5. Winner?
    - Winning conditions include:

    ```ruby
    # Each number in the sub-arrays represents a square
    # Each number is also a key in the hash representing the state of the board
    winning_lines = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                    [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                    [[1, 5, 9], [3, 5, 7]]              # diagonals
    ```

    - Check to see if the values are equal across any of the winning lines
      - Iterate over the nested array, for each sub-array
      - Check the value of each item within the sub array against the other items
    - Break out of the method with a return statement within a conditional
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

## Other Notes

### Rubocop

If you find that a cop is complaining about something that you feel is necessary in the code (for example, the length of a method that is displaying something like an image to the screen), you can disable it using a comment:

`# rubocop:disable <NameOfCopHere>`

You then re-enable that particular cop again after the section of code that you didn't want it active.

`# rubocop:enable <NameOfCop>`

Additionally, you can disable / enable as many cops as need be with a single comment.

`# rubocop:disable <NameOfCop>, <AnotherCop>`

Remember, at the end of the day Rubocop should be taken as advisement not law.
