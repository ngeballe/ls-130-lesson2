module M;    end
class A
  include M
end
class B < A; end
class C < B; end

b = B.new

p b.is_a?(B) == true
p b.is_a?(C) == false
p b.is_a?(A) == true
p b.is_a?(M) == true

p b.kind_of?(B) == true
p b.kind_of?(C) == false
p b.kind_of?(A) == true
p b.kind_of?(M) == true

p b.instance_of?(B) == true
p b.instance_of?(A) == false
p b.instance_of?(C) == false
p b.instance_of?(M) == false

eb = "sexy Australian"
puts eb.is_a?(String) == true
# puts eb.class.ancestors

eb.class.ancestors.each { |class_name| puts eb.is_a?(class_name) == true }

p eb.class.ancestors.all? { |class_name| eb.kind_of?(class_name) }
p eb.class.ancestors.select { |class_name| eb.instance_of?(class_name) } == [eb.class]
