def fibonacci(n)
  if n <= 1
    n
  else
    fibonacci(n - 1) + fibonacci(n - 2)
  end
end

N = 38

puts "fibonacci(#{N}) is #{fibonacci(N)}"
