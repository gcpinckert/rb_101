# Amend the given array
# Each name should be shortened to just 3 characters

# Questions: 
#  - Change original calling array or return new array? 
#  - assume change the original calling array

# Solution 1:

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones.map! { |name| name[0, 3] }

p flintstones
