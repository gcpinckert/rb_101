# - Modify the given code so the loop stops iterating when the user inputs 'yes'

# Input: a string, user_input
# Output: string "Should I stop looping?"

# - Unless user_input is 'yes'
#   - Print "should I stop looping?"

answer = ''
until answer == 'yes'
  puts 'Should I stop looping?'
  answer = gets.chomp.downcase
end