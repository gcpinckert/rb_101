# Programmatically determine if 42 lies between 10 and 100

number = 42

if (10..100).include?(number)
  puts "42 is in between 10 and 100"
else
  puts "Something went wrong"
end