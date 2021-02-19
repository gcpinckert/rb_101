# Given the following hash, turn it into an array containing only two elements:
# Barney's name and Barney's number

flintstones = { "Fred" => 0, 
                "Wilma" => 1, 
                "Barney" => 2, 
                "Betty" => 3, 
                "BamBam" => 4, 
                "Pebbles" => 5 }

flintstones = flintstones.to_a
flintstones = flintstones[2]
p flintstones

# Note: this can also be achieved simply with the Hash#assoc method:
flintstones = { "Fred" => 0, 
                "Wilma" => 1, 
                "Barney" => 2, 
                "Betty" => 3, 
                "BamBam" => 4, 
                "Pebbles" => 5 }

p flintstones.assoc("Barney")