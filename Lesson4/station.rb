class Station
  attr_reader :list_of_trains
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_arrive(train)
    @trains << train
  end

  def list_of_type_trains(type)
    @trains.select { |train| train.type == type }
  end

  def train_departure(train)
    @trains.delete(train)
  end
end
