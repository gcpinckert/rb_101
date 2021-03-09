# Write a method that creates a string in which each word is capitalized

# Examples:
# input: words = "the flintstones rock"
# output: words = "The Flintstones Rock"

def titleize(title)
  words = title.split
  words.map! { |word| word.capitalize }
  words.join(' ')
end

puts titleize('the flintstones rock')
puts titleize('great expectations')
puts titleize('ulysses')
