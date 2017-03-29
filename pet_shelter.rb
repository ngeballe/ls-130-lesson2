class Pet
  def initialize(animal, name)
    @animal = animal
    @name = name
  end

  def to_s
    "a #{@animal} named #{@name}"
  end
end

class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def to_s
    @name
  end

  def number_of_pets
    @pets.size
  end
end

class Shelter
  attr_reader :unadopted_pets

  def initialize
    @owners = []
    @unadopted_pets = []
  end

  def adopt(owner, pet)
    @owners << owner unless @owners.include?(owner)
    owner.pets << pet
  end

  def add_unadopted(pet)
    @unadopted_pets << pet
  end

  def print_adoptions
    puts "The shelter has the follwing unadopted pets:"
    puts @unadopted_pets
    puts

    @owners.each do |owner|
      puts "#{owner} has adopted the following pets:"
      puts owner.pets
      puts
    end
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)

asta = Pet.new('dog', 'Asta')
laddie = Pet.new('dog', 'Laddie')
fluffy = Pet.new('cat', 'Fluffy')
kat = Pet.new('cat', 'Kat')
ben = Pet.new('cat', 'Ben')
chatterbox = Pet.new('parakeet', 'Chatterbox')
bluebell = Pet.new('parakeet', 'Bluebell')

shelter.add_unadopted(asta)
shelter.add_unadopted(laddie)
shelter.add_unadopted(fluffy)
shelter.add_unadopted(kat)
shelter.add_unadopted(ben)
shelter.add_unadopted(chatterbox)
shelter.add_unadopted(bluebell)

shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "The animal shelter has #{shelter.unadopted_pets.size} unadopted pets."
