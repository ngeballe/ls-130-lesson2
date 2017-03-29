require 'pry'

require 'minitest/autorun'
require_relative 'pet_shelter'

class PetShelterTest < Minitest::Test
  def setup
    butterscotch = Pet.new('cat', 'Butterscotch')
    pudding      = Pet.new('cat', 'Pudding')
    darwin       = Pet.new('bearded dragon', 'Darwin')
    kennedy      = Pet.new('dog', 'Kennedy')
    sweetie      = Pet.new('parakeet', 'Sweetie Pie')
    molly        = Pet.new('dog', 'Molly')
    chester      = Pet.new('fish', 'Chester')

    @phanson = Owner.new('P Hanson')
    @bholmes = Owner.new('B Holmes')

    @shelter = Shelter.new
    @shelter.adopt(@phanson, butterscotch)
    @shelter.adopt(@phanson, pudding)
    @shelter.adopt(@phanson, darwin)
    @shelter.adopt(@bholmes, kennedy)
    @shelter.adopt(@bholmes, sweetie)
    @shelter.adopt(@bholmes, molly)
    @shelter.adopt(@bholmes, chester)
  end

  def permutations_to_regex(array)
    regex_pieces = array.permutation(array.size).map do |permutation|
      permutation.map { |line| "^#{line}$\n" }.join
    end
    regex_pieces.join('|')
  end

  def test_print_adoptions
    phanson_pets = ['a cat named Butterscotch',
                    'a cat named Pudding',
                    'a bearded dragon named Darwin']
    # phanson_permutations = phanson_pets.permutation(3).to_a
    bholmes_pets = ['a dog named Molly',
                    'a parakeet named Sweetie Pie',
                    'a dog named Kennedy',
                    'a fish named Chester']
    phanson_regex = permutations_to_regex(phanson_pets)
    bholmes_regex = permutations_to_regex(bholmes_pets)
    expected_output_regex = /\AP Hanson has adopted the following pets:$\n#{phanson_regex}^B Holmes has adopted the following pets:$\n#{bholmes_regex}/m
    assert_output(expected_output_regex) do
      @shelter.print_adoptions
    end
  end

  def test_puts_name_and_number
    assert_output("P Hanson has 3 adopted pets.\nB Holmes has 4 adopted pets.\n") do
      puts "#{@phanson.name} has #{@phanson.number_of_pets} adopted pets."
      puts "#{@bholmes.name} has #{@bholmes.number_of_pets} adopted pets."
    end
  end

  def test_add_unadopted_pets
    skip
    asta = Pet.new('dog', 'Asta')
    laddie = Pet.new('dog', 'Laddie')
    fluffy = Pet.new('cat', 'Fluffy')
    kat = Pet.new('cat', 'Kat')
    ben = Pet.new('cat', 'Ben')
    chatterbox = Pet.new('parakeet', 'Chatterbox')
    parakeet = Pet.new('parakeet', 'Bluebell')

    @shelter.add_unadopted(asta)
    @shelter.add_unadopted(laddie)
    @shelter.add_unadopted(fluffy)
    @shelter.add_unadopted(kat)
    @shelter.add_unadopted(ben)
    @shelter.add_unadopted(chatterbox)
    @shelter.add_unadopted(bluebell)

    # unadopted_pets = ['a dog named Asta',
    #                   'a dog named Laddie',
    #                   'a cat named Fluffy',
    #                   'a cat named Kat',
    #                   'a cat named Ben',
    #                   'a parakeet named Chatterbox',
    #                   'a parakeet named Bluebell']
    # unadopted_pets_regex = permutations_to_regex(unadopted_pets)
    # expected_output_regex = /^P Hanson has adopted the following pets:$\n#{phanson_regex}^B Holmes has adopted the following pets:$\n#{bholmes_regex}$/m

    # assert_output(old_expected_output_regex) do
    #   @shelter.print_adoptions
    # end

    # assert_output(expected_output_regex) do
    #   @shelter.print_adoptions
    # end
    # '''
    # The Animal Shelter has the following unadopted pets:
    # a dog named Asta
    # a dog named Laddie
    # a cat named Fluffy
    # a cat named Kat
    # a cat named Ben
    # a parakeet named Chatterbox
    # a parakeet named Bluebell
    #    ...

    # P Hanson has 3 adopted pets.
    # B Holmes has 4 adopted pets.
    # The Animal shelter has 7 unadopted pets.
    # '''
  end
end
