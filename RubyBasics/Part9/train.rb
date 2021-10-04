# frozen_string_literal: true

require_relative 'modules'
require_relative 'route'

# Parent class for operating trains. Don't use, use one of the subclasses.
class Train
  include Manufacturer
  include InstanceCounter

  attr_accessor :speed
  attr_reader :type, :number, :wagons

  alias name number

  NUMBER_FORMAT = /^[\da-z]{3}-?[\da-z]{2}/i.freeze

  @@trains = []

  def self.find(number)
    @@trains.find { |train| train.number == number }
  end

  def initialize(number, type, options = {})
    @number = number
    @type = type
    @wagons = options[:wagons] || []
    @speed = options[:speed] || 0
    @route = options[:route]
    @manufacturer = options[:manufacturer]
    validate!
    @@trains << self
    register_instance
  end

  def stop
    self.speed = 0
  end

  def add_wagon(wagon)
    raise 'First stop the train!' if speed != 0
    raise 'Wrong wagon type' if wagon.type != type

    wagons << wagon
  end

  def remove_wagon(wagon)
    raise 'First stop the train!' if speed != 0
    raise "The #{type} train #{number} has no wagons" if wagons.length <= 0
    raise 'No such wagon in the train' if wagons.delete(wagon).nil?
  end

  def move_forward
    raise "The #{type} train #{number} has no route assigned" if @route.nil?
    if @current_position == @route.length - 1
      raise "The #{type} train #{number} is at the last station on the route, no way forward!"
    end

    @current_position += 1
    previous_station.train_departure(self)
    current_station.train_arrive(self)
  end

  def move_backward
    raise "The #{type} train #{number} has no route assigned" if @route.nil?
    if @current_position.zero?
      raise "The #{type} train #{number} is at the starting point of the route, no way backward!"
    end

    @current_position -= 1
    next_station.train_departure(self)
    current_station.train_arrive(self)
  end

  def take_route(route)
    raise 'Route is invalid' unless route.is_a?(Route)

    current_station.train_departure(self) unless @route.nil?
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
    errors << 'Nil number error' if number.nil?
    errors << "Invalid number format: #{number}" if number !~ NUMBER_FORMAT
    errors << "Invalid train type: #{type}" unless type == 'passenger' || type == 'cargo'
    wagons.each { |wagon| errors << "Invalid wagon type #{wagon.type}. Expected #{type}" if wagon.type != type }
    errors << 'Route is invalid' unless @route.is_a?(Route) || @route.nil?
    raise errors.join('. ') unless errors.empty?
  end
end
