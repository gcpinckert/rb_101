# Predict how the values and object ids will change throughout the 
# flow of the given code:

def fun_with_ids
  a_outer = 42
  b_outer = "forty two"
  c_outer = [42]
  d_outer = c_outer[0]  #=> 42

  a_outer_id = a_outer.object_id  # => 85
  b_outer_id = b_outer.object_id  # => 260
  c_outer_id = c_outer.object_id  # => 280
  d_outer_id = d_outer.object_id  # => 85: RUby re-uses the object_id when the value is the same

  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} before the block."
  # => a_ outer is 42 with an id of: 85 before the block.
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} before the block."
  # => b_outer is forty two with an id of: 260 before the block.
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} before the block."
  # => c_outer is [42] with an id of: 280 before the block.
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} before the block."
  # => d_outer is 42 with an id of: 85 before the block.
  puts

  1.times do    # Creates an inner scope
    a_outer_inner_id = a_outer.object_id  # These variables initialized in inner scope
    b_outer_inner_id = b_outer.object_id
    c_outer_inner_id = c_outer.object_id
    d_outer_inner_id = d_outer.object_id

    # Object ids will not change for variables initialized in outer scope when moved to inner scope
    puts "a_outer id was #{a_outer_id} before the block and is: #{a_outer_inner_id} inside the block."
    # => a_outer_id = 85; a_outer_inner_id = 85
    puts "b_outer id was #{b_outer_id} before the block and is: #{b_outer_inner_id} inside the block."
    # => b_outer_id = 260; b_outer_inner_id = 260
    puts "c_outer id was #{c_outer_id} before the block and is: #{c_outer_inner_id} inside the block."
    # => c_outer_id = 280; c_outer_inner_id = 280
    puts "d_outer id was #{d_outer_id} before the block and is: #{d_outer_inner_id} inside the block."
    # => d_outer_id = 85; d_outer_inner_id = 85
    puts

    a_outer = 22              # All variables are reassigned in inner scope, creating new object_ids for each
    b_outer = "thirty three"
    c_outer = [44]
    d_outer = c_outer[0]

    puts "a_outer inside after reassignment is #{a_outer} with an id of: #{a_outer_id} before and: #{a_outer.object_id} after."
    # => a_outer = 22; a_outer_id = 85; a_outer.object_id => some new number
    puts "b_outer inside after reassignment is #{b_outer} with an id of: #{b_outer_id} before and: #{b_outer.object_id} after."
    # => b_outer = "thirty three"; b_outer_id = 260; b_outer.object_id => some new number
    puts "c_outer inside after reassignment is #{c_outer} with an id of: #{c_outer_id} before and: #{c_outer.object_id} after."
    # => c_outer = [44]; c_outer_object_id = 280; c_outer_object_id => some new number
    puts "d_outer inside after reassignment is #{d_outer} with an id of: #{d_outer_id} before and: #{d_outer.object_id} after."
    # => d_outer = 44; d_outer_object_id = 85; d_outer.object_id => some new number (not the same as a, not the same as c)
    puts

    # All these variables initialized in inner scope, and point to the same reference as the above variables
    a_inner = a_outer     # => 22
    b_inner = b_outer     # => "thirty three"
    c_inner = c_outer     # => [44]
    d_inner = c_inner[0]  # => 44

    # Because inner variables are all pointers to the same objects as the outer variables, the object_ids will be the same
    a_inner_id = a_inner.object_id
    b_inner_id = b_inner.object_id
    c_inner_id = c_inner.object_id
    d_inner_id = d_inner.object_id

    puts "a_inner is #{a_inner} with an id of: #{a_inner_id} inside the block (compared to #{a_outer.object_id} for outer)."
    # => a_inner_id will be the same as a_outer.object_id
    puts "b_inner is #{b_inner} with an id of: #{b_inner_id} inside the block (compared to #{b_outer.object_id} for outer)."
    # => b_inner_id will be the same as b_outer.object_id
    puts "c_inner is #{c_inner} with an id of: #{c_inner_id} inside the block (compared to #{c_outer.object_id} for outer)."
    # => c_inner_id will be the same as c_outer.object_id
    puts "d_inner is #{d_inner} with an id of: #{d_inner_id} inside the block (compared to #{d_outer.object_id} for outer)."
    # => d_inner_id will be the same as d_outer.object_id 
    puts
  end

  # These values will reflect the re-assignment in inner scope, because variables were initialized in outer scope
  # They will each have different object_ids BEFORE and AFTER the block
  puts "a_outer is #{a_outer} with an id of: #{a_outer_id} BEFORE and: #{a_outer.object_id} AFTER the block."
  puts "b_outer is #{b_outer} with an id of: #{b_outer_id} BEFORE and: #{b_outer.object_id} AFTER the block."
  puts "c_outer is #{c_outer} with an id of: #{c_outer_id} BEFORE and: #{c_outer.object_id} AFTER the block."
  puts "d_outer is #{d_outer} with an id of: #{d_outer_id} BEFORE and: #{d_outer.object_id} AFTER the block."
  puts

  # These will all print "ugh ohhhh" because varibles initialized in outer scope cannot be accessed in outer scope
  puts "a_inner is #{a_inner} with an id of: #{a_inner_id} INSIDE and: #{a_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "b_inner is #{b_inner} with an id of: #{b_inner_id} INSIDE and: #{b_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "c_inner is #{c_inner} with an id of: #{c_inner_id} INSIDE and: #{c_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
  puts "d_inner is #{d_inner} with an id of: #{d_inner_id} INSIDE and: #{d_inner.object_id} AFTER the block." rescue puts "ugh ohhhhh"
end