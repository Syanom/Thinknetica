class Station
  attr_reader :list_of_trains
  attr_reader :name

  def initialize(name)
    @name = name
    @list_of_trains = []
  end

  def train_arrive(train)
    @list_of_trains << train
  end

  def list_of_type_trains(type)
    @list_of_trains.select { |train| train.type == type }
  end

  def train_departure(train_to_delete)
    @list_of_trains.delete(train_to_delete)
  end
end
