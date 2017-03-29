class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    # @name.upcase!
    # "My name is #{@name}."
    "My name is #{@name.upcase}."
  end
end

# name = 'Fluffy'
# fluffy = Pet.new(name)
# puts fluffy.name # Fluffy
# puts fluffy # My name is FLUFFY.
# puts fluffy.name # FLUFFY
# puts name # Fluffy -- no, FLUFFY

# name = 42
# fluffy = Pet.new(name) # <# Pet @name = '42' >
# name += 1 # name = 43
# puts fluffy.name # '42'
# puts fluffy # My name is 42.
# puts fluffy.name # 42
# puts name # 43

name = "Bob"
pet = Pet.new(name)
name += "fred"
p pet
