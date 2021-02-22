# Remove the unnecessary duplication in the given code:

def color_valid?(color)
  color == 'blue' || color == 'green'
end

# relies on implicit return of last evaluated statement
puts color_valid? "red"   # => false
puts color_valid? "blue"  # => true
puts color_valid? "green" # => true
puts color_valid? "purple"# => false