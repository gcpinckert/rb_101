# What does the given code output?

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.shift(1)
end

# The code will output 1, 3 and return the array [3, 4]
# This is because we are shortening the array as we go, and the loop counter
# resets against the new length after each iteration. So on the first iteration
# the element selected is `1` at index 0. But because we remove that element,
# the next value `2` is shifted into the place at index 0. Because the loop
# counter is now at 1, it selects the element `3` at that index, and 2 is
# passed over. Similarly with 4. 

# What does the given code output?

numbers = [1, 2, 3, 4]
numbers.each do |number|
  p number
  numbers.pop(1)
end

# The code will output 1, 2, and return the array [1, 2]
# This is a similar problem to the one above, except we are removing items from
# the end of the array. Therefore, the loop will end before we get to those
# elements in the array. 

# The lesson here is that iterators work on the original array and make
# changes to it in real time.