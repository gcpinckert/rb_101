# Both a string and an array are passed as arguments into a method
# Though they are treated the same way the results are different
# What will be displayed from the given code? Why?

def tricky_method(a_string_param, an_array_param)
  a_string_param += "rutabaga"
  # Reassignment, severs link with originally passed string variable
  an_array_param << "rutabaga"
  # Concatenation mutates the caller, does not sever link with original value
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method(my_string, my_array)

# After the method call, my_string will still be "pumpkins". This is because
# the reference to the object "pumpkins" is passed into the method and assigned
# to the variable a_string_param. But this link is severed in line 7 due to the
# reassignment statement, which creates a new object, "pumpkinsrutabaga", and
# new object id that get assigned to the variable a_string_param. This does
# not affect the value referenced by the my_string variable, which still points
# to the original "pumpkins" object

# After the method call, my_array will be modified to ['pumpkins', 'rutabaga']
# because the concatenation operator (<<) mutates the caller. So when the
# reference to the original object (['pumpkins']) is passed to the variable
# an_array_param, the link is never severed, and the object id remains the same
# The original object, therefore, is modified, which is reflected when we
# output the value of the variable outside the method.

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"