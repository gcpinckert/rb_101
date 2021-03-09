# Create a hash that expresses the frequency of each letter in the given string

# Example:
# { "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }

# Questions:
# - Case sensitive? yes, see example
# - Notice hash order:
#   - key-value pairs in order of frequency within string
#   - Alphabetical order within frequency groups

# Input: string
# Output: hash
#   each key is a character in the string
#   each value is the number of times that character appears in the string

# Solution 1:
# note: does not create hash in the correct order
# note: counts spaces as a letter

# Set an empty hash
# Extract all characters in the string to an array
# Iterate through each element in the array
#  - Create a new key in the hash for the current character
#  - Assign the number of times that character appears in the array as the value
# Return the hash

statement = "The Flintstones Rock"
frequency = {}
characters = statement.chars 

characters.each do |character|
  frequency[character] = characters.count(character)
end

p frequency

# Solution 2:

# Set empty hash variable
# Create array of all alphabetical characters
# Iterate through array of alphabetical characters
# - Find the amount of times the current letter appears in each substring
# - Assign that value to a variable
# - If the frequency is > 0
#   - Assign the letter and frequency as key value pairs in the hash
# Return the hash

statement = "The Flintstones Rock"
frequency = {}
alphabetical_characters = ('A'..'Z').to_a + ('a'..'z').to_a

alphabetical_characters.each do |letter|
  letter_frequency = statement.scan(letter).count
  frequency[letter] = letter_frequency if letter_frequency > 0
end

p frequency