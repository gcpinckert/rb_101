# The given code intends to show all the factors of an input number
# It will fail if the input is 0 or a negative number
# Make the code work without using begin / end / until
# Handle 0 and negative numbers gracefully

def factors(number)
  divisor = number
  factors = []
  while divisor > 0 do
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end
  factors
end

p factors(6)
p factors(12)
p factors(0)
p factors(-1)

# Bonus 1:
# number % divisor == 0 determines if the divisor can be divided into the
# input number evenly, to see whether or not it is a factor of the input
# if it divides evenly, it is added to the factors array, and if not, we
# move on to the next decrementation of number. 

# Bonus 2:
# Because a while loop always returns `nil`, we need to supply the factors
# array to take advantage of Ruby's implicit return for the method. Otherwise
# the method will return nil.