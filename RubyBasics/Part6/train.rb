require_relative 'modules.rb'

class Train
  include Manufacturer
  include InstanceCounter

  attr_accessor :speed
  attr_reader :type
  attr_reader :name

  @@trains = []

  def self.find(name)
    @@trains.find { |train| train.name == name }
  end

  def initialize(name, type)
    @name = name
    @type = type
    @wagons = []
    @speed = 0
    @@trains << self
    register_instance
  end

  def stop
    @speed = 0
    "The #{@type} train #{@name} has been stopped"
  end

  def add_wagon(wagon)
    if @speed == 0
      if wagon.type == @type
        @wagons << wagon
        "Wagon has been added to #{@type} train #{@name}"
      else
        "Wrong wagon type"
      end
    else
      "First stop the train!"
    end
  end

  def remove_wagon
    if @speed == 0
      if @wagons.length > 0
        @wagons.pop
        "Wagon removed from #{@type} train #{@name}"
      else
        "The #{@type} train #{@name} has no wagons"
      end
    else
      "First stop the train!"
    end
  end

  def move_forward
    return "The train #{@name} has no route assigned" if @route == nil
    unless @current_position == @route.length - 1
      @current_position += 1
      previous_station.train_departure(self)
      current_station.train_arrive(self)
      "The #{@type} train #{@name} has moved to the #{current_station.name} station"
    else
      "The #{@type} train #{@name} is at the last station on the route, no way forward!"
    end
  end

  def move_backward
    return "The #{@type} train #{@name} has no route assigned" if @route == nil
    unless @current_position == 0
      @current_position -= 1
      next_station.train_departure(self)
      current_station.train_arrive(self)
      "The #{@type} train #{@name} has moved to the #{current_station.name} station"
    else
      "The #{@type} train #{@name} is at the starting point of the route, no way backward!"
    end
  end

  def take_route(route)
    @route = route
    @current_position = 0
    move_forward
    "The #{@type} train #{@name} has taken the route #{@route.name}"
  end

  protected

  def current_station
    @route[@current_position]
  end

  def next_station
    @current_position != @route.length - 1 ? @route[@current_position + 1] : "Train is at last point of the route"
  end

  def previous_station
    @current_position != 0 ? @route[@current_position - 1] : "Train is at first station in the route"
  end
end
