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

def display_cards(hands, totals, score)
  clear_screen
  prompt_pause "SCORE You: #{score[:player]} Dealer: #{score[:dealer]}", 0
  puts ""
  puts "======== DEALER ========"
  display_dealer_cards(hands[:dealer])
  puts ""
  puts "======== PLAYER ========"
  display_player_cards(hands[:player])
  puts ""
  prompt_pause "Your current total is #{totals[:player]}.", 0
end

# ----- game play logic -----
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

def players_turn!(hands, totals, deck, score)
  loop do
    break if hit_or_stay?

    hands[:player] << deal_single_card!(deck)
    totals[:player] = calculate_hand_total(hands[:player])
    display_cards(hands, totals, score)

    break if busted?(totals[:player])
  end

  if busted?(totals[:player])
    prompt_pause "PLAYER BUSTS!", 2
  else
    prompt_pause "You chose to stay."
  end
end

def dealers_turn!(hands, totals, deck, score)
  loop do
    break if totals[:dealer] >= DEALER_STAYS
    prompt_pause "Dealer hits."
    card = deal_single_card!(deck)
    hands[:dealer] << card
    totals[:dealer] = calculate_hand_total(hands[:dealer])
    display_cards(hands, totals, score)
  end

  if busted?(totals[:dealer])
    prompt_pause "DEALER BUSTS!", 2
  else
    prompt_pause "Dealer stays."
  end
end

def play_single_round(hands, totals, deck, score)
  display_cards(hands, totals, score)

  players_turn!(hands, totals, deck, score)
  dealers_turn!(hands, totals, deck, score) unless busted?(totals[:player])
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

def compare_cards(totals, hands)
  prompt_pause "Both players have stayed."
  puts ""
  puts "======== DEALER ========"
  display_player_cards(hands[:dealer])
  puts ""
  puts "======== PLAYER ========"
  display_player_cards(hands[:player])
  puts ""
  prompt_pause "Dealer has #{totals[:dealer]}."
  prompt_pause "You have #{totals[:player]}."
end

def display_winner(totals, result, hands)
  unless busted?(totals[:player]) || busted?(totals[:dealer])
    compare_cards(totals, hands)
  end

  prompt_pause result, 2
end

def game_over(totals, score, hands)
  result = game_result!(totals, score)
  display_winner(totals, result, hands)
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

def quit_game
  display_goodbye
  exit
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

    game_over(totals, score, hands)
    break if score.values.include?(ROUNDS_TO_WIN)
    quit_game unless play_again?("keep playing")
  end

  display_tournament_winner(score)

  break unless play_again?("play another tournament")
end

display_goodbye
