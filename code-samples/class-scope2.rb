class A
end

class B
  def a1_no_dice = A1
end

class A
  class ::B
    def a1 = A1
  end
end

class A
  A1 = "a1"
end

puts B.new.a1
puts B.new.a1_no_dice
