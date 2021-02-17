VALID_CHOICES = { 'r' => 'rock',
                  'p' => 'paper',
                  'sc' => 'scissors',
                  'l' => 'lizard',
                  'sp' => 'spock' }

GOAL_WINS = 5

def clear_screen
  system('clear') || system('cls')
end

def prompt(message)
  puts ">> #{message}"
end

def display_welcome
  clear_screen
  prompt "It's time to play #{VALID_CHOICES.values.join(' ').upcase}!"
  prompt "The first player to reach #{GOAL_WINS.to_s} wins is Grand Champion!"
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

def display_choices(choices)
  choices.each { |name, choice| prompt "#{name.capitalize} chose: #{choice}" }
end

def win?(player1, player2)
  winning_moves = { scissors: %w(paper lizard),
                    rock: %w(lizard scissors),
                    paper: %w(rock spock),
                    lizard: %w(paper spock),
                    spock: %w(rock scissors) }
  winning_moves[player1.to_sym].include?(player2)
end

def display_result(choices)
  if win?(choices[:player], choices[:computer])
    prompt "You won!"
  elsif win?(choices[:computer], choices[:player])
    prompt "Computer won!"
  else
    prompt "It's a tie!"
  end
  sleep(2)
  clear_screen
end

def calc_player_score(choices, scores)
  if win?(choices[:player], choices[:computer])
    scores[:player] += 1
  end
  scores[:player]
end

def calc_computer_score(choices, scores)
  if win?(choices[:computer], choices[:player])
    scores[:computer] += 1
  end
  scores[:computer]
end

def display_score(scores)
  prompt "You: #{scores[:player]} Computer: #{scores[:computer]}"
end

def tournament_over?(scores)
  scores[:player] == GOAL_WINS || scores[:computer] == GOAL_WINS
end

def display_winner(scores)
  if scores[:player] > scores[:computer]
    prompt "Congratulations! You beat the computer! You are Grand Champion!"
  else
    prompt "Awww, Computer has beat you. Computer is the Grand Champion!"
  end
end

def play_again?
  loop do
    prompt "Do you want to play again? (Enter 'y' to keep playing, 'n' to quit)"
    answer = gets.chomp
    if ['y', 'n'].include?(answer.downcase)
      return answer.downcase == 'y'
    else
      prompt "I'm sorry that's not a valid input. Please enter 'y' or 'n'."
    end
  end
end

def display_goodbye
  prompt "Thank you for playing. Goodbye!"
end

display_welcome

scores = {player: 0, computer: 0}
choices = {player: '', computer: ''}

loop do
  choices[:player] = get_player_choice
  choices[:computer] = VALID_CHOICES.values.sample

  clear_screen

  display_choices(choices)
  display_result(choices)

  scores[:player] = calc_player_score(choices, scores)
  scores[:computer] = calc_computer_score(choices, scores)
  display_score(scores)

  next unless tournament_over?(scores)
  display_winner(scores)

  break unless play_again?
  scores = {player: 0, computer: 0}
  clear_screen
end

display_goodbye
