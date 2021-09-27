require_relative 'modules.rb'

class Train
  include Manufacturer
  include InstanceCounter

  attr_accessor :speed
  attr_reader :type
  attr_reader :number
  alias_method :name, :number

  NUMBER_FORMAT = /^[\da-z]{3}-?[\da-z]{2}/i

  @@trains = []

  def self.find(number)
    @@trains.find { |train| train.number == number }
  end

  def initialize(number, type)
    @number = number
    validate_number!
    @type = type
    validate_type!
    @wagons = []
    @speed = 0
    @@trains << self
    register_instance
  end

  def stop
    @speed = 0
    "The #{@type} train #{@number} has been stopped"
  end

  def add_wagon(wagon)
    if @speed == 0
      if wagon.type == @type
        @wagons << wagon
        "Wagon has been added to #{@type} train #{@number}"
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
        "Wagon removed from #{@type} train #{@number}"
      else
        "The #{@type} train #{@number} has no wagons"
      end
    else
      "First stop the train!"
    end
  end

  def move_forward
    return "The train #{@number} has no route assigned" if @route == nil
    unless @current_position == @route.length - 1
      @current_position += 1
      previous_station.train_departure(self)
      current_station.train_arrive(self)
      "The #{@type} train #{@number} has moved to the #{current_station.name} station"
    else
      "The #{@type} train #{@number} is at the last station on the route, no way forward!"
    end
  end

  def move_backward
    return "The #{@type} train #{@number} has no route assigned" if @route == nil
    unless @current_position == 0
      @current_position -= 1
      next_station.train_departure(self)
      current_station.train_arrive(self)
      "The #{@type} train #{@number} has moved to the #{current_station.name} station"
    else
      "The #{@type} train #{@number} is at the starting point of the route, no way backward!"
    end
  end

  def take_route(route)
    current_station.train_departure(self) unless @route == nil
    @route = route
    @current_position = 0
    move_forward
    "The #{@type} train #{@number} has taken the route #{@route.name}"
  end

  # В контексте этого класса метод не имеет смысла, так как мы, по тз,
  # выбрасываем ислючения из конструктора. У нас просто не может быть
  # невалидного поезда.
  def valid?
    validate_number!
    validate_type!
    true
  rescue RuntimeError
    false
  end

  protected

  def validate_number!
    raise "Nil number error" if @number.nil?
    raise "Invalid number format" if @number !~ NUMBER_FORMAT
  end

  def validate_type!
    raise "Invalid train type" unless @type == "passenger" || type == "cargo"
  end

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
