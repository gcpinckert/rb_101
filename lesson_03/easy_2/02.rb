# Convert the given string in the following ways:
# Expected output:
  # => "tHE mUNSTERS ARE CREEPY IN A GOOD WAY."
  # => "The munsters are creepy in a good way."
  # => "the munsters are creepy in a good way."
  # => "THE MUNSTERS ARE CREEPY IN A GOOD WAY."

munsters_description = "The Munsters are creepy in a good way."

munsters_description.swapcase!
puts munsters_description

munsters_description.capitalize!
puts munsters_description

munsters_description.downcase!
puts munsters_description

munsters_description.upcase!
puts munsters_description
