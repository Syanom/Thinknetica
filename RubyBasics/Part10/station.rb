# frozen_string_literal: true

require_relative 'modules'
require_relative 'train'

# Operating stations
class Station
  include InstanceCounter
  include Validation

  attr_reader :trains, :name

  validate :name, :presence

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
    register_instance
  end

  # Метод не используется в программе, но прятать ее смысла не вижу, так как она явно
  # существует не для этого класса
  def list_of_type_trains(type)
    trains.select { |train| train.type == type }
  end

  def train_arrive(train)
    validate_train!(train)
    trains << train
  end

  def train_departure(train)
    validate_train!(train)
    trains.delete(train)
  end

  def each_train(&block)
    trains.each(&block)
  end

  protected

  def validate_train!(train)
    raise 'Invalid train' unless train.valid?
  end
end
