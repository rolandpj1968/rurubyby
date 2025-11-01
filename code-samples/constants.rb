class C
  def m
    THE_CONSTANT
  end

  def m2
    C2::THE_CONSTANT_2
  end

  THE_CONSTANT = "foo"
end

class C2
  THE_CONSTANT_2 = "bar"
end

puts C.new.m

puts C.new.m2()

