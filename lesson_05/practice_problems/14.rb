# Using the given data structure:
  # Return an array
  # The array should contain the colors of the fruits and the size of the veggies
  # The sizes should be uppercase
  # The colors should be capitalized

hsh = {
  'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
  'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
  'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
  'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
  'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
}

# Expected Output:
# => [["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"]

# Initialize an empty array
# Iterate through the top level hash, for each value entry:
  # If the type is 'fruit'
    # Iterate through the colors value array, for each color
      # Capitalize the string (transformation)
    # Add the new array to the empty array
  # Else
    # Uppercase the size string value
    # Add it to the empty array
# Return the empty array (not empty anymore)

def mess_with_hsh(hsh)
  array = []

  hsh.each_value do |details_hsh|
    if details_hsh[:type] == 'fruit'
      array << details_hsh[:colors].map { |color| color.capitalize }
    else
      array << details_hsh[:size].upcase
    end
  end

  array
end

puts mess_with_hsh(hsh) == [["Red", "Green"], "MEDIUM", ["Red", "Green"], ["Orange"], "LARGE"]
