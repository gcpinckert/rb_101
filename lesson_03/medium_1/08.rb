# Method calls can take expressions as arguments
# Given the following code:
def rps(fist1, fist2)
  if fist1 == "rock"
    (fist2 == "paper") ? "paper" : "rock"
  elsif fist1 == "paper"
    (fist2 == "scissors") ? "scissors" : "paper"
  else
    (fist2 == "rock") ? "rock" : "scissors"
  end
end

# What will the method call output?
puts rps(rps(rps("rock", "paper"), rps("rock", "scissors")), "rock")

# The output will be paper:
# rps(rps(rps("rock", "paper"), rps("rock", "scissors")), "rock")
  # fist 1 = rps(rps("rock", "paper"), rps("rock", "scissors"))
  # fist 2 = rock
  # Evaluating fist 1:
    # fist 1 = rps('paper', 'rock')
    # fist 1 = paper
# Method call once evaluated: rps('paper', 'rock') => 'paper'