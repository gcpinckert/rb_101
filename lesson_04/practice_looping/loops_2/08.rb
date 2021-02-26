# - Using next, modify the code so it only prints even numbers

number = 0

until number == 10
  number += 1
  next if number.odd?
  puts number
end