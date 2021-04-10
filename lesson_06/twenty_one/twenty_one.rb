ROUNDS_TO_WIN = 5
DEALER_STAYS = 17
POINTS_UPPER_LIMIT = 21

HIDDEN_CARD = [" _________ ",
               "|\\\\\\\\\\\\\\\\\\|",
               "|/////////|",
               "|\\\\\\\\\\\\\\\\\\|",
               "|/////////|",
               "|\\\\\\\\\\\\\\\\\\|"]

def prompt_pause(msg, time=1)
  puts "=> #{msg}"
  sleep(time)
end

def clear_screen
  system 'clear'
end

# rubocop:disable Metrics/MethodLength
def display_welcome
  clear_screen
  prompt_pause "Welcome to #{POINTS_UPPER_LIMIT}!"
  prompt_pause "Get as close to #{POINTS_UPPER_LIMIT} points as possible, " \
               "without going over."
  puts ""
  prompt_pause "Cards 2-10 are each worth their face value."
  prompt_pause "Jacks, Queens, and Kings are all worth 10."
  prompt_pause "An Ace can be worth either 11 or 1."
  puts ""
  prompt_pause "Tell the dealer 'hit' to get another card, or choose 'stay'" \
               " to try your luck with what you've got."
  prompt_pause "If you go over #{POINTS_UPPER_LIMIT} points, you 'bust' and" \
               " the dealer wins!"
  prompt_pause "The first player to win #{ROUNDS_TO_WIN} games wins the " \
               "tournament! Good luck!"
  puts ""
  prompt_pause "Shuffling cards..."
  8.times do
    print ". "
    sleep 1
  end
end
# rubocop:enable Metrics/MethodLength

# ----- shuffling and dealing logic -----
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

# ----- card display logic -----
def suit_symbol(card)
  case card[0]
  when 'C' then "\u2663"
  when 'S' then "\u2660"
  when 'H' then "\u2665"
  when 'D' then "\u2666"
  end
end

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
def make_seen_card(lines, card)
  s = suit_symbol(card)
  v = card[1]

  lines[0] << " _________ "
  if v == '10'
    lines[1] << "#{v}        |"
    lines[2] << "|         |"
    lines[3] << "|    #{s}    |"
    lines[4] << "|         |"
    lines[5] << "|________#{v}"
  else
    lines[1] << "|#{v}        |"
    lines[2] << "|         |"
    lines[3] << "|    #{s}    |"
    lines[4] << "|         |"
    lines[5] << "|________#{v}|"
  end
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

def make_hidden_card(lines)
  lines[0] << HIDDEN_CARD[0]
  lines[1] << HIDDEN_CARD[1]
  lines[2] << HIDDEN_CARD[2]
  lines[3] << HIDDEN_CARD[3]
  lines[4] << HIDDEN_CARD[4]
  lines[5] << HIDDEN_CARD[5]
end

def display_dealer_cards(hand)
  lines = [[], [], [], [], [], []]

  hand.each_with_index do |card, index|
    if index == 0
      make_hidden_card(lines)
    else
      make_seen_card(lines, card)
    end
  end

  lines.each { |line| puts line.join("  ") }
end

def display_player_cards(hand)
  lines = [[], [], [], [], [], []]

  hand.each do |card|
    make_seen_card(lines, card)
  end

  lines.each { |line| puts line.join("  ") }
end

# rubocop:disable Metrics/AbcSize
def display_cards(game_data)
  clear_screen
  prompt_pause "SCORE You: #{game_data[:player][:score]} " \
               "Dealer: #{game_data[:dealer][:score]}", 0
  puts ""
  puts "======== DEALER ========"
  display_dealer_cards(game_data[:dealer][:hand])
  puts ""
  puts "======== PLAYER ========"
  display_player_cards(game_data[:player][:hand])
  puts ""
  prompt_pause "Your current total is #{game_data[:player][:total]}.", 0
end
# rubocop:enable Metrics/AbcSize

# ----- game play logic -----
def deal_person_in!(game_data, person, deck)
  game_data[person][:hand] = initialize_hand!(deck)
  game_data[person][:total] = calculate_total(game_data[person][:hand])
end

def calculate_total(cards)
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

def stay?
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

def hit!(game_data, person, deck)
  game_data[person][:hand] << deal_single_card!(deck)
  game_data[person][:total] = calculate_total(game_data[person][:hand])
end

def players_turn!(game_data, deck)
  loop do
    break if stay?

    hit!(game_data, :player, deck)
    display_cards(game_data)

    break if busted?(game_data[:player][:total])
  end

  if busted?(game_data[:player][:total])
    prompt_pause "PLAYER BUSTS!", 2
  else
    prompt_pause "You chose to stay."
  end
end

def dealers_turn!(game_data, deck)
  loop do
    break if game_data[:dealer][:total] >= DEALER_STAYS
    prompt_pause "Dealer hits."

    hit!(game_data, :dealer, deck)
    display_cards(game_data)
  end

  if busted?(game_data[:dealer][:total])
    prompt_pause "DEALER BUSTS!", 2
  else
    prompt_pause "Dealer stays."
  end
end

def play_single_round(game_data, deck)
  display_cards(game_data)

  players_turn!(game_data, deck)
  dealers_turn!(game_data, deck) unless busted?(game_data[:player][:total])
end

def game_result(game_data)
  if game_data[:player][:total] > POINTS_UPPER_LIMIT
    :player_busted
  elsif game_data[:dealer][:total] > POINTS_UPPER_LIMIT
    :dealer_busted
  elsif game_data[:player][:total] > game_data[:dealer][:total]
    :player
  elsif game_data[:dealer][:total] > game_data[:player][:total]
    :dealer
  else
    :tie
  end
end

def increase_score!(game_data, winner)
  if winner == :player_busted || winner == :dealer
    game_data[:dealer][:score] += 1
  elsif winner == :dealer_busted || winner == :player
    game_data[:player][:score] += 1
  end
end

def compare_cards(game_data)
  prompt_pause "Both players have stayed."
  puts ""
  puts "======== DEALER ========"
  display_player_cards(game_data[:dealer][:hand])
  puts ""
  puts "======== PLAYER ========"
  display_player_cards(game_data[:player][:hand])
  puts ""
  prompt_pause "Dealer has #{game_data[:dealer][:total]}."
  prompt_pause "You have #{game_data[:player][:total]}."
end

def winning_message(winner)
  case winner
  when :player_busted then "Player busted. Dealer wins!"
  when :dealer_busted then "Dealer busted. You win!"
  when :player        then "Player has more points. You win!"
  when :dealer        then "Dealer has more points. Dealer wins!"
  when :tie           then "It's a tie!"
  end
end

def display_winner(game_data, winner)
  unless busted?(game_data[:player][:total]) ||
         busted?(game_data[:dealer][:total])
    compare_cards(game_data)
  end

  prompt_pause winning_message(winner), 2
end

def game_over(game_data)
  winner = game_result(game_data)
  increase_score!(game_data, winner)
  display_winner(game_data, winner)
end

def play_again?(message)
  answer = nil
  loop do
    prompt_pause "Would you like to #{message}? ('y' or 'n')"
    answer = gets.chomp.downcase.strip
    break if %w(y n).include?(answer)
    prompt_pause "Invalid input. Please enter 'y' or 'n'."
  end

  answer == 'y'
end

def display_tournament_winner(game_data)
  if game_data[:player][:score] > game_data[:dealer][:score]
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

def quit_game
  display_goodbye
  exit
end

display_welcome

loop do
  game_data = { player: { hand: nil,
                          total: nil,
                          score: 0 },
                dealer: { hand: nil,
                          total: nil,
                          score: 0 } }

  loop do
    deck = initialize_deck
    deal_person_in!(game_data, :player, deck)
    deal_person_in!(game_data, :dealer, deck)

    play_single_round(game_data, deck)

    game_over(game_data)
    break if game_data.values.any? { |val| val[:score] >= ROUNDS_TO_WIN }
    quit_game unless play_again?("keep playing")
  end

  display_tournament_winner(game_data)

  break unless play_again?("play another tournament")
end

display_goodbye
