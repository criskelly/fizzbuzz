class HQ9F
  def initialize
    @numbers = (1..10).to_a
    @lambdas = []
  end
  attr_accessor :numbers, :lambdas

  include Enumerable

  def each
    @numbers.each {|x| yield x}
  end

  def push_lambda(x)
    lambdas.push x
  end

  def pop_lambda(x)
    lambdas.pop x
  end

  def f(min, max, subs)
    (min..max).each do |i|
      ret = ""

      subs.each_pair do |key, value|
        if i % key == 0
          ret << value
        end
      end

      if ret.empty?
        puts i
      else
        puts "#{i} #{ret}"
      end
    end
  end

  def self._99(x)
    x.downto(1).each do |y|
      puts "#{y} bottles of beer on the wall, #{y} bottles of beer. \nTake one down, pass it around, #{y-1} bottles of beer on the wall."
    end
  end
end

def hello
  puts "Hello World"
  print 'hi'
end

def hello2
  return "Hello World"
end

require 'minitest/autorun'
class TestHQ9F < MiniTest::Unit::TestCase
  def test_hello
    out, err = capture_io do
      hello
    end
    assert_equal("Hello World\nhi", out)
  end

  def test_hello2
    assert_equal("Hello World", hello2)
  end

  def test_fizz
    out, err = capture_io do
      HQ9F.new.f(1, 100, {3 => 'Fizz', 5 => 'Buzz'})
    end
    assert_match('Fizz', out)
  end

  def test_substitutions_substitute
    out, err = capture_io do
      HQ9F.new.f(1, 100, {})
    end
    assert_equal((1..100).to_a.join("\n")+"\n", out)
  end

  def test_fizz_buzz
    out, err = capture_io do
      HQ9F.new.f(1, 100, {3 => 'Fizz', 5 => 'Buzz'})
    end
    refute_match('14 FizzBuzz', out)
    assert_match('15 FizzBuzz', out)
  end

  def test_modulo_3_is_fizz
    out, err = capture_io do
      HQ9F.new.f(1, 100, {3 => 'Fizz', 5 => 'Buzz'})
    end
    assert_equal('3 Fizz', out.split("\n")[3-1])
    assert_equal('5 Buzz', out.split("\n")[5-1])
  end
end

require 'minitest/spec'
describe HQ9F do
  it "should have a hello2 method" do
    hello2.must_equal('Hello World')
  end

  # it "should say Fizz on 3" do
  #   ret = HQ9F.new.f(1, 100, {3 => 'Fizz', 5 => 'Buzz'})
  #   ret.must_match('3 Fizz')
  # end
end











