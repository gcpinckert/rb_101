VALID_CHOICES = { 'r' => 'rock',
                  'p' => 'paper',
                  's' => 'scissors',
                  'l' => 'lizard',
                  'sp' => 'spock' }

def clear_screen
  system('clear') || system('cls')
end

def prompt(message)
  puts ">> #{message}"
end

def display_welcome
  clear_screen
  prompt "It's time to play #{VALID_CHOICES.values.join(' ').upcase}!"
end

def get_player_choice
  loop do
    prompt "Choose one: #{VALID_CHOICES.values.join(', ')}"
    VALID_CHOICES.each do |abbreviation, full_name|
      prompt "To choose #{full_name.upcase} enter '#{abbreviation}'"
    end
    choice = gets.chomp.downcase

    if VALID_CHOICES.keys.include?(choice) 
      return VALID_CHOICES[choice]
    else
      prompt "That's not a valid choice."
    end
  end
end

def display_choices(choice1, choice2)
  prompt "You chose: #{choice1}"
  prompt "Computer chose: #{choice2}"
end

def win?(player1, player2)
  winning_moves = { scissors: %w(paper lizard),
                    rock: %w(lizard scissors),
                    paper: %w(rock spock),
                    lizard: %w(paper spock),
                    spock: %w(rock scissors) }
  key = player1.to_sym
  winning_moves[key].include?(player2)
end

def display_result(player, computer)
  if win?(player, computer)
    prompt "You won!"
  elsif win?(computer, player)
    prompt "Computer won!"
  else
    prompt "It's a tie!"
  end
end

def calc_player_score(player_move, computer_move, player_score)
  if win?(player_move, computer_move)
    player_score += 1
  end
  player_score
end

def calc_computer_score(computer_move, player_move, computer_score)
  if win?(computer_move, player_move)
    computer_score += 1
  end
  computer_score
end

def display_score(player_score, computer_score)
  prompt "You: #{player_score} Computer: #{computer_score}"
end

def play_again?
  prompt "Do you want to play again? (Enter 'y' to keep playing)"
  answer = gets.chomp
  answer.downcase == 'y'
end

def display_goodbye
  prompt "Thank you for playing. Goodbye!"
end

display_welcome

player_score = 0
computer_score = 0

loop do
  player_choice = get_player_choice
  computer_choice = VALID_CHOICES.values.sample

  display_choices(player_choice, computer_choice)
  display_result(player_choice, computer_choice)

  player_score = calc_player_score(player_choice, computer_choice, player_score)
  computer_score = calc_computer_score(computer_choice, player_choice, computer_score)
  display_score(player_score, computer_score)

  break unless play_again?
  clear_screen
end

display_goodbye
