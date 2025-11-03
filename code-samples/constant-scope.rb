class Base1
  C = "Base1::C"
end

class Class1 < Base1
  def c = C
end

puts "Class1#c is #{Class1.new.c}" # -> Class1#c is Base1::C

puts "Class1::C is #{Class1::C}"   # -> Class1::C is Base1::C

module Mod2
  C = "Mod2::C"
end

class Class2
  include Mod2

  def c = C
end
  
puts "Class2#c is #{Class2.new.c}" # -> Class2#c is Mod2::C

puts "Class2::C is #{Class2::C}"   # -> Class2::C is Mod2::C

module Prep3
  C = "Prep3::C"
end

class Class3
  prepend Prep3

  def c = C
end
  
puts "Class3#c is #{Class3.new.c}" # -> Class3#c is Prep3::C

puts "Class3::C is #{Class3::C}"   # -> Class3::C is Prep3::C

module Mod4
  C = "Mod4::C"
end

class Class4
  include Mod4

  C = "Class4::C"
  
  def c = C
end
  
puts "Class4#c is #{Class4.new.c}" # -> Class4#c is Class4::C

puts "Class4::C is #{Class4::C}"   # -> Class4::C is Class4::C

module Prep5
  C = "Prep5::C"
end

class Class5
  prepend Prep5

  C = "Class5::C"
  
  def c = C
end
  
puts "Class5#c is #{Class5.new.c}" # -> Class5#c is Class5::C !!!! prepends not searched before this class due to lexical scope?

puts "Class5::C is #{Class5::C}"   # -> Class5::C is Class5::C !!!! prepends not searched before this class due to lexical scope? Mmm, there's no lexical scope here??? I can only assume that the explicit scope is used as the lexical scope?

class Base6
  C = "Base6::C"
end

module Prep6
  C = "Prep6::C"
end

class Class6 < Base6
  prepend Prep6

  def c = C
end

puts "Class6#c is #{Class6.new.c}" # -> Class6#c is Prep6::C - OK not in (any) lexical scope, so method-style look-up then applies

puts "Class6::C is #{Class6::C}"   # -> Class6::C is Prep6::C

# ---

#puts "Class6::C::Bogus is #{Class6::C::Bogus}" # -> "Prep6::C" is not a class/module (TypeError)

# ---

class Class7
  C = "Class7::C"

  class ::Class8
    def c = C
  end
end

puts "Class8#c is #{Class8.new.c}" # -> Class8#c is Class7::C - lexical scope

#puts "Class8::C is #{Class8::C}"  # -> uninitialized constant Class8::C (NameError)

module Mod9
  C = "Mod9::C"
end

class Class9
  include Mod9

  class ::Class10
    def c = C
  end
end

#puts "Class10#c is #{Class10.new.c}" # -> uninitialized constant Class10::C (NameError) - lexical scope doesn't look in included modules

#puts "Class10::C is #{Class10::C}"   # -> uninitialized constant Class10::C (NameError)
