def prompt_pause(msg, time=1)
  puts "=> #{msg}"
  sleep(time)
end

def clear_screen
  system 'clear'
end

def display_welcome
  clear_screen
  prompt_pause "Welcome to Twenty One!"
  prompt_pause "Get as close to 21 points as possible, without going over."
  prompt_pause "Cards 2-10 are each worth their face value."
  prompt_pause "Jacks, Queens, and Kings are all worth 10."
  prompt_pause "An Ace can be worth either 11 or 1."
  prompt_pause "Tell the dealer 'hit' to get another card, or choose 'stay'" \
         " to try your luck with what you've got."
  prompt_pause "If you go over 21 points, you 'bust' and the dealer wins!"
  prompt_pause "Good luck!"
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

def display_cards(hands, totals)
  clear_screen
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
  cards.count { |_, value| value == 'A' }.times { sum -= 10 if sum > 21 }
  sum
end

def busted?(hand_total)
  hand_total > 21
end

def valid_hit_or_stay
  answer = nil

  loop do
    answer = gets.chomp.downcase.strip
    break if %w(h s).include?(answer)
    prompt_pause "Invalid input. Please enter 'h' or 's'."
  end

  answer
end

def players_turn!(hands, totals, deck)
  loop do
    prompt_pause "What would you like to do?"
    prompt_pause "Enter 'h' to hit or 's' to stay."
    answer = valid_hit_or_stay
    break if answer == 's'
    card = deal_single_card!(deck)
    prompt_pause "Player got #{card}."
    hands[:player] << card
    totals[:player] = calculate_hand_total(hands[:player])
    break if busted?(totals[:player])
    display_cards(hands, totals)
  end

  if busted?(totals[:player])
    prompt_pause "PLAYER BUSTS!"
  else
    prompt_pause "You chose to stay."
  end
end

def dealers_turn!(cards, totals, deck)
  loop do
    break if totals[:dealer] >= 17
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

def play_game(hands, totals, deck)
  display_cards(hands, totals)

  players_turn!(hands, totals, deck)
  dealers_turn!(hands[:dealer], totals, deck) unless busted?(totals[:player])
end

def game_result(totals)
  if totals[:player] > 21
    "Player busted. Dealer wins!"
  elsif totals[:dealer] > 21
    "Dealer busted. You win!"
  elsif totals[:player] > totals[:dealer]
    "Player has more points. You win!"
  elsif totals[:dealer] > totals[:player]
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
  compare_cards(totals) unless busted?(totals[:player]) || busted?(totals[:dealer])
  prompt_pause result
end

def game_over(totals)
  result = game_result(totals)
  display_winner(totals, result)
end

def play_again
  answer = nil
  loop do
    prompt_pause "Would you like to play again? ('y' or 'n')"
    answer = gets.chomp.downcase.strip
    break if %w(y n).include?(answer)
    prompt_pause "Invalid input. Please enter 'y' or 'n'."
  end

  answer
end

display_welcome

loop do
  deck = initialize_deck
  hands = { player: initialize_hand!(deck), dealer: initialize_hand!(deck) }
  totals = { player: calculate_hand_total(hands[:player]), 
             dealer: calculate_hand_total(hands[:dealer]) }

  play_game(hands, totals, deck)

  game_over(totals)
  break if play_again == 'n'
end
