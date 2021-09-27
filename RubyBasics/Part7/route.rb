require_relative 'modules.rb'
require_relative 'station.rb'

class Route
  include InstanceCounter
  attr_reader :name

  def initialize(name, departure, arrival)
    validate_station!(departure)
    validate_station!(arrival)
    @name = name
    @stations = [departure, arrival]
    register_instance
  end

  def valid?
    validate_name!
    validate_stations!
  end

  def [](index)
    @stations[index]
  end

  def length
    @stations.length
  end

  def add_station(station)
    validate_station!(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    validate_station!(station)
    raise "You can't delete departure or arrival station" if station == @stations[0] || station == @stations[-1]
    raise "Station #{station.name} is not in the route already" if @stations.delete(station) == nil
  end

  # На данный момент этот метод нигде не используется, но убирать ее под протектед не имеет смысла
  def print_stations
    @stations.each { |station| print "#{station.name} " }
    puts ""
  end

  protected

  def validate_station!(station)
    raise "Invalid station object" unless station.is_a?(Station)
  end

  def validate_name!
    raise "Name can't be nil" if @name == nil
  end

  def validate_stations!
    raise "Route must have at least 2 stations" if @stations.length < 2
    @stations.each { |station| raise "Station in route is invalid" unless station.is_a?(Station) }
  end
end
