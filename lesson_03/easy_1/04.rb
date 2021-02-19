# What do the following method calls do?

numbers = [1, 2, 3, 4, 5]
numbers.delete_at(1)

# The above method will delete the element found at numbers[1] (per the 
# argument passed to it) and return the deleted element. It mutates the caller,
# so the array numbers will now be [1, 3, 4, 5]

numbers = [1, 2, 3, 4, 5]
numbers.delete(1)

# The above method will delete the element equal to the argument passed to it, 
# aka the integer 1, and return that value. The method mutates the caller, so
# the array numbers will now have the value [2, 3, 4, 5]
