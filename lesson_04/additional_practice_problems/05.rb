# Using the given array
# Find the index for the first name that starts with "Be"

# Input: array
# Output: string, an element from the array

# Solution 1:

# Set name_index equal to 0
# Iterate through the array
# If the element begins with 'Be'
  # Set that index number to name_index
# Otherwise
  # Continue to next iteration
# Return name_index

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
name_index = 0

flintstones.each_with_index do |name, index|
  if name.start_with?('Be')
    name_index = index
  end
end

puts name_index

# Solution 2:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

puts flintstones.index { |name| name.start_with?('Be') }