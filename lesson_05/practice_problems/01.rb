# Order the given array of numeric strings in descending number value


arr = ['10', '11', '9', '7', '8']

p arr.sort { |a, b| b.to_i <=> a.to_i }

