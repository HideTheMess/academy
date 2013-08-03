class Cat
  attr_accessor(:name, :color)
end

cat = Cat.new
cat.name = "Sally"
cat.color = "brown"
p cat.name # => "Sally"
p cat.color # => "brown"
