# frozen_string_literal: true

require_relative 'modules'

class Foo
  extend Accessors
  attr_accessor_with_history :x, :y
  strong_attr_accessor a: Integer, s: String
end

# attr_accessor_with_history' tests
f = Foo.new
f.x = 5
f.x = 7
f.x = 3
puts f.x_history.inspect
puts f.x

# strong_attr_accessor's tests
begin
  f.a = 'sad'
  f.a = :fsd
  f.s = 12
  f.s = :asd
rescue RuntimeError => e
  puts e.message
end

f.a = 12
puts f.a
f.s = 'asfasdf'
puts f.s
