# frozen_string_literal: true

require_relative 'train'
require_relative 'passenger_wagon'

# For operating passenger trains
class PassengerTrain < Train
  include Validation

  validate :number, :presence
  validate :number, :format, /^[\da-z]{3}-?[\da-z]{2}/i
  validate :type, :format, /(passenger)/

  def initialize(name)
    super(name, 'passenger')
    validate!
  end
end
