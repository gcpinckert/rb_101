# Does the given code change the Munster family data?

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def mess_with_demographics(demo_hash)
  demo_hash.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
end

mess_with_demographics(munsters)

p munsters

# Yes, the data will be changed. Because we are working with individual
# elements of a collection, here, and reassigning only those individual
# elements, the changes will be reflected in the munsters hash, which is
# mutated by the method. Though the object id for each key and value may
# be different, the munsters hash object id, which gets passed to demo_hash
# does not get reassigned, so the actual hash object being modified is the
# original musnters hash. 