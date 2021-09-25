require_relative 'modules.rb'

class Route
  include InstanceCounter
  attr_reader :name

  def [](index)
    @stations[index]
  end

  def length
    @stations.length
  end

  def initialize(name, departure, arrival)
    @name = name
    @stations = [departure, arrival]
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
    "Station #{station.name} added sucsessfully"
  end

  def remove_station(station)
    if station != @stations[0] && station != @stations[-1]
      @stations.delete(station) == station ?  "Station #{station.name} removed sucsessfully" : "Station #{station.name} is not in the route"
    else
      "You can't delete departure or arrival points!"
    end
  end

  # На данный момент эта функция нигде не используется, но убирать ее под протектед не имеет смысла
  def print_stations
    @stations.each { |station| print "#{station.name} " }
    puts ""
  end
end
