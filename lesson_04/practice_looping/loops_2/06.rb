# - Given an array of names
# - Use loop to remove and print each name
# - Stop the loop once names is empty

names = ['Sally', 'Joe', 'Lisa', 'Henry']

loop do
  puts names.pop
  break if names.size == 0
end