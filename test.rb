require 'bundler'
Bundler.setup(:default)

require 'qprof'
require 'matrix'

def fib1(n)
  n.times.each_with_object([0,1]) { |num, obj| obj << obj[-2] + obj[-1] }
end

def fib2(n)
  (Matrix[[1,1],[1,0]] ** n)[1,0]
end

def fib3(n)
  n <= 1 ? n : fib3( n - 1 ) + fib3( n - 2 )
end

raise 'incorrect!' unless QProf.call('fib1') { 25.times.map { |i| fib1(i) }.last.last } == 75025
raise 'incorrect!' unless QProf.call('fib2') { 25.times.map { |i| fib2(i) }.last.last } == 75025
raise 'incorrect!' unless QProf.call('fib3') { 25.times.map { |i| fib3(i) }.last.last } == 75025
