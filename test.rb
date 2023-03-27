require 'bundler'
Bundler.setup(:default)

require 'qprof'
require 'matrix'

def fib1(n)
  (n-1).times.each_with_object([0, 1]) { |_num, obj| obj << obj[-2] + obj[-1] }.last
end

def fib2(n)
  (Matrix[[1, 1], [1, 0]]**n)[1, 0]
end

def fib3(n)
  n <= 1 ? n : fib3(n - 1) + fib3(n - 2)
end

def fib4(n)
  @cache ||= [0, 1]
  return n if (0..1).include?(n)

  (@cache[n] ||= fib4(n - 1) + fib4(n - 2))
end

def fib5(n)
  a = (1 + Math.sqrt(5)) / 2
  b = (1 - Math.sqrt(5)) / 2
  (((a ** n) - (b ** n)) / Math.sqrt(5)).round
end

def fib6(n)
  f = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987, 1597, 2584, 4181, 6765, 10946, 17711, 28657, 46368, 75025]

  loop do
    break if [true, false, false, false, false, false].sample
  end

  return f[n]
end

(1..6).each do |n|
  result = QProf.call("Fib ##{n}") { 26.times.map { |i| send("fib#{n}", i) }.last }
  raise "fib#{n}: expected 75025, got #{result}" unless result == 75025
end
