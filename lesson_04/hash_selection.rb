# - Use the given hash and create a method that selects:
# - all the key value-pairs where the value is 'Fruit'

def select_fruit(hash)
  keys = hash.keys
  counter = 0
  selected_kv_pairs = {}

  loop do
    break if counter >= hash.size
    current_key = keys[counter]
    current_value = hash[current_key]

    if current_value == 'Fruit'
      selected_kv_pairs.update({current_key => current_value})
    end

    counter += 1
  end

  selected_kv_pairs
end

produce = {
  'apple' => 'Fruit',
  'carrot' => 'Vegetable',
  'pear' => 'Fruit',
  'broccoli' => 'Vegetable'
}

p select_fruit(produce) # => {"apple"=>"Fruit", "pear"=>"Fruit"}