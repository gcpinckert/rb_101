# Add multiple items (Dino & Hoppy) to the given array

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

flintstones += %w(Dino Hoppy)

p flintstones

# Chain push methods together
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.push("Dino").push("Hoppy")

p flintstones

# Use Array#concat
flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones.concat(%w(Dino Hoppy))

p flintstones
