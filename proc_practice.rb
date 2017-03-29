# require 'pry'

def select_map(array, select_proc, map_proc)
  # selected = array.each_with_object([]) do |item, object|
  #   object << item if select_proc.call(item)
  # end
  selected = array.select { |item| select_proc.call(item) }
  selected.map { |item| map_proc.call(item) }
end

def map_select(array, map_proc, select_proc)
  mapped = array.map { |item| map_proc.call(item) }
  mapped.select { |item| select_proc.call(item) }
end

a = [*1..10]

# p select_map(a, proc { |n| n.odd? }, proc { |n| n**2 }) == [1, 9, 25, 49, 81]

# letters = [*'a'..'z']
# uppercase_if_vowel = select_map(letters, proc { |letter| letter =~ /[aeiou]/ }, proc { |letter| letter.upcase })
# p uppercase_if_vowel == %w(A E I O U)

cube = Proc.new { |num| num ** 3}
less_than_100 = Proc.new { |num| num < 100 }

def less_than(limit)
  Proc.new { |num| num < limit }
end

p map_select(a, cube, less_than(100)) == [1, 8, 27, 64]

