class A
  A1 = "a1"

  def self.am = "am"

  class B
    def self.bm = "bm"

    def a1 = A1

    def get_am = am

    def get_bm = bm
  end
end

puts A::B.new.a1 # -> "a1"
#puts A::B.new.get_am # -> undefined local variable or method `am' for an instance of A::B (NameError)
#puts A::B.new.get_bm # -> undefined local variable or method `bm' for an instance of A::B (NameError)
puts A.am # -> "am"
#puts A::B.am # -> undefined method `am' for class A::B (NoMethodError)

class C
  C1 = "c1"
  class ::D
    def c1 = C1
  end
end

puts D.new.c1 # -> "c1" !!! lexical scope???

class C
  C1 = "c1-new" # constant redefined error, but OK
end

D.new.c1 # -> "c1-new" !!! lexical scope???

class E
  E1 = "e1"
end

class E::F
  def e1 = E1
end

#puts E::F.new.e1 # -> uninitialized constant E::F::E1 (NameError) - not in lexical scope even tho it's defined in the enclosing class

class E
  class G
    def e1 = E1
  end
end

puts E::G.new.e1 # -> "e1"
