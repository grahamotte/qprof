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

QProf.call('fib 1') { 25.times { |i| fib1(i) } }
QProf.call('fib 2') { 25.times { |i| fib2(i) } }
QProf.call('fib 3') { 25.times { |i| fib3(i) } }
