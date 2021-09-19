class Route
  def [](index)
    @stops[index]
  end

  def length
    @stops.length
  end

  def initialize(departure, arrival)
    @stops = [departure, arrival]
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
