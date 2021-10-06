# frozen_string_literal: true

require_relative 'train'
require_relative 'cargo_wagon'
require_relative 'modules'

# For operating cargo trains
class CargoTrain < Train
  include Validation

  validate :number, :presence
  validate :number, :format, /^[\da-z]{3}-?[\da-z]{2}/i
  validate :type, :format, /(cargo)/

  def initialize(number)
    super(number, 'cargo')
    validate!
  end
end
