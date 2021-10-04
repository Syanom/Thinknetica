# frozen_string_literal: true

require_relative 'modules'

# Parent class for train's wagons
class Wagon
  include Manufacturer
  attr_reader :type, :id, :space, :taken_space

  alias name id

  def initialize(type, id, space, taken_space = 0)
    @type = type
    @id = id
    @space = space
    @taken_space = taken_space
  end

  def space_left?
    space - taken_space
  end

  def take_place
    raise 'Not implemended'
  end
end
