# Show two different ways to add "Four score and " to the given string

# Option 1 - note this method mutates the caller

famous_words = "seven years ago..."
famous_words.prepend("Four score and ")
puts famous_words

# Option 2 - note this method mutates the caller

famous_words = "seven years ago..."
famous_words.insert(0, "Four score and ")
puts famous_words

# Using concatenation - note that these methods do NOT change the value of
# famous_words so we either have to output the return value right away or
# save it in a variable for use later.

# Option 3

famous_words = "seven years ago..."
puts "Four score and " + famous_words

# Option 4

puts "Four score and " << famous_words

# Though << does, in fact, mutate the caller, here it is mutating the String
# literal "Four score and ", not the value referenced by the variable
# famous_words, so we still have to either output the value right away or
# save it in a variable for later use.
