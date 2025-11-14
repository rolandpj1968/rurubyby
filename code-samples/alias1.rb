# From Google AI
class Parent
  def original_method
    "From Parent"
  end
end

class Child < Parent
  def another_method
    "From Child"
  end

  alias :aliased_parent_method :original_method # Aliases a method from the parent
  alias :aliased_child_method :another_method   # Aliases a method from the current class
end

child_instance = Child.new
puts child_instance.aliased_parent_method # Output: From Parent
puts child_instance.aliased_child_method  # Output: From Child

class A; def ma = "hallo"; end; class B < A; alias :mb :ma; end; puts B.new.mb; puts A.new.mb # the last statement throws NoMethodError
