class A
  A1 = "a1"

  class B
    def a1 = A1
  end
end

class A::B
  def a1_no_dice = A1
end

puts A::B.new.a1
puts A::B.new.a1_no_dice
