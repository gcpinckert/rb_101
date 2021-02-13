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

def win?(first, second)
  winning_moves = { scissors: %w(paper lizard),
                    rock: %w(lizard scissors),
                    paper: %w(rock spock),
                    lizard: %w(paper spock),
                    spock: %w(rock scissors) }
  key = first.to_sym
  winning_moves[key].include?(second)
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

def play_again?
  prompt "Do you want to play again? (Enter 'y' to keep playing)"
  answer = gets.chomp
  answer.downcase == 'y'
end

def display_goodbye
  prompt "Thank you for playing. Goodbye!"
end

display_welcome

loop do
  player_choice = get_player_choice
  computer_choice = VALID_CHOICES.values.sample

  display_choices(player_choice, computer_choice)
  display_result(player_choice, computer_choice)

  break unless play_again?
  clear_screen
end

display_goodbye
