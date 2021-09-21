class Route
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
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    station != @stations[0] && station != @stations[-1] ? @stations.delete(station) : "You can't delete departure or arrival points!"
  end

  def print_stations
    @stations.each { |station| print "#{station.name} " }
    puts ""
  end
end
