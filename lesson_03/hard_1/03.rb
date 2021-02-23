# Determine what will be printed with each set of given code:

# A)

def mess_with_vars(one, two, three)
  one = two
  two = three
  three = one
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"       # => "one is: one" 
puts "two is: #{two}"       # => "two is: two"
puts "three is: #{three}"   # => "three is: three"

# Here, all variables one, two, and three outside the method will retain
# their original values ("one", "two", "three" respectively). This is
# because reassignment within the method breaks the link between the 
# separate variable (one, two, three) and its reference to the original
# value of the variable outside the method. Any changes made after this
# link is broken will not be reflected in the value of the original
# variables.

# B)

def mess_with_vars(one, two, three)
  one = "two"
  two = "three"
  three = "one"
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"     # => "one is: one"
puts "two is: #{two}"     # => "two is: two"
puts "three is: #{three}" # => "three is: three"

# The variables one, two, three outside the method will retain their
# original values here, for the same reasons listed above. Reassignment
# within the method does not mutate the original object, and is therefore
# not reflected outside the method. Here, the new variables one, two, three
# inside the method are reassigned to a newly created string object.

# C)

def mess_with_vars(one, two, three)
  one.gsub!("one","two")
  two.gsub!("two","three")
  three.gsub!("three","one")
end

one = "one"
two = "two"
three = "three"

mess_with_vars(one, two, three)

puts "one is: #{one}"     # => "one is: two"
puts "two is: #{two}"     # => "two is: three"
puts "three is: #{three}" # => "three is: one"

# Here we are using a method that mutates the caller on the values passed
# into the mess_with_vars method. Because copies of the reference to the 
# original object are passed into the method as arguments, the method has
# access to the same object that variables one, two, and three still point
# to outside the method. Therefore, when we modify this object with .gsub!
# we will see that modification reflected outside the method. The link
# between the variables inside the method and the original object is never
# broken as it would be with re-assignment or a non-mutating method.
