# frozen_string_literal: true

require_relative 'modules'

class Foo
  extend Accessors
  attr_accessor_with_history :x, :y
end

f = Foo.new
f.x = 5
f.x = 7
f.x = 3
puts f.x_history.inspect
puts f.x
