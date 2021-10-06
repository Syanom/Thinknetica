# frozen_string_literal: true

require_relative 'modules'

class TestClass
  extend Accessors
  include Validation
  attr_accessor_with_history :x, :y
  validate :x, :presence
  validate :x, :type, Integer
  validate :y, :presence
  validate :y, :type, String
  validate :y, :format, /^[\da-z]{3}-?[\da-z]{2}/i
  strong_attr_accessor a: Integer, s: String
end

f = TestClass.new
puts "attr_accessor_with_history' tests begin"
f.x = 5
f.x = 7
f.x = 3
puts f.x_history.inspect
puts f.x
f.y = 'asd'
f.y = 'asokd'
puts f.y_history.inspect
puts f.y
puts "attr_accessor_with_history' tests end"
puts "strong_attr_accessor's tests begin"
begin
  # f.a = 'sad'
  # f.a = :fsd
  # f.s = 12
  f.s = :asd
rescue RuntimeError => e
  puts e.message
end
f.a = 12
puts f.a
f.s = 'asfasdf'
puts f.s
puts "strong_attr_accessor's tests end"

# f.x = nil
# f.y = ''
# f.x = 'asdasd'
# f.y = 12
f.y = '12345'
# f.validate!
puts f.valid?
