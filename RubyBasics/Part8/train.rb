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
    @type = type
    @wagons = []
    @speed = 0
    validate!
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
    raise "The #{@type} train #{@number} has no route assigned" if @route == nil
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
    validate!
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

  def each_wagon(&block)
    wagons.each(&block)
  end

  protected

  def validate!
    errors = []
    errors << "Nil number error" if @number.nil?
    errors << "Invalid number format: #{@number}" if @number !~ NUMBER_FORMAT
    errors << "Invalid train type: #{@type}" unless @type == "passenger" || type == "cargo"
    @wagons.each { |wagon| errors << "Invalid wagon type #{wagon.type}. Expected #{@type}" if wagon.type != @type }
    errors << "Route is wrong class" unless @route.is_a?(Route) || @route == nil
    raise errors.join(". ") unless errors.empty?
  end
end
