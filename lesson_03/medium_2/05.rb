# Make the given code easier to predict and maintain

# Given code:
# This method will mutate one of it's arguments

# def tricky_method(a_string_param, an_array_param)
#   a_string_param += "rutabaga"
#   an_array_param << "rutabaga"
# end

# my_string = "pumpkins"
# my_array = ["pumpkins"]
# tricky_method(my_string, my_array)

# puts "My string looks like this now: #{my_string}"
# puts "My array looks like this now: #{my_array}"

# The following method will not mutate it's arguments,
# Making results easier to predict

def better_method(string, array)
  string += 'rutabaga'
  array += ['rutabaga']
end

my_string = 'pumpkins'
my_array = ['pumpkins']
better_method(my_string, my_array)

puts "My string after the method: #{my_string}"
puts "My array after the method: #{my_array}"