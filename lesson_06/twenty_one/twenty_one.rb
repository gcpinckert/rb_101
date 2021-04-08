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

def display_cards(player_cards, dealer_cards)
  clear_screen
  prompt_pause "Dealer has: #{dealer_cards.sample} and an unknown card."
  prompt_pause "You have: #{joinor(player_cards, ', ', 'and')}"
  prompt_pause "Your current total is #{calculate_hand_total(player_cards)}"
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
    if value == 'A'
      sum += 11
    elsif value.to_i == 0
      sum += 10
    else
      sum += value.to_i
    end
  end

  cards.count { |_, value| value == 'A' }.times { sum -= 10 if sum > 21 }

  sum
end

def busted?(cards)
  calculate_hand_total(cards) > 21
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

def players_turn!(player_cards, dealer_cards, deck)
  loop do
    prompt_pause "What would you like to do?"
    prompt_pause "Enter 'h' to hit or 's' to stay."
    answer = valid_hit_or_stay
    break if answer == 's'
    player_cards << deal_single_card!(deck)
    break if busted?(player_cards)
    display_cards(player_cards, dealer_cards)
  end

  if busted?(player_cards)
    prompt_pause "Game Over"
  else
    prompt_pause "You chose to stay."
  end
end

def dealers_turn!(cards, deck)
  loop do
    break if calculate_hand_total(cards) >= 17
    cards << deal_single_card!(deck)
  end

  prompt_pause "Game Over. You win!" if busted?(cards)
end

def play_game(player_hand, dealer_hand, deck)
  display_cards(player_hand, dealer_hand)

  players_turn!(player_hand, dealer_hand, deck)
  dealers_turn!(dealer_hand, deck) unless busted?(player_hand)
end

def compare_cards(player, dealer)
  case
  when busted?(player) then "Dealer"
  when busted?(dealer) then "Player"
  when calculate_hand_total(player) > calculate_hand_total(dealer)
    "Player"
  when calculate_hand_total(dealer) > calculate_hand_total(player)
    "Dealer"
  else "It's a tie!"
  end
end

def display_winner(player, dealer, winner)
  prompt_pause "Player had #{calculate_hand_total(player)} points."
  prompt_pause "Dealer had #{calculate_hand_total(dealer)} points."
  prompt_pause "#{winner} won!"
end

def game_over(player, dealer)
  winner = compare_cards(player, dealer)
  display_winner(player, dealer, winner)
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
  player_hand = initialize_hand!(deck)
  dealer_hand = initialize_hand!(deck)

  play_game(player_hand, dealer_hand, deck)

  game_over(player_hand, dealer_hand)
  break if play_again == 'n'
end
