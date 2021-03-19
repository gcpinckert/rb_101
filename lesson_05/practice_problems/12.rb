# Using the given data structure:
  # Return a hash
  # The key should be the first item in the sub-array
  # The value should be the second item in the sub-array
  # Do not use the to_h method

# Example:

arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]
# expected return value: {:a=>1, "b"=>"two", "sea"=>{:c=>3}, {:a=>1, :b=>2, :c=>3, :d=>4}=>"D"}

hash =  arr.each_with_object({}) do |sub_array, hash|
          hash[sub_array[0]] = sub_array[1]
        end

p hash == {:a=>1, "b"=>"two", "sea"=>{:c=>3}, {:a=>1, :b=>2, :c=>3, :d=>4}=>"D"}
