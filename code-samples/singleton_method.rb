class MyClass
end

o = MyClass.new

def o.singleton_method
  "value"
end

puts "o.class.name: #{o.class.name.inspect}" # MyClass
puts "o.singleton_class.name: #{o.singleton_class.name.inspect}" # nil!!!
puts "o.singleton_class.superclass.name: #{o.singleton_class.superclass.name.inspect}" # MyClass
