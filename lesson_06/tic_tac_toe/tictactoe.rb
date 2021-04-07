PLAYER = 'Player'
COMPUTER = 'Tic-Tac-Toeminator'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'

GAMES_TO_WIN = 5
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]]              # diagonals

def prompt_pause(msg)
  puts "=> #{msg}"
  sleep(1.5)
end

def valid_input
  answer = nil

  loop do
    answer = gets.chomp.downcase.strip
    break if ['y', 'yes', 'n', 'no'].include?(answer)
    prompt_pause "Invalid input. Please enter 'y' or 'n'."
  end

  answer == 'y' || answer == 'yes' ? 'y' : 'n'
end

def quit_game
  display_goodbye
  exit
end

# rubocop:disable Metrics/MethodLength
def display_welcome
  system 'clear'
  puts ""
  puts " _____ _        _____            _____"
  puts "|_   _(_) ___  |_   _|_ _  ___  |_   _|__   ___"
  puts "  | | | |/ __|   | |/ _` |/ __|   | |/ _ \\ / _ \\"
  puts "  | | | | (__    | | (_| | (__    | | (_) |  __/"
  puts "  |_| |_|\\___|   |_|\\__,_|\\___|   |_|\\___/ \\___|"
  puts ""
  puts ""
  prompt_pause "Welcome to Tic Tac Toe!"
  prompt_pause "Your goal: beat the Tic-Tac-Toeminator."
  prompt_pause "Get three X's in a row, horizontal, vertical, or diagonal."
  prompt_pause "The first player to win #{GAMES_TO_WIN} games achieves " \
               "ultimate victory."
  prompt_pause "Are you ready to save humanity from the tyranny of the O's?!"
  prompt_pause "Enter 'y' to begin or 'n' to exit."
  answer = valid_input
  quit_game if answer == 'n'
end
# rubocop:enable Metrics/MethodLength

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
def display_board(brd, scores)
  system 'clear'
  puts "You are #{PLAYER_MARKER}. Tic-Tac-Toeminator is #{COMPUTER_MARKER}."
  puts "Score: You - #{scores[PLAYER]}" \
       " Tic-Tac-Toeminator - #{scores[COMPUTER]}"
  puts ""
  puts " (1)   (2)   (3)"
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts " (4)   (5)   (6)"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts " (7)   (8)   (9)"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

# Generates hash in which key is an integer representing square on the board
# Value tells what to display in the board when output (X, O, or blank square)
def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def ask_first_turn
  answer = nil

  loop do
    prompt_pause "Who should go first? Enter 'p' for #{PLAYER}" \
                  " or 't' for #{COMPUTER}"
    answer = gets.chomp.downcase
    break if ['p', 't'].include?(answer)
    prompt_pause "Sorry, that's not a valid choice. Please enter 'p' or 't'."
  end

  answer == 'p' ? PLAYER : COMPUTER
end

def alternate_first_turn(first_turn)
  first_turn == PLAYER ? COMPUTER : PLAYER
end

# Returns an array of integers representing available moves
def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITIAL_MARKER }
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

def player_places_piece!(brd)
  square = ''
  loop do
    prompt_pause "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp
    if empty_squares(brd).include?(square.to_i) && square.to_i.to_s == square
      break
    else
      prompt_pause "Sorry, that's not a valid choice."
    end
  end

  brd[square.to_i] = PLAYER_MARKER
end

def computer_places_piece!(brd)
  square = nil

  # Winning move if available
  WINNING_LINES.each do |line|
    break if square
    square = aggressive_computer_move(line, brd, COMPUTER_MARKER)
  end

  # Blocking move if available
  WINNING_LINES.each do |line|
    break if square
    square = aggressive_computer_move(line, brd, PLAYER_MARKER)
  end

  # Square 5 or random move if other moves not available
  if !square
    square = (brd[5] == INITIAL_MARKER ? 5 : empty_squares(brd).sample)
  end

  brd[square] = COMPUTER_MARKER
end

def aggressive_computer_move(line, brd, marker)
  if brd.values_at(*line).count(marker) == 2 &&
     brd.values_at(*line).count(INITIAL_MARKER) == 1
    line.find { |sq| brd[sq] == INITIAL_MARKER }
  end
end

def place_piece!(brd, player)
  player_places_piece!(brd) if player == PLAYER
  computer_places_piece!(brd) if player == COMPUTER
end

def alternate_player(player)
  return COMPUTER if player == PLAYER
  return PLAYER if player == COMPUTER
end

def turn_cycle(brd, scores, first_turn)
  current_player = first_turn

  loop do
    display_board(brd, scores)
    place_piece!(brd, current_player)
    current_player = alternate_player(current_player)
    break if someone_won?(brd) || board_full?(brd)
  end

  display_board(brd, scores)
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def someone_won?(brd)
  !!detect_winner(brd) # If there is a winner, true, if nil, false
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return PLAYER
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return COMPUTER
    end
  end

  nil
end

def update_score!(brd, scores)
  scores[detect_winner(brd)] += 1
end

def game_over(brd, scores)
  if someone_won?(brd)
    update_score!(brd, scores)
    prompt_pause "#{detect_winner(brd)} won!"
  else
    prompt_pause "It's a tie!"
  end
  prompt_pause "Score is now: #{PLAYER} - #{scores[PLAYER]} " \
               "#{COMPUTER} - #{scores[COMPUTER]}."
end

def play_game(scores, first_turn)
  loop do
    board = initialize_board

    turn_cycle(board, scores, first_turn)
    game_over(board, scores)
    keep_playing? unless tournament_over?(scores)

    first_turn = alternate_first_turn(first_turn)

    break if tournament_over?(scores)
  end
end

def keep_playing?
  prompt_pause "Would you like to keep playing? Enter 'y' or 'n'."
  answer = valid_input
  quit_game if answer == 'n'
end

def tournament_over?(scores)
  scores[PLAYER] >= GAMES_TO_WIN || scores[COMPUTER] >= GAMES_TO_WIN
end

def play_tournament
  loop do
    scores = { PLAYER => 0, COMPUTER => 0 }
    first_turn = ask_first_turn

    play_game(scores, first_turn)
    display_tournament_winner(scores)

    prompt_pause "Would you like to play again? Enter 'y' or 'n'."
    answer = valid_input

    break if answer == 'n'
  end
end

# rubocop:disable Metrics/MethodLength
def display_tournament_winner(scores)
  system 'clear'
  puts ""
  if scores[PLAYER] < scores[COMPUTER]
    puts "  ____                         ___"
    puts " / ___| __ _ _ __ ___   ___   / _ \\__   _____ _ __"
    puts "| |  _ / _` | '_ ` _ \\ / _ \\ | | | \\ \\ / / _ \\ '__|"
    puts "| |_| | (_| | | | | | |  __/ | |_| |\\ V /  __/ |"
    puts " \\____|\\__,_|_| |_| |_|\\___|  \\___/  \\_/ \\___|_|"
  else
    puts "__   __           __        ___       _"
    puts "\\ \\ / /__  _   _  \\ \\      / (_)_ __ | |"
    puts " \\ V / _ \\| | | |  \\ \\ /\\ / /| | '_ \\| |"
    puts "  | | (_) | |_| |   \\ V  V / | | | | |_|"
    puts "  |_|\\___/ \\__,_|    \\_/\\_/  |_|_| |_(_)"
  end
  puts ""
end
# rubocop: enable Metrics/MethodLength

def display_goodbye
  prompt_pause "Thanks hero, for your daring deeds!"
  prompt_pause "Goodbye until the Tic-Tac-Toeminator strikes again!"
end

display_welcome
play_tournament
display_goodbye
