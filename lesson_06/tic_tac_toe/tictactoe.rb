INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # columns
                [[1, 5, 9], [3, 5, 7]]              # diagonals

def prompt(msg)
  puts "=> #{msg}"
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
    prompt "Welcome to Tic Tac Toe!"
    prompt "Your goal: beat the Tic-Tac-Toeminator."
    prompt "Get three X's in a row, horizontal, vertical, or diagonal."
    prompt "Are you ready to save humanity from the tyranny of the O's?"
    prompt "Enter 'y' to begin!"
    answer = gets.chomp.downcase
    break if answer == 'y'
  end
end
# rubocop:enable Metrics/AbcSize, Metrics/MethodLength

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You are #{PLAYER_MARKER}. Tic-Tac-Toeminator is #{COMPUTER_MARKER}."
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
# rubocop:enable Metrics/AbcSize

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
    prompt "Choose a square (#{joinor(empty_squares(brd))}):"
    square = gets.chomp.to_i
    if empty_squares(brd).include?(square)
      break
    else
      prompt "Sorry, that's not a valid choice"
    end
  end

  brd[square] = PLAYER_MARKER
end

# Computer's turn: random
def computer_places_piece!(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
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
      return "You"
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return "Tic-Tac-Toeminator"
    end
  end

  nil
end

def turn_cycle(brd)
  loop do
    display_board(brd)
    player_places_piece!(brd)
    break if someone_won?(brd) || board_full?(brd)
    computer_places_piece!(brd)
    break if someone_won?(brd) || board_full?(brd)
  end

  display_board(brd)
end

def game_over(brd)
  if someone_won?(brd)
    prompt "#{detect_winner(brd)} won!"
  else
    prompt "It's a tie!"
  end
end

def play_game
  loop do
    board = initialize_board

    turn_cycle(board)
    game_over(board)

    prompt "Play again? (y or n)"
    answer = gets.chomp
    break unless answer.downcase.start_with?('y')
  end
end

def display_goodbye
  prompt "Thanks, hero, for your daring deeds!"
  prompt "Goodbye until the Tic-Tac-Toeminator strikes again!"
end

display_welcome
play_game
display_goodbye
