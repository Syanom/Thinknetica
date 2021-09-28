require_relative 'modules.rb'
require_relative 'train.rb'

class Station
  include InstanceCounter

  attr_reader :trains
  attr_reader :name

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    validate_name!
    @trains = []
    @@stations << self
    register_instance
  end

  # Метод не используется в программе, но прятать ее смысла не вижу, так как она явно
  # существует не для этого класса
  def list_of_type_trains(type)
    @trains.select { |train| train.type == type }
  end

  def train_arrive(train)
    validate_train!(train)
    @trains << train
  end

  def train_departure(train)
    validate_train!(train)
    @trains.delete(train)
  end

  def valid?
    validate_name!
    validate_trains!
    true
  rescue RuntimeError
    false
  end

  protected

  def validate_train!(train)
    raise "Invalid train" unless train.valid?
  end

  def validate_trains!
    trains.each { |train| raise "One of the trains is invalid" unless train.is_a?(Train) }
  end

  def validate_name!
    raise "Name can't be nil" if @name == nil
  end
end
