INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]]              # diagonals

def prompt_pause(msg)
  puts "=> #{msg}"
  sleep(1.5)
end

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
def display_welcome
  loop do
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
    prompt_pause "The first player to win five games achieves ultimate victory."
    prompt_pause "Are you ready to save humanity from the tyranny of the O's?"
    prompt_pause "Enter 'y' to begin!"
    answer = gets.chomp.downcase
    break if answer == 'y'
  end
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

# rubocop:disable Metrics/AbcSize, Metrics/MethodLength
def display_board(brd, scores)
  system 'clear'
  puts "You are #{PLAYER_MARKER}. Tic-Tac-Toeminator is #{COMPUTER_MARKER}."
  puts "Score: You - #{scores['Player']}" \
       " Tic-Tac-Toeminator - #{scores['Tic-Tac-Toeminator']}"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

# Generates hash in which key is a integer representing square on the board
# Value tells what to display in the board when output (X, O, or blank square)
def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
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

# Player's turn
def player_places_piece!(brd)
  square = ''
  loop do
    prompt_pause "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    if empty_squares(brd).include?(square)
      break
    else
      prompt_pause "Sorry, that's not a valid choice"
    end
  end

  brd[square] = PLAYER_MARKER
end

# Computer's turn:
def computer_places_piece!(brd)
  square = nil

  # Defensive move if necessary
  WINNING_LINES.each do |line|
    square = defensive_computer_move(line, brd)
    break if square
  end

  # Random move if defense not necessary
  if !square # i.e. if square still references `nil`
    square = empty_squares(brd).sample
  end

  brd[square] = COMPUTER_MARKER
end

def defensive_computer_move(line, brd)
  if brd.values_at(*line).count(PLAYER_MARKER) == 2 &&
     brd.values_at(*line).count(INITIAL_MARKER) == 1
    line.find { |sq| brd[sq] == INITIAL_MARKER }
  end
end

# Determines if there is a tie
def board_full?(brd)
  empty_squares(brd).empty?
end

# Determines if the game is over
def someone_won?(brd)
  !!detect_winner(brd) # If there is a winner, true, if nil, false
end

# Determines who the winner is, if any
def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return "Player"
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return "Tic-Tac-Toeminator"
    end
  end

  nil
end

def turn_cycle(brd, scores)
  loop do
    display_board(brd, scores)
    player_places_piece!(brd)
    break if someone_won?(brd) || board_full?(brd)
    computer_places_piece!(brd)
    break if someone_won?(brd) || board_full?(brd)
  end

  display_board(brd, scores)
end

def game_over(brd, scores)
  if someone_won?(brd)
    scores[detect_winner(brd)] += 1
    prompt_pause "#{detect_winner(brd)} won!"
  else
    prompt_pause "It's a tie!"
  end
  prompt_pause "Score is now: Player - #{scores['Player']}" \
               " Tic-Tac-Toeminator - #{scores['Tic-Tac-Toeminator']}."
end

def play_game(scores)
  loop do
    board = initialize_board

    turn_cycle(board, scores)
    game_over(board, scores)

    break if tournament_over?(scores)
  end
end

def tournament_over?(scores)
  scores["Player"] >= 5 || scores["Tic-Tac-Toeminator"] >= 5
end

def play_tournament
  loop do
    scores = { "Player" => 0, "Tic-Tac-Toeminator" => 0 }
    play_game(scores)

    display_tournament_winner(scores)

    prompt_pause "Play again? (y or n)"
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
  end
end

# rubocop:disable Metrics/MethodLength
def display_tournament_winner(scores)
  system 'clear'
  puts ""
  if scores["Player"] < scores["Tic-Tac-Toeminator"]
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
