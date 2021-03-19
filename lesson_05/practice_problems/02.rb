# Order the given array of hashes based on the year of book publication
# Order should go from earliest to latest publication

# Iterate through the array, for each sub-hash
  # Isolate the value for key 'published'
  # Convert the value to an integer
  # Sort based on the above value

books = [
  {title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967'},
  {title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925'},
  {title: 'War and Peace', author: 'Leo Tolstoy', published: '1869'},
  {title: 'Ulysses', author: 'James Joyce', published: '1922'}
]

p books.sort_by { |sub_hash| sub_hash[:published].to_i }
