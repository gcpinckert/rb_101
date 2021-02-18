# Replace the word "important" with "urgent" in the given string.

advice = "Few things in life are as important as house training your pet dinosaur."

# split the given string into an array of words
# iterate through each word in the array
  # Check each word to see if it is equal to the word "important"
  # If the word is equal to the word "important":
    # Replace that word with the word "urgent"
  # Otherwise
    # Go to the next word in the string
# Join the array of words back together into a string

puts "String before change: #{advice}"

words = advice.split(' ')

words.each_with_index do |word, index|
  if word == "important"
    words[index] = "urgent"
  end
end

advice = words.join(' ')

puts "String after change: #{advice}"

# This can be accomplished more simply with the String#gsub! method:

advice = "Few things in life are as important as house training your pet dinosaur."

advice.gsub!('important', 'urgent')