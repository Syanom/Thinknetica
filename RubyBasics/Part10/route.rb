# frozen_string_literal: true

require_relative 'modules'
require_relative 'station'

# Operating routes
class Route
  include InstanceCounter
  include Validation
  attr_reader :name

  validate :name, :presence

  def initialize(name, departure, arrival, *stations)
    @name = name
    @stations = [departure, arrival]
    @stations.insert(1, stations).flatten!
    validate!
    register_instance
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
    raise "Station #{station.name} is not in the route already" if @stations.delete(station).nil?
  end

  # На данный момент этот метод нигде не используется, но убирать ее под протектед не имеет смысла
  def print_stations
    @stations.each { |station| print "#{station.name} " }
    puts ''
  end

  protected

  def validate_station!(station)
    raise 'Invalid station object' unless station.is_a?(Station)
  end
end
