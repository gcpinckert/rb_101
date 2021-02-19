# Use spaces to align the given text on the screen
# Assume a 40 character wide table

title = "Flintstone Family Members"

# Set width of table
# Define width of title
# Subtract width of title from width of table
# Divide remaining width by 2
# Add the dividend number of spaces to the front and end of the given title

width = 40
spaces_to_add = (width - title.length) / 2

spaces = ''
spaces_to_add.times { spaces << ' ' }

title.prepend(spaces).concat(spaces)

puts title

# Or, more easily with a method:

title = "Flintstone Family Members"
puts title.center(40)