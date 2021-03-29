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
