names = ["John Wayne", "Wayne Wayne", "Wayne John", "John John", "Roland Wilson", "John"]

p names.select { |name| name =~ /(John|Wayne) [^\1]/ } #== ["John Wayne", "Wayne John"]

perms = %w(John Wayne).permutation(2).to_a
p perms

regex = Rege
