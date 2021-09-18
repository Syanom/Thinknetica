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

class Route
  def [](index)
    @stops[index]
  end

  def length
    @stops.length
  end

  def initialize(departure, arrival)
    @stops = []
    @stops << departure << arrival
  end

  def add_station(stop)
    @stops.insert(-2, stop)
  end

  def remove_station(stop_to_delete)
    stop_to_delete != @stops[0] && stop_to_delete != @stops[-1] ? @stops.delete(stop_to_delete) : "You can't delete departure or arrival points!"
  end

  def print_stations
    @stops.each { |stop| print "#{stop.name} " }
    puts ""
  end
end

class Train
  attr_accessor :speed
  attr_reader :number_of_wagons
  attr_reader :type

  def initialize(number, type, number_of_wagons)
    @number = number
    @type = type
    @number_of_wagons = number_of_wagons
    @speed = 0
  end

  def stop
    @speed = 0
  end

  def add_wagon
    @speed == 0 ? @number_of_wagons += 1 : "First stop the train!"
  end

  def remove_wagon
    @speed == 0 && number_of_wagons != 0 ? @number_of_wagons -= 1 : "First stop the train / Make sure that train has at least one wagon"
  end

  def move_forward
    unless @current_position == @route.length - 1
      @route[@current_position].train_departure(self)
      @current_position += 1
      @route[@current_position].train_arrive(self)
    else
      "The train is at the last stop on the route, no way forward!"
    end
  end

  def move_backward
    unless @current_position == 0
      @route[@current_position].train_departure(self)
      @current_position -= 1
      @route[@current_position].train_arrive(self)
    else
      "The train is at the starting point of the route, no way backward!"
    end
  end

  def take_route(route)
    @route = route
    if @route[0].list_of_trains.include?(self)
      @current_position = 0
      move_forward
    else
      "The train isn't on the starting point of the route!"
    end
  end

  def current_station
    @route[@current_position]
  end

  def next_station
    @route[@current_position + 1]
  end

  def previous_station
    @route[@current_position - 1]
  end
end
