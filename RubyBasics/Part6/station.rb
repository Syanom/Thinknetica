require_relative 'modules.rb'

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
    @trains = []
    @@stations << self
    register_instance
  end

  # Метод не используется в программе, но прятать ее смысла не вижу, так как оня явно
  # существует не для этого класса
  def list_of_type_trains(type)
    @trains.select { |train| train.type == type }
  end

  def train_arrive(train)
    @trains << train
  end

  def train_departure(train)
    @trains.delete(train)
  end
end
