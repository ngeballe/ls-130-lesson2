# is_a? & kind_of?
# instance_of?

class A;     end
class B < A; end
class C < B; end

b = B.new
puts b.instance_of?(A) == false
puts b.instance_of?(B) == true
puts b.instance_of?(C) == false

puts b.kind_of?(B) == true
