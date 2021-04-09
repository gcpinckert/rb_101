ROUNDS_TO_WIN = 5
DEALER_STAYS = 17
POINTS_UPPER_LIMIT = 21

def prompt_pause(msg, time=1)
  puts "=> #{msg}"
  sleep(time)
end

def clear_screen
  system 'clear'
end

def display_welcome
  clear_screen
  prompt_pause "Welcome to #{POINTS_UPPER_LIMIT}!"
  prompt_pause "Get as close to #{POINTS_UPPER_LIMIT} points as possible, " \
               "without going over."
  prompt_pause "Cards 2-10 are each worth their face value."
  prompt_pause "Jacks, Queens, and Kings are all worth 10."
  prompt_pause "An Ace can be worth either 11 or 1."
  prompt_pause "Tell the dealer 'hit' to get another card, or choose 'stay'" \
               " to try your luck with what you've got."
  prompt_pause "If you go over #{POINTS_UPPER_LIMIT} points, you 'bust' and" \
               " the dealer wins!"
  prompt_pause "The first player to win #{ROUNDS_TO_WIN} games wins the " \
               "tournament!"
  prompt_pause "Good luck!", 4
end

def initialize_deck
  new_deck = {}
  %w(H D C S).each { |suit| new_deck[suit] = %w(2 3 4 5 6 7 8 9 10 J Q K A) }
  new_deck
end

def deal_single_card!(deck)
  suit = deck.keys.sample         # randomly select a suit
  value = deck[suit].shuffle!.pop # randomly remove a card from that suit
  [suit, value]
end

def initialize_hand!(deck)
  hand = []
  2.times { hand << deal_single_card!(deck) }
  hand
end

def display_cards(hands, totals, score)
  clear_screen
  prompt_pause "SCORE You: #{score[:player]} Dealer: #{score[:dealer]}"
  prompt_pause "Dealer has: #{hands[:dealer][0]} and an unknown card."
  prompt_pause "You have: #{joinor(hands[:player], ', ', 'and')}"
  prompt_pause "Your current total is #{totals[:player]}"
end

def joinor(array, punctuation = ', ', conjunction = 'or')
  case array.length
  when 0 then ''
  when 1 then array[0].to_s
  when 2 then "#{array[0]} #{conjunction} #{array[1]}"
  else
    array[0..-2].join(punctuation) +
      "#{punctuation}#{conjunction} #{array[-1]}"
  end
end

def calculate_hand_total(cards)
  sum = 0

  cards.each do |_, value|
    sum += if value == 'A'
             11
           elsif value.to_i == 0
             10
           else
             value.to_i
           end
  end

  sum = correct_for_aces(cards, sum)
  sum
end

def correct_for_aces(cards, sum)
  cards.count { |_, value| value == 'A' }.times do
    sum -= 10 if sum > POINTS_UPPER_LIMIT
  end

  sum
end

def busted?(hand_total)
  hand_total > POINTS_UPPER_LIMIT
end

def hit_or_stay?
  answer = nil

  prompt_pause "What would you like to do?", 0
  prompt_pause "Enter 'h' to hit or 's' to stay."

  loop do
    answer = gets.chomp.downcase.strip
    break if %w(h s).include?(answer)
    prompt_pause "Invalid input. Please enter 'h' or 's'."
  end

  answer == 's'
end

def players_turn!(hands, totals, deck)
  loop do
    break if hit_or_stay?

    card = deal_single_card!(deck)
    prompt_pause "Player got #{card}."
    hands[:player] << card

    totals[:player] = calculate_hand_total(hands[:player])
    prompt_pause "Your new total is #{totals[:player]}."

    break if busted?(totals[:player])
  end

  if busted?(totals[:player])
    prompt_pause "PLAYER BUSTS!"
  else
    prompt_pause "You chose to stay."
  end
end

def dealers_turn!(cards, totals, deck)
  loop do
    break if totals[:dealer] >= DEALER_STAYS
    prompt_pause "Dealer hits."
    card = deal_single_card!(deck)
    cards << card
    prompt_pause "Dealer gets #{card}."
    totals[:dealer] = calculate_hand_total(cards)
  end

  if busted?(totals[:dealer])
    prompt_pause "DEALER BUSTS!"
  else
    prompt_pause "Dealer stays."
  end
end

def play_single_round(hands, totals, deck, score)
  display_cards(hands, totals, score)

  players_turn!(hands, totals, deck)
  dealers_turn!(hands[:dealer], totals, deck) unless busted?(totals[:player])
end

def game_result!(totals, score)
  if totals[:player] > POINTS_UPPER_LIMIT
    score[:dealer] += 1
    "Player busted. Dealer wins!"
  elsif totals[:dealer] > POINTS_UPPER_LIMIT
    score[:player] += 1
    "Dealer busted. You win!"
  elsif totals[:player] > totals[:dealer]
    score[:player] += 1
    "Player has more points. You win!"
  elsif totals[:dealer] > totals[:player]
    score[:dealer] += 1
    "Dealer has more points. Dealer wins!"
  else "It's a tie!"
  end
end

def compare_cards(totals)
  prompt_pause "Both players have stayed."
  prompt_pause "Player has #{totals[:player]} points."
  prompt_pause "Dealer has #{totals[:dealer]} points."
end

def display_winner(totals, result)
  unless busted?(totals[:player]) || busted?(totals[:dealer])
    compare_cards(totals)
  end

  prompt_pause result
end

def game_over(totals, score)
  result = game_result!(totals, score)
  display_winner(totals, result)
end

def play_again?
  answer = nil
  loop do
    prompt_pause "Would you like to play again? ('y' or 'n')"
    answer = gets.chomp.downcase.strip
    break if %w(y n).include?(answer)
    prompt_pause "Invalid input. Please enter 'y' or 'n'."
  end

  answer == 'y'
end

def display_tournament_winner(score)
  if score[:player] > score[:dealer]
    prompt_pause "You've won the tournament! Congratulations!"
    prompt_pause "Next stop... VEGAS!"
  else
    prompt_pause "Aww, the dealer has beat you this time."
    prompt_pause "You know what they say, the house always wins!"
  end
end

def display_goodbye
  prompt_pause "Thank you for playing #{POINTS_UPPER_LIMIT}! Goodbye!"
end

display_welcome

loop do
  score = { player: 0, dealer: 0 }

  loop do
    deck = initialize_deck
    hands = { player: initialize_hand!(deck), dealer: initialize_hand!(deck) }
    totals = { player: calculate_hand_total(hands[:player]),
               dealer: calculate_hand_total(hands[:dealer]) }

    play_single_round(hands, totals, deck, score)

    game_over(totals, score)
    break if score.values.include?(ROUNDS_TO_WIN)
  end

  display_tournament_winner(score)

  break unless play_again?
end

display_goodbye
