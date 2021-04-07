# Assignment: Twenty-One

Build a command line game called Twenty-One that is similar to Blackjack. 

## Rules

- Start with a 52-card deck.
  - 4 suits (hearts, diamonds, clubs, spades)
  - 13 values in each suit (2-10, J, Q, K, A)
- Goal: try to get as close to 21 points as possible without going over. 
  - If you go over 21 points, it's a "bust" and you lose
- Setup: 
  - 2 players, "dealer" and "player"
  - Both are dealt 2 cards
  - Player can see their 2 cards, but can only see one of the dealer's cards
- Card Values:
  - 2-10 = worth their face value (i.e. 2 = 2 points)
  - J, Q, K = worth 10 points
  - A = can be worth either 1 or 11 points
  - The ace's value is determined (by the program) every time a new card is drawn from the deck. 
    - If a hand contains a 2, an A, and a 5, the total value is 18 (2 + 11 + 5). Here the A is worth 11 because the total value of the hand is lower than 21.
    - If the total value of the hand exceeds 21 with the Ace being worth 11, then the Ace will be worth 1. 
    - If there are multiple Aces in a hand, the program must account for that. For example, a hand with a pair of Aces must be worth 12 (11 + 1), since 11 + 11 is 22, which is greater than 21. 
- Player's Turn:
  - The player goes first. 
  - Player chooses either "hit" or "stay"
  - "hit" = the player gets another card. If the new total exceeds 21, the player "busts" and loses.
  - "stay" = the player sticks with the current hand he has been dealt
  - This decision depends on what the player's cards are and what the player thinks the dealer has. 
    - For example, if the dealer is showing a "10" and the player has a "2" and a "4", the player will want to choose "hit"
  - The player can continue to "hit" as many times as they wish.
  - The turn is over when the player either busts or stays
  - If the player busts, the game is over and the dealer has won.
- Dealer's Turn:
  - When the player chooses "stay", it is the dealer's turn.
  - Dealer also chooses "stay" or "hit"
  - Dealer must always choose "hit" until his total hand value is greater than or equal to 17. 
  - If the dealer busts, the player wins.
- Comparing cards:
  - When both the player and the dealer choose "stay", it is time to compare the total value of the cards and see who has the highest value.

## Examples of Gameplay

1.
  ```
  Dealer has: Ace and unknown card
  You have: 2 and 8
  ```

  In this scenario, the player should choose "hit". Because the dealer has an "Ace", he has a high probability of having a 21. Additionally, player's total is 10, which is low enough to benefit from an extra card. Since the highest value card is 11, there is no way the player can bust.

2. 
  ```
  Dealer has: 7 and unknown card
  You have: 10 and 7
  ```

  Here the player should choose "stay". The only situation in which the Player can loose is one in which the dealer's unknown card is an Ace, and there is a small probability that this is the case. Odds are good for a win with a total of 17, or a tie.

3. 
  ```
  Dealer has: 5 and unknown card
  You have: Jack and 6
  ```

  In this case the dealer has a low card and an unknown card. Even if the unknown card has a value of 10, the total value is 15, meaning he must "hit". It's likely in this case that the dealer will bust. The best move for the player is to "stay", and hope the dealer busts.

## Implementation Steps

1. Initialize the deck
2. Deal cards to the player and the dealer
3. Player turn: hit or stay
    - Repeat until bust or stay
4. If player busts, dealer wins
5. Dealer turn: hit or stay
    - Repeat until total >= 17
6. If dealer busts, player wins
7. Compare cards and declare winner

## Sub-Processes

### Start

- Display welcome message
- Explain the rules of the game
- Enter main game loop

### Initialize the Deck

- Each deck has 52 "cards".
- Each card consists of a "suit" and a "value"
- Each card must be represented individually so that it can be eliminated from the deck once it has been dealt.
- Create a hash `deck`: each key will be a suit and each value will be an array representing all card values in that suit
- Update the value `deck` each time a card gets dealt such that the array only has cards that have not yet been used
- `deck` will be a local variable that will be passed as an argument to any methods that need to access it

### Deal cards to the Player and the Dealer

- Initialize an empty array called `player_hand`
- Deal cards:
  - 2 cards should be dealt, for each card
  - Initialize an array (`card`)
  - Randomly select the `suit` (from keys in `deck`) and make it the first element in the `card` array
  - Shuffle the elements in the array of values associated with `suit`
  - Remove the last element in the array, and assign it to the second element in the `card` array
  - Append the `card` array to `player_hand`
- Initialize an empty array called `dealer_hand`
- Deal cards to the dealer as outlines above

#### Hit

- Deal a single card per the steps outlined above
- Then when cards are "dealt" you can just preform the `hit` method twice for each player

### Calculate Hand Total Value

- Program should be able to figure out the value of any Aces automatically
- Initialize a variable `sum`
- For each `card` in `player_hand`
  - Determine the card's value (`cards.each do |_, value|`)
  - If value is a string `'2'-'10'`, add that number of points to `sum`
  - If it is string `'J', 'Q', or 'K'` add `10` points to `sum`
  - If it is `'A'` add `11` to `sum`
- See if the value of any Aces needs to be changed:
- Is the total over 21?
  - Count the number of Aces in the hand `cards.count { |_, value| value == 'A' }`
  - For each ace, subtract `10` from `sum`
- Return `hand_value`

Example Method to Calculate a Total
```ruby
def total_hand_value(cards)
  # cards = [['H', '3'], ['S', 'Q'], ...]
  values = cards.map { |card| card[1] }

  sum = 0
  values.each do |value|
    if value == 'A'
      sum += 11
    elsif value.to_i == 0 # i.e. if 'J', 'Q', 'K'
      sum += 10
    else
      sum += value.to_i
    end
  end

  # correct for any Aces if sum is > 21
  # counts the number of Aces in the hand and iterated that amount of times
  values.select { |value| value == 'A' }.count.times do
    sum -= 10 if sum > 21
  end

  sum
end
```

### Player's Turn

- Initialize a loop
  - Display the total for the player
  - Ask the player if they want to "hit" or "stay
    - If "hit":
      - Deal the player another card
  - Break the loop if player chooses stay or they have `busted?`
  - `busted?` is a separate method that checks to see if the total  value of the hand is greater than 21
- If the player has `busted?` the dealer wins and the game is over
- If the player chose `stay` move on to the dealer's turn

### Dealer's Turn

- Initialize a loop
  - Break if the total value of the hand is > 17, or if the dealer has `busted?`
  - Deal the dealer another card
- If the dealer has `busted?` the player wins and the game is over
- If the total value of the dealer's hand is > 17, move on to comparing the cards

### Compare cards
- Calculate the total of the dealer's hand and the player's hand
- Whoever has the most points wins

### Display the winner
- Print who won the the console

### Play Again?
- Ask the player if they wish to play again. 
- If yes, go back to the top and initialize the deck
- If no, display a goodbye message and exit the program

