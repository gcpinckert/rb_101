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
