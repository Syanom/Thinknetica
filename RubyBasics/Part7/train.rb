require_relative 'modules.rb'
require_relative 'route.rb'

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
  end

  def add_wagon(wagon)
    raise "First stop the train!" if @speed != 0
    raise "Wrong wagon type" if wagon.type != @type
    @wagons << wagon
  end

  def remove_wagon
    raise "First stop the train!" if @speed != 0
    raise "The #{@type} train #{@number} has no wagons" if @wagons.length <= 0
    @wagons.pop
  end

  def move_forward
    raise "The train #{@number} has no route assigned" if @route == nil
    raise "The #{@type} train #{@number} is at the last station on the route, no way forward!" if @current_position == @route.length - 1
    @current_position += 1
    previous_station.train_departure(self)
    current_station.train_arrive(self)
  end

  def move_backward
    raise "The #{@type} train #{@number} has no route assigned" if @route == nil
    raise "The #{@type} train #{@number} is at the starting point of the route, no way backward!" if @current_position == 0
    @current_position -= 1
    next_station.train_departure(self)
    current_station.train_arrive(self)
  end

  def take_route(route)
    raise "Route is invalid" unless route.is_a?(Route)
    current_station.train_departure(self) unless @route == nil
    @route = route
    @current_position = 0
    move_forward
  end

  def valid?
    validate_number!
    validate_type!
    validate_wagons!
    validate_route!
    true
  rescue RuntimeError
    false
  end

  def current_station
    @route[@current_position]
  end

  def next_station
    @route[@current_position + 1] if @current_position != @route.length - 1
  end

  def previous_station
    @route[@current_position - 1] if @current_position != 0
  end

  protected

  def validate_number!
    raise "Nil number error" if @number.nil?
    raise "Invalid number format" if @number !~ NUMBER_FORMAT
  end

  def validate_type!
    raise "Invalid train type" unless @type == "passenger" || type == "cargo"
  end

  def validate_wagons!
    @wagons.each { |wagon| raise "Invalid wagon type" if wagon.type != @type }
  end

  def validate_route!
    if @route != nil
      raise "Route is invalid" unless @route.is_a?(Route)
    end
  end
end
