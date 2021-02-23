# What is the result of the last line in the given code?

greetings = { a: 'hi' }
informal_greeting = greetings[:a] # => 'hi'
informal_greeting << ' there'     # => 'hi there'

# << mutates the caller
# informal_greeting => 'hi there'
# greetings[:a] => 'hi there'
# Because both variables reference the same object in memory

puts informal_greeting  #  => "hi there"
puts greetings          # => {:a => "hi there"}

# NOTE: to modify informal_greeting without changing greetings hash:
# create a reference to a new object containing the same value
  # informal_greeting = greetings[:a].clone
# or use string concatenation, which returns a new string
  # informal_greeting += " there" (reassignment)
