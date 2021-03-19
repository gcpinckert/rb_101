# Write a method that returns one UUID when called 
  # The method should not have any parameters
  # An UUID is a string
  # Takes the following format 8chars-4chars-4chars-4chars-12chars
  # The chars should be within the range of 32 hexadecimal characters
    # 0-9, a-f (lowercase)
  # The characters in the string should be randomly generated

# Example:
  # "f65c57f6-a6aa-17a8-faa1-a67f2dc9fa91"

# Input: none
# Output: string, see above rules

# Initialize an empty string
# Iterate a loop 8 times
  # Generate a random hexadecimal character
  # Append it to the string
# Append a dash to the string
# Iterate a loop 3 times
  # Iterate a loop 4 times
    # Generate a random hexadecimal character
    # Append it to the string
  # Append a dash to the string
# Iterate a loop 12 times
  # Generate a random hexadecimal character
  # Append it to the string
# Return the string

def create_uuid
  uuid = ""
  sections = [8, 4, 4, 4, 12]

  sections.each_with_index do |section, index|
    section.times { uuid << rand(0..15).to_s(16) }
    uuid << "-" if index < sections.size - 1
  end

  uuid
end

3.times { puts create_uuid }
