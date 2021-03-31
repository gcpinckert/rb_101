# TTT Bonus Features

## Improved "join"

### Problem

Make the prompt that displays the square choices to the player read a little nicer. Currently, on line 83 of tictactoe.rb, we use the `join` method to create a string of all available squares the player can mark for their move. Instead of the built-in `join` method, create a `joinor` method according to the following specifications.

- Input: three arguments, an array and two (optional) strings
  - The array represents the elements you wish to join into a string
  - The first string argument is the punctuation delimiter for joining the elements
  - The second string argument is the conjunction you want placed before the last element
- Output: a single string that lists the elements passed in as an array
  - The string should have grammatically correct English with a conjunction
    - If there are only two elements in the array argument, no punctuation is needed
  - If no argument for a punctuation delimiter is given, `', '` is the default value
  - If no argument for conjunction is given, `'or'` is the default value.
  - If the array passed as argument is empty, return an empty string
  - If the array passed as argument has only one element, return the single element as a string

### Examples / Test Cases

```ruby
joinor([1, 2])                   # => "1 or 2"
joinor([1, 2, 3])                # => "1, 2, or 3"
joinor([1, 2, 3], '; ')          # => "1; 2; or 3"
joinor([1, 2, 3], ', ', 'and')   # => "1, 2, and 3"
joinor([])                       # => ""
joinor([1])                      # => "1" 
```

### Algorithm / Data Structure

1. Check the size of the array
2. If it is empty:
    - Return an empty string
3. If it has one element:
    - Return that element as a string
4. If it has two elements:
    - Return the element at index 0 + space + conjunction + space + element at index 1
5. If it has more than 2 elements:
    - Join all the array elements except the last one with the provided punctuation delimiter
    - Append the punctuation + conjunction + last array element to the string
6. Return the string

## Keep Score

### Problem

Keep score of how many games both the player and the computer has won. Make game play tournament style, where the first player to reach 5 wins wins the game.

#### Rules

1. Don't use global or instance variables (i.e. pass the scores around as an argument)
2. When either player reaches 5 wins, game play is over, and a winner is displayed
3. For clarity, add an explanation of the first-to-five rule to the welcome message
4. For clarity, display a running total of each players score when the board is displayed

### Algorithm / Data Structure

1. Create an outer loop around the main `play_game` loop for the tournament
    - This can be a separate method `play_tournament`
2. Outside of the main `play_game` loop initialize a hash to keep track of players scores
3. Make sure the hash is passed in as an argument to all the relevant methods
4. If either player wins a game, update the scores hash
    - Display the updated score for the winner
    - Modify the `prompt` method to include a short pause for easier readability of scores before screen is cleared in new game (call it `prompt_pause`).
5. Display the running scores with the board display on each turn / play-through
6. If either player's score reaches 5, end the tournament loop
    - Helper method that returns a Boolean, `tournament_over?`
7. Display a message for the "ultimate victory"
8. Ask player if they want to play again outside the `play_game` loop but it is the break condition for the larger `play_tournament` loop
9. Add a line to the `display_welcome` message explaining the first-to-five tournament rules

## Computer AI: Defense

### Problem

Make the computer defensive minded. If there is an immediate threat (i.e. if there are 2 squares marked by the player in a row), the computer should defensively mark the 3rd square. If there is no immediate threat, then it will just pick a random square.

### Rules

1. If 2 squares are marked by the player (opponent) in any winning row, the computer should mark the last square in that winning row.
2. Otherwise, the computer will choose a square to mark randomly.

### Algorithm / Data Structure

1. Assign `square` the value of `nil`. Now it can be used in a conditional to see if another value has been assigned in the `defensive` iteration.
2. Iterate through the `WINNING_LINES` constant
3. Within each iteration, assign the value (if any) returned by `defensive_computer_move` to `square`
4. Within `defensive_computer_move` method:
    - If any of the winning lines contain 2 of the opponent's marker and 1 of the initial marker
    - Return the element in the current `line` whose value is `INITIAL_MARKER`
    - Should there be no defensive moves available, the `if` statement will return `nil` which will be assigned to `square` again.
5. Break out of the iterations through `WINNING_LINES` if square is assigned a truthy value
6. If `square` still references `nil`
    - Assign a random square as before
7. Mutate the `board` hash to reflect the computer's move, whether random of defensive

## Computer AI: Offense

### Problem

Give the computer an offensive move option: If the computer has 2 squares in a winning row filled, have it mark the 3rd square in that row (instead of moving at random).

### Rules

1. First the computer should check to see if it needs to move defensively (see above). 
2. Then the computer should check to see if it has an offensive opportunity
    - If two of the squares in any of the `WINNING_ROWS` are filled
    - Have the computer mark the third square in that row
3. Otherwise, if there is no availability for defense or offense, have the computer choose a square at random.

### Algorithm / Data Structure

1. First check to see if there are defensive moves available (see above)
2. Iterate through the `WINNING_LINES` constant
    - Within each iteration, assign the value (if any) returned by `offensive_computer_move` to `square`.
        - If any of the winning lines contain 2 of the computer's marker and 1 of the initial marker:
        - Return the element in the current `line` whose value is `INITIAL_MARKER`.
        - If no offensive moves are available, the `if` statement will return `nil` which will keep square with a falsey value
    - Break out of the iterations through `WINNING_LINES` if square is assigned a truthy value
3. If `square` still references `nil` assign a random square as before
4. Mutate the `board` hash to reflect the computer's move

## Computer Turn Refinements

### Problem

1. Currently, the computer chooses a defensive move even if it has the chance to win. Update the code so it plays it's offensive move first if it has a chance to win.

2. Have the computer choose square #5 if it is available. Basically the logic for the computer move should go in the following order:
    - Win if a winning move is available
    - Defend if opponent has an opportunity to make a winning move
    - Pick square #5 if it is available
    - Pick a random square

3. Create a constant such that the game can be played with either the computer or the player going first. If the constant is set to "choose", the game should prompt the user to determine who goes first. Valid options for the constant can be "player", "computer", or "choose".

### Pick Square #5

- Add conditional within the `if !square` statement on ln 117.
- If the #5 square is still empty (i.e. if it's value in the `board` hash is `INITIAL_MARKER`)
- `square` will be equal to `5`.
- Otherwise, the computer will choose a move randomly as before

### Who Goes First?

- Create a constant `FIRST_TURN = { current_player: 'choose' }`.
- In a separate method, prompt the user to choose who will go first, `'Player'` or `'Tic-Tac-Toeminator'`
  - Have `'p'` = `PLAYER` and `'t'` = `COMPUTER`.
  - Validate input
  - Modify the `FIRST_TURN` hash according to the user's choice
- In the `turn_cycle` method definition:
  - If `FIRST_TURN[:current_player] == PLAYER`: game play proceeds as before
  - If `FIRST_TURN[:current_player] == COMPUTER`
    - New method `computer_first` (??)
    - `computer_places_piece!` comes before `player_places_piece!`
  - After each turn_cycle when we start a new match
    - Switch the `FIRST_TURN[:current_player]` to the alternate value (new method?)
- When a new tournament is begun, reset `FIRST_TURN[:current_player]` to `'Choose'`

## Improve the Game Loop

In the main game loop (`turn_cycle` method definition, lines 173 - 198) there is some redundancy. Not only do we have a break statement after each player makes a move, but currently (as of commit `dad67a6f`) we have each player's turn being called in different order according to who goes first. This can be made more efficient by writing a generic method that marks a square based on a player.

Example:

```ruby
loop do
  display_board(board)
  place_piece!(board, current_player)
  current_player = alternate_player(current_player)
  break if someone_won?(board) || board_full?(board)
end
```

Above, the `place_piece!` just such a generic method. Depending on what value is passed to it as the argument `current_player`, it should call either `computer_places_piece!` (line 137) or `player_places_piece!` (line 121). 

### Algorithm

- `place_piece!` method
  - If `current_player == PLAYER` then invoke `player_places_piece!`
  - If `current_player == COMPUTER` then invoke `computer_places_piece!`
- `alternate_player`
  - If `current_player == PLAYER` then set it to `COMPUTER`
  - If `current_player == COMPUTER` then set it to `PLAYER`

## Other Improvement To-Dos

- [x] Extract all instances of the strings "Player" & "Tic-Tac-Toeminator" to constants
- [x] Print the square numbers when the board is displayed
- [x] Go through and make sure all methods are discreet and simple (i.e. side-effect or return value? not both)
- [x] Organize method definitions for easy code readability
- [x] Better input validation throughout
- [x] Get rid of any code redundancies
- [x] Extract hard-coded `5` (games to win tournament) to constant (`tournament_over?` line 249)
- [ ] Switch markers when first turn is alternated? (Traditionally, 'X' goes first, but is this confusing?)
- [x] Add "Would you like to keep playing?" after each game to make it easy to quit out before tournament completion
