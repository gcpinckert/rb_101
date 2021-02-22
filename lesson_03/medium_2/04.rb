# Here we are able to modify a string but not an array
# What happens to the string and array variable when passed to the method?

def tricky_method_two(a_string_param, an_array_param)
  a_string_param << 'rutabaga'
  # << mutates the caller, so the original object is modified
  an_array_param = ['pumpkins', 'rutabaga']
  # reassignment breaks the link between an_array_param the the object referenced
  # by my_array, so the changes will not be reflected outside the method
end

my_string = "pumpkins"
my_array = ["pumpkins"]
tricky_method_two(my_string, my_array)

puts "My string looks like this now: #{my_string}"
puts "My array looks like this now: #{my_array}"

=begin 
When the value assigned to my_string is passed to tricky_method_two
it is passing a copy of the reference for the object pointed to by
my_string ("pumpkins") to a_string_param. Therefore, a_string_param has 
access to the original object. Because we use << on that object, which 
mutates the caller, the original object is modified, and this change is 
reflected when we print my_string after the method, now the object 
"pumpkinsrutabaga", because my_string still points to the same address 
in memory.

When the value assigned to my_array is passed to tricky_method_two
it is passing a copy of the reference for the object pointed to by
my_array (['pumpkins']) to an_array_param. However, that link is severed in
line 7 when we re-assign an_array_param, which creates a new object (with
a new object id), that of ['pumpkins', 'rutabaga']. Now an_array_param and
my_array are pointing to two separate objects in memory, and any changes
made to an_array_param will not be reflected in my_array. Therefore, when
we print my_array, we will print the original object unmodified, ['pumpkins'].
=end