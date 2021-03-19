# Using the each method:
# Output all the vowels from the strings in the given hash

hsh = {first: ['the', 'quick'], 
       second: ['brown', 'fox'], 
       third: ['jumped'], 
       fourth: ['over', 'the', 'lazy', 'dog']}

# iterate through the given hash, for each entry:
  # iterate through the array values, for each string:
    # convert the string to an array of characters
    # iterate through the array of characters, for each character
      # if it is a vowel
        # print to the console

hsh.each do |__, words|
  words.each do |word|
    word.chars.each do |char|
      if ['a', 'e', 'i', 'o', 'u'].include?(char.downcase)
        puts char
      end
    end
  end
end
